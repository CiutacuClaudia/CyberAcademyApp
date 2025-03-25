import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashState(state: SplashStateEnum.initial)) {
    _startAnimation();
  }

  void _startAnimation() async {
    emit(state.copyWith(state: SplashStateEnum.loading));
    await Future.delayed(const Duration(seconds: 3));
    if (!isClosed) {
      emit(state.copyWith(state: SplashStateEnum.finished));
    }
  }
}
