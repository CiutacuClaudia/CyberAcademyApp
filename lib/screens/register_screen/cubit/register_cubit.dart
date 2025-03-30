import 'package:flutter_bloc/flutter_bloc.dart';

import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit()
    : super(const RegisterState(state: RegisterStateEnum.initial));

  void register(String email, String password, String confirmPassword) async {
    emit(state.copyWith(state: RegisterStateEnum.loading));

    await Future.delayed(Duration(seconds: 2));

    if (password == confirmPassword) {
      emit(state.copyWith(state: RegisterStateEnum.success));
    } else {
      emit(
        state.copyWith(
          state: RegisterStateEnum.failure,
          errorMessage: 'Registration failed. Please check your credentials.',
        ),
      );
    }
  }
}
