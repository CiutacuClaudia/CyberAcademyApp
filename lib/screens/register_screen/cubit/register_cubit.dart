import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/models/user/user.dart';
import '../../../network/config/api_result.dart';
import '../models/register_request.dart';
import '../repository/register_repository.dart';
import 'register_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterRepository _repository;

  RegisterCubit({RegisterRepository? repository})
      : _repository = repository ?? RegisterRepository(),
        super(const RegisterState(state: RegisterStateEnum.initial));

  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required AppLocalizations loc,
  }) async {
    emit(state.copyWith(state: RegisterStateEnum.loading));

    final result = await _repository.registerUser(
      RegisterRequest(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
      ),
    );

    if (result is ApiSuccess<User>) {
      emit(state.copyWith(state: RegisterStateEnum.success));
    } else if (result is ApiFailure<User> &&
        result.statusCode == ApiStatusCode.conflict) {
      emit(
        state.copyWith(
          state: RegisterStateEnum.failure,
          emailError: loc.emailAlreadyUsed,
        ),
      );
    } else {
      emit(state.copyWith(state: RegisterStateEnum.failure));
    }
  }

  void clearEmailError() {
    if (state.emailError != null) {
      emit(state.copyWith(state: RegisterStateEnum.initial, emailError: null));
    }
  }
}