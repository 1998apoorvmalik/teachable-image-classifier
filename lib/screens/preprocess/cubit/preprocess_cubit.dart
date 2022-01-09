import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachable_image_classifier/config/socket_provider.dart';
import 'package:teachable_image_classifier/enums.dart';
import 'package:teachable_image_classifier/screens/preprocess/tools/tools.dart';

part 'preprocess_state.dart';

const String kDefaultImagePath =
    '/Users/apoorvmalik/Desktop/marj/Vision Inspection System/archive/sample_images/sample_part_02.jpg';

class PreprocessCubit extends Cubit<PreprocessState> {
  PreprocessCubit() : super(PreprocessState.initial());

  void changeSelectedTool(PreprocessTool tool) {
    emit(state.copyWith(selectedTool: tool));
  }

  void toggleFindContours() async {
    emit(state.copyWith(findContours: !state.findContours));
  }

  void reloadImage() {
    emit(state.copyWith(processedImagePath: state.selectedImagePath));
  }

  void resetImage() {
    print('[INFO] Resetting image.');
    emit(state.copyWith(processedImagePath: ''));
    print(state.selectedImagePath);
  }

  void loadDefaultImage() {
    emit(state.copyWith(processedImagePath: kDefaultImagePath));
  }

  void loadImage(String path) {
    print('[INFO] Loading image.');
    if (state.selectedImagePath == null) {
      emit(state.copyWith(selectedImagePath: path));
    }
    emit(state.copyWith(processedImagePath: state.processedImagePath));
  }

  void preprocess({required BuildContext context}) {
    Map<String, dynamic> data = {
      "file_path": state.selectedImagePath,
      "blur_enabled": context.read<BlurCubit>().state.enabled,
      "blur_parameters": context.read<BlurCubit>().state.toMap,
      "threshold_enabled": context.read<ThresholdCubit>().state.enabled,
      "threshold_parameters": context.read<ThresholdCubit>().state.toMap,
      "edge_detector_enabled": context.read<EdgeDetectorCubit>().state.enabled,
      "edge_detector_parameters": context.read<EdgeDetectorCubit>().state.toMap,
    };

    context.read<SocketProvider>().socket.send([data]);

    context.read<SocketProvider>().socket.once('message', (data) {
      loadImage(data as String);
    });
  }
}
