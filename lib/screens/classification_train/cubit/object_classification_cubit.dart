import 'dart:io';

import 'package:flutter/material.dart';
import 'package:teachable_image_classifier/config/socket_provider.dart';
import 'package:teachable_image_classifier/enums.dart';
import 'package:teachable_image_classifier/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachable_image_classifier/config/extensions.dart';

part 'object_classification_state.dart';

class ClassificationCubit extends Cubit<ClassificationState> {
  ClassificationCubit() : super(ClassificationState.initial());

  void onLog(
      {required String log,
      ClassificationStateStatus status = ClassificationStateStatus.initial,
      bool startNewLine = false}) {
    DateTime now = DateTime.now();
    String _convertedDateTime =
        "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}-${now.minute.toString().padLeft(2, '0')}";
    emit(state.copyWith(
        logs: state.logs
          ..add((startNewLine ? '\n' : '') + _convertedDateTime + ' : ' + log),
        status: status));
  }

  void clearLog() {
    emit(state.copyWith(logs: []));
  }

  void addClass() {
    emit(state.copyWith(
        classes: state.classes
          ..add(ObjectClassificationClass(
              className: 'Class ${state.numOfClasses + 1}')),
        status: ClassificationStateStatus.initial));
  }

  void deleteClass(int classIndex) {
    state.classes.removeAt(classIndex);
    emit(state.copyWith(
        classes: state.classes, status: ClassificationStateStatus.initial));
  }

  void changeClassName(
      {required int classIndex, required String newClassName}) {
    if (newClassName.isNotEmpty) {
      state.classes[classIndex].changeClassName(newClassName);
      emit(state.copyWith(
          classes: state.classes, status: ClassificationStateStatus.initial));
    }
  }

  void toggleEnable(int classIndex) {
    state.classes[classIndex].toggleEnable();
    emit(state.copyWith(
        classes: state.classes, status: ClassificationStateStatus.initial));
  }

  void addFiles({required int classIndex, required List<File> files}) {
    state.classes[classIndex].addSamples(files);
    emit(state.copyWith(
        classes: state.classes, status: ClassificationStateStatus.initial));
  }

  void deleteSample({required int classIndex, required File imageFile}) {
    final int _sampleIndex = state.classes[classIndex].samples
        .indexWhere((element) => element.path == imageFile.path);
    state.classes[classIndex].deleteSample(_sampleIndex);
    emit(state.copyWith(
        classes: state.classes, status: ClassificationStateStatus.initial));
  }

  void clearSamples(int classIndex) {
    if (state.classes[classIndex].samples.isNotEmpty) {
      state.classes[classIndex].clearSamples();
      emit(state.copyWith(
          classes: state.classes, status: ClassificationStateStatus.initial));
    }
  }

  void toggleEnableAug() {
    emit(state.copyWith(
        augEnabled: !state.augEnabled,
        status: ClassificationStateStatus.initial));
  }

  void changeAugBatchSize(int newValue) {
    emit(state.copyWith(
        augBatchSize: newValue, status: ClassificationStateStatus.initial));
  }

  void changeBaseModel(ClassificationBaseModel newValue) {
    emit(state.copyWith(
        baseModel: newValue, status: ClassificationStateStatus.initial));
  }

  void changeLossFunction(ModelLossFunction newValue) {
    emit(state.copyWith(
        lossFunction: newValue, status: ClassificationStateStatus.initial));
  }

  void changeOptimizer(ModelOptimizer newValue) {
    emit(state.copyWith(
        modelOptimizer: newValue, status: ClassificationStateStatus.initial));
  }

  void changeEpochs(int newValue) {
    emit(state.copyWith(
        epochs: newValue, status: ClassificationStateStatus.initial));
  }

  void changeTrainingBatchSize(int newValue) {
    emit(state.copyWith(
        trainBatchSize: newValue, status: ClassificationStateStatus.initial));
  }

  void changeLearningRate(int newValue) {
    emit(state.copyWith(
        learningRate: newValue, status: ClassificationStateStatus.initial));
  }

  void train({required BuildContext context}) {
    onLog(
        log: '[INFO] Training Started',
        status: ClassificationStateStatus.loading,
        startNewLine: true);
    try {
      Map<String, dynamic> data = {
        "object_classes": state.classes
            .where((element) => element.isEnabled)
            .toList()
            .map((ObjectClassificationClass objectClass) => objectClass.toJson)
            .toList(),
        "aug_enabled": state.augEnabled,
        "aug_batch_size": state.augBatchSize,
        "epochs": state.epochs,
        "train_batch_size": state.trainBatchSize,
        "learning_rate": state.learningRate / 1000,
      };

      context
          .read<SocketProvider>()
          .socket
          .emit('train_object_classification_model', data);
    } catch (err) {
      emit(state.copyWith(
          status: ClassificationStateStatus.error,
          failure: Failure(message: 'Unknown Error')));
    }

    onLog(
        log: '[INFO] Model Training, Please Wait...',
        status: ClassificationStateStatus.loading);

    context
        .read<SocketProvider>()
        .socket
        .once('object_classification_train_log', (data) {
      onLog(log: "[INFO] Model training successfully completed.");
    });

    context
        .read<SocketProvider>()
        .socket
        .on('predict_object_classification_model', (data) {
      print('Predicting');

      onLog(log: "[INFO] Predicted label is: " + data.toString());
    });

    context.read<SocketProvider>().socket.once('error', (data) {
      emit(state.copyWith(
          status: ClassificationStateStatus.error,
          failure: Failure(message: data.toString().capitalize())));
    });
  }

  void predict({required BuildContext context, File? file}) {
    if (file != null) {
      context.read<SocketProvider>().socket.emit(
          'predict_object_classification_model',
          {'use_camera': false, 'img_path': file.path});
    } else {
      print('Use Dir');
    }
  }
}
