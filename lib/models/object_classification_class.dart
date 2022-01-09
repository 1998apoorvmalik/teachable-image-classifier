import 'dart:io';

class ObjectClassificationClass {
  ObjectClassificationClass({
    required this.className,
    this.isEnabled = true,
    this.samples = const <File>[],
  });

  String className;
  bool isEnabled;
  List<File> samples;

  int get numOfSamples => samples.length;

  void changeClassName(String newName) {
    className = newName;
  }

  void toggleEnable() {
    isEnabled = !isEnabled;
  }

  void addSamples(List<File> newSamples) {
    samples += newSamples;
  }

  void deleteSample(int sampleIndex) {
    samples.removeAt(sampleIndex);
  }

  void clearSamples() {
    samples.clear();
  }

  Map<String, dynamic> get toJson => {
        'name': className,
        'isEnabled': isEnabled,
        'sample_paths': samples.map((File sample) => sample.path).toList(),
      };

  ObjectClassificationClass copyWith({
    String? className,
    List<File>? samples,
  }) {
    return ObjectClassificationClass(
      className: className ?? this.className,
      samples: samples ?? this.samples,
    );
  }
}
