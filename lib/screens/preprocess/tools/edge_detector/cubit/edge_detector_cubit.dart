import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:teachable_image_classifier/enums.dart';

part 'edge_detector_state.dart';

class EdgeDetectorCubit extends Cubit<EdgeDetectorState> {
  EdgeDetectorCubit() : super(EdgeDetectorState.initial());

  void toogleEnable() {
    emit(state.copyWith(isEnabled: !state.enabled));
  }

  void changeEdgeDetectorType(EdgeDetectorType type) {
    emit(state.copyWith(edgeDetectorType: type));
  }

  void changeThreshold1(double value) {
    emit(state.copyWith(threshold1: value));
  }

  void changeThreshold2(double value) {
    emit(state.copyWith(threshold2: value));
  }

  void changeApertureSize(int value) {
    emit(state.copyWith(apertureSize: value));
  }

  void toogleUseL2Gradient() {
    emit(state.copyWith(useL2Gradient: !state.useL2Gradient));
  }

  void changedDesireDepth(int value) {
    emit(state.copyWith(dDepth: value));
  }

  void changeKernelSize(int value) {
    emit(state.copyWith(kSize: value));
  }

  void changeScale(double value) {
    emit(state.copyWith(scale: value));
  }

  void changeDelta(double value) {
    emit(state.copyWith(delta: value));
  }
}
