part of 'blur_cubit.dart';

@immutable
class BlurState {
  BlurState({
    required this.enabled,
    required this.blurType,
    required this.kSize,
    required this.diameter,
    required this.sigmaColor,
    required this.sigmaSpace,
    required this.sigmaX,
    required this.sigmaY,
  });
  final bool enabled;
  final BlurType blurType;
  final int kSize;
  final int diameter;
  final double sigmaColor;
  final double sigmaSpace;
  final double sigmaX;
  final double sigmaY;

  factory BlurState.initial() => BlurState(
      enabled: false,
      blurType: BlurType.average,
      kSize: 5,
      diameter: 3,
      sigmaColor: 75,
      sigmaSpace: 75,
      sigmaX: 5,
      sigmaY: 5);

  BlurState copyWith({
    bool? enabled,
    BlurType? blurType,
    int? kSize, // Aperture Linear Size.
    int?
        diameter, // Diameter of each pixel neighborhood that is used during filtering. Only for Bilateral Filter type.
    double? sigmaColor,
    double? sigmaSpace,
    double? sigmaX,
    double? sigmaY,
  }) {
    return BlurState(
      enabled: enabled ?? this.enabled,
      blurType: blurType ?? this.blurType,
      kSize: kSize ?? this.kSize,
      diameter: diameter ?? this.diameter,
      sigmaColor: sigmaColor ?? this.sigmaColor,
      sigmaSpace: sigmaSpace ?? this.sigmaSpace,
      sigmaX: sigmaX ?? this.sigmaX,
      sigmaY: sigmaY ?? this.sigmaY,
    );
  }

  get toMap => <String, dynamic>{
        'blur_type': blurType.toString().split('.')[1],
        'aperture_linear_size': kSize,
        'diameter': diameter,
        'sigma_color': sigmaColor,
        'sigma_space': sigmaSpace,
        'sigma_x': sigmaX,
        'sigma_y': sigmaY,
      };
}
