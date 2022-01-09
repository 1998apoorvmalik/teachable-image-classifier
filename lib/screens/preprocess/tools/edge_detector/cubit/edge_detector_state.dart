part of 'edge_detector_cubit.dart';

@immutable
class EdgeDetectorState {
  EdgeDetectorState({
    required this.enabled,
    required this.edgeDetectorType,
    required this.threshold1,
    required this.threshold2,
    required this.apertureSize,
    required this.useL2Gradient,
    required this.dDepth,
    required this.kSize,
    required this.scale,
    required this.delta,
  });

  factory EdgeDetectorState.initial() => EdgeDetectorState(
        enabled: false,
        edgeDetectorType: EdgeDetectorType.canny,
        threshold1: 100,
        threshold2: 50,
        apertureSize: 3,
        useL2Gradient: false,
        dDepth: 16,
        kSize: 1,
        scale: 1,
        delta: 0,
      );

  // Canny Edge Parameters.
  final bool enabled;
  final EdgeDetectorType edgeDetectorType;
  final double threshold1;
  final double threshold2;
  final int apertureSize;
  final bool useL2Gradient;

  // Laplacian Parameters.
  final int dDepth;
  final int kSize;
  final double scale;
  final double delta;

  EdgeDetectorState copyWith({
    bool? isEnabled,
    EdgeDetectorType? edgeDetectorType,
    double? threshold1,
    double? threshold2,
    int? apertureSize,
    bool? useL2Gradient,
    int? dDepth,
    int? kSize,
    double? scale,
    double? delta,
  }) {
    return EdgeDetectorState(
      enabled: isEnabled ?? this.enabled,
      edgeDetectorType: edgeDetectorType ?? this.edgeDetectorType,
      threshold1: threshold1 ?? this.threshold1,
      threshold2: threshold2 ?? this.threshold2,
      apertureSize: apertureSize ?? this.apertureSize,
      useL2Gradient: useL2Gradient ?? this.useL2Gradient,
      dDepth: dDepth ?? this.dDepth,
      kSize: kSize ?? this.kSize,
      scale: scale ?? this.scale,
      delta: delta ?? this.delta,
    );
  }

  get toMap => <String, dynamic>{
        'enabled': enabled,
        'edge_detector_type': edgeDetectorType.toString().split('.')[1],
        'threshold1': threshold1,
        'threshold2': threshold2,
        'aperture_size': apertureSize,
        'useL2Gradient': useL2Gradient,
        'dDepth': dDepth,
        'kSize': kSize,
        'scale': scale,
        'delta': delta,
      };
}
