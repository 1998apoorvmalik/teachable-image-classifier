part of 'preprocess_cubit.dart';

class PreprocessState extends Equatable {
  PreprocessState({
    this.selectedImagePath,
    this.processedImagePath,
    this.selectedTool,
    this.findContours = false,
  });

  final PreprocessTool? selectedTool;
  final String? selectedImagePath;
  final String? processedImagePath;
  final bool findContours;

  factory PreprocessState.initial() => PreprocessState();

  @override
  List<Object?> get props =>
      [selectedTool, selectedImagePath, processedImagePath, findContours];

  @override
  bool get stringify => true;

  PreprocessState copyWith({
    PreprocessTool? selectedTool,
    String? selectedImagePath,
    String? processedImagePath,
    bool? findContours,
  }) {
    return PreprocessState(
      selectedTool: selectedTool ?? this.selectedTool,
      selectedImagePath: selectedImagePath ?? this.selectedImagePath,
      processedImagePath: processedImagePath ?? this.processedImagePath,
      findContours: findContours ?? this.findContours,
    );
  }
}
