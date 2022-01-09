part of 'threshold_cubit.dart';

@immutable
class ThresholdState {
  const ThresholdState({
    required this.enabled,
    required this.useOtsu,
    required this.thresholdCategory,
    required this.thresholdType,
    required this.adaptiveThresholdMethod,
    required this.lowerThreshValue,
    required this.upperThreshValue,
    required this.maxValue,
    required this.blockSize,
    required this.constantC,
  });

  final bool enabled;
  final bool useOtsu;
  final ThresholdCategory thresholdCategory;
  final ThresholdType thresholdType;
  final AdaptiveThresholdMethod adaptiveThresholdMethod;
  final double lowerThreshValue;
  final double upperThreshValue;
  final double maxValue;
  final int blockSize;
  final double constantC;

  factory ThresholdState.initial() => ThresholdState(
        enabled: false,
        useOtsu: false,
        thresholdCategory: ThresholdCategory.simple,
        thresholdType: ThresholdType.binary,
        adaptiveThresholdMethod: AdaptiveThresholdMethod.gaussian,
        lowerThreshValue: 50,
        upperThreshValue: 100,
        maxValue: 255,
        blockSize: 5,
        constantC: 2,
      );

  ThresholdState copyWith({
    bool? enabled,
    bool? useOtsu,
    ThresholdCategory? thresholdCategory,
    ThresholdType? thresholdType,
    AdaptiveThresholdMethod? adaptiveThresholdMethod,
    double? lowerThreshValue,
    double? upperThreshValue,
    double? maxValue,
    int? blockSize,
    double? constantC,
  }) {
    return ThresholdState(
      enabled: enabled ?? this.enabled,
      useOtsu: useOtsu ?? this.useOtsu,
      thresholdCategory: thresholdCategory ?? this.thresholdCategory,
      thresholdType: thresholdType ?? this.thresholdType,
      adaptiveThresholdMethod:
          adaptiveThresholdMethod ?? this.adaptiveThresholdMethod,
      lowerThreshValue: lowerThreshValue ?? this.lowerThreshValue,
      upperThreshValue: upperThreshValue ?? this.upperThreshValue,
      maxValue: maxValue ?? this.maxValue,
      blockSize: blockSize ?? this.blockSize,
      constantC: constantC ?? this.constantC,
    );
  }

  get toMap => <String, dynamic>{
        'use_otsu': useOtsu,
        'threshold_category': thresholdCategory.toString().split('.').last,
        'threshold_type': thresholdType.toString().split('.').last,
        'adaptive_threshold_method':
            adaptiveThresholdMethod.toString().split('.').last,
        'lower_thresh_value': lowerThreshValue,
        'upper_thresh_value': upperThreshValue,
        'max_value': maxValue,
        'block_size': blockSize,
        'constant_c': constantC,
      };
}
