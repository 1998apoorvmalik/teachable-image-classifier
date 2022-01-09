part of 'object_classification_cubit.dart';

enum ClassificationStateStatus { initial, loading, error }

@immutable
class ClassificationState {
  final List<ObjectClassificationClass> classes;
  final ClassificationStateStatus status;
  final Failure failure;
  final List<String> logs;
  final ClassificationBaseModel baseModel;
  final ModelLossFunction lossFunction;
  final ModelOptimizer modelOptimizer;
  final bool augEnabled;
  final int augBatchSize;
  final int epochs;
  final int trainBatchSize;
  final int learningRate;

  ClassificationState({
    required this.classes,
    required this.status,
    required this.failure,
    required this.logs,
    this.baseModel = ClassificationBaseModel.InceptionV3,
    this.lossFunction = ModelLossFunction.categorical_crossentropy,
    this.modelOptimizer = ModelOptimizer.Adam,
    this.augEnabled = true,
    this.augBatchSize = 1,
    this.epochs = 16,
    this.trainBatchSize = 16,
    this.learningRate = 1,
  });

  factory ClassificationState.initial() => ClassificationState(
      classes: [
        ObjectClassificationClass(className: 'Class 1'),
        ObjectClassificationClass(className: 'Class 2'),
        ObjectClassificationClass(className: 'Class 3', isEnabled: false),
        ObjectClassificationClass(className: 'Class 4', isEnabled: false)
      ],
      status: ClassificationStateStatus.initial,
      failure: Failure(),
      logs: <String>[]);

  int get numOfClasses => classes.length;

  ClassificationState copyWith({
    List<ObjectClassificationClass>? classes,
    ClassificationStateStatus? status,
    Failure? failure,
    List<String>? logs,
    ClassificationBaseModel? baseModel,
    ModelLossFunction? lossFunction,
    ModelOptimizer? modelOptimizer,
    bool? augEnabled,
    int? augBatchSize,
    int? epochs,
    int? trainBatchSize,
    int? learningRate,
  }) {
    return ClassificationState(
      classes: classes ?? this.classes,
      status: status ?? this.status,
      failure: failure ?? this.failure,
      logs: logs ?? this.logs,
      baseModel: baseModel ?? this.baseModel,
      lossFunction: lossFunction ?? this.lossFunction,
      modelOptimizer: modelOptimizer ?? this.modelOptimizer,
      augEnabled: augEnabled ?? this.augEnabled,
      augBatchSize: augBatchSize ?? this.augBatchSize,
      epochs: epochs ?? this.epochs,
      trainBatchSize: trainBatchSize ?? this.trainBatchSize,
      learningRate: learningRate ?? this.learningRate,
    );
  }
}
