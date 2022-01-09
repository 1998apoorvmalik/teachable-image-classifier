import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:teachable_image_classifier/enums.dart';

part 'blur_state.dart';

class BlurCubit extends Cubit<BlurState> {
  BlurCubit() : super(BlurState.initial());

  void toogleEnable() {
    emit(state.copyWith(enabled: !state.enabled));
  }

  void changeBlurType(BlurType type) {
    emit(state.copyWith(blurType: type));
  }

  void changeApertureLinearSize(int value) {
    emit(state.copyWith(kSize: value));
  }

  void changeDiameter(int value) {
    emit(state.copyWith(diameter: value));
  }

  void changeSigmaColor(double value) {
    emit(state.copyWith(sigmaColor: value));
  }

  void changeSigmaSpace(double value) {
    emit(state.copyWith(sigmaSpace: value));
  }

  void changeSigmaX(double value) {
    emit(state.copyWith(sigmaX: value));
  }

  void changeSigmaY(double value) {
    emit(state.copyWith(sigmaY: value));
  }
}
