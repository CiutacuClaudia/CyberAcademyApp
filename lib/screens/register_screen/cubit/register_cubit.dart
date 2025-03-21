import 'package:flutter_bloc/flutter_bloc.dart';

import 'register_state.dart';

// Define the events
class RegisterCubit extends Cubit<RegisterState> {
  // Initial state is the "initial" state
  RegisterCubit() : super(const RegisterState(state: RegisterStateEnum.initial));

  // Method to simulate loading state (e.g., API call)
  void register(String email, String password, String confirmPassword) async {
    // Emit the loading state when the registration starts
    emit(state.copyWith(state: RegisterStateEnum.loading));

    // Simulate a delay (e.g., for an API request)
    await Future.delayed(Duration(seconds: 2));

    if (password == confirmPassword) {
      emit(state.copyWith(state: RegisterStateEnum.success));
    } else {
      emit(state.copyWith(
        state: RegisterStateEnum.failure,
        errorMessage: 'Registration failed. Please check your credentials.',
      ));
    }
  }

  // Method to handle validation errors for individual fields
  void validateFields(String name, String email, String password) {
    String? nameError;
    String? emailError;
    String? passwordError;

    if (name.isEmpty) {
      nameError = 'Name is required';
    }

    if (email.isEmpty || !email.contains('@')) {
      emailError = 'Please enter a valid email';
    }

    if (password.isEmpty || password.length < 6) {
      passwordError = 'Password must be at least 6 characters';
    }

    emit(state.copyWith(
      nameError: nameError,
      emailError: emailError,
      passwordError: passwordError,
    ));
  }
}
