import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:teachable_image_classifier/enums.dart';

part 'threshold_state.dart';

class ThresholdCubit extends Cubit<ThresholdState> {
  ThresholdCubit() : super(ThresholdState.initial());

  void toogleEnable() {
    emit(state.copyWith(enabled: !state.enabled));
  }

  void toggleUseOtsu() {
    emit(state.copyWith(useOtsu: !state.useOtsu));
  }

  void changeLowerThreshValue(double newValue) {
    emit(state.copyWith(lowerThreshValue: newValue));
  }

  void changeUpperThreshValue(double newValue) {
    emit(state.copyWith(upperThreshValue: newValue));
  }

  void changeMaxValue(double newValue) {
    emit(state.copyWith(maxValue: newValue));
  }

  void changeThresholdCategory(ThresholdCategory newValue) {
    emit(state.copyWith(thresholdCategory: newValue));
  }

  void changeThresholdType(ThresholdType newValue) {
    emit(state.copyWith(thresholdType: newValue));
  }

  void changeAdaptiveThresholdMethod(AdaptiveThresholdMethod newValue) {
    emit(state.copyWith(adaptiveThresholdMethod: newValue));
  }

  void changeBlockSize(int value) {
    emit(state.copyWith(blockSize: value));
  }

  void changeConstantC(double value) {
    emit(state.copyWith(constantC: value));
  }
}
