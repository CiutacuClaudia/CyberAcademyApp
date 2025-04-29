import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../network/config/api_result.dart';
import '../models/caesar_cipher_request.dart';
import '../models/playfair_cipher_request.dart';
import '../repository/crypto_repository.dart';
import 'crypto_state.dart';
import '../../../common/widgets/toast.dart';

class CryptoCubit extends Cubit<CryptoState> {
  final CryptoRepository _repository;

  CryptoCubit({CryptoRepository? repository})
    : _repository = repository ?? CryptoRepository(),
      super(const CryptoState(status: CryptoStateEnum.initial)) {
    loadCiphers();
  }

  Future<void> loadCiphers() async {
    emit(state.copyWith(status: CryptoStateEnum.loading));

    final caesarResult = await _repository.getCaesarCiphers();
    if (caesarResult is ApiSuccess<List<CaesarCipher>>) {
      final caesarList = caesarResult.data;
      if (caesarList.isEmpty) {
        emit(
          state.copyWith(
            status: CryptoStateEnum.failure,
            errorMessage: "No Caesar ciphers found",
          ),
        );
        return;
      }

      final playfairResult = await _repository.getPlayfairCiphers();
      List<PlayfairCipher> playfairList = [];
      if (playfairResult is ApiSuccess<List<PlayfairCipher>>) {
        playfairList = playfairResult.data;
      } else if (playfairResult is ApiFailure) {
        final failure = playfairResult as ApiFailure;
        emit(
          state.copyWith(
            status: CryptoStateEnum.failure,
            errorMessage: failure.message,
          ),
        );
        return;
      }

      emit(
        state.copyWith(
          status: CryptoStateEnum.success,
          caesarCiphers: caesarList,
          playfairCiphers: playfairList,
          currentIndex: 0,
          activeCipher: CipherType.caesar,
        ),
      );
    } else if (caesarResult is ApiFailure) {
      final failure = caesarResult as ApiFailure;
      emit(
        state.copyWith(
          status: CryptoStateEnum.failure,
          errorMessage: failure.message,
        ),
      );
    }
  }

  void verifyInput(String input) {
    if (state.activeCipher == CipherType.caesar) {
      final currentCipher = state.currentCaesarCipher;
      if (currentCipher == null) return;
      if (input.trim().toLowerCase() == currentCipher.encryptedText) {
        ToastService.showSuccessToast(message: "🎉Congrats");
        if (state.currentIndex < state.caesarCiphers.length - 1) {
          emit(state.copyWith(currentIndex: state.currentIndex + 1));
        } else {
          if (state.playfairCiphers.isNotEmpty) {
            emit(
              state.copyWith(
                activeCipher: CipherType.playfair,
                currentIndex: 0,
              ),
            );
          } else {
            emit(state.copyWith(currentIndex: 0));
          }
        }
      } else {
        ToastService.showErrorToast(
          message: "Incorrect encrypted text. Please try again.",
        );
      }
    } else if (state.activeCipher == CipherType.playfair) {
      final currentCipher = state.currentPlayfairCipher;
      if (currentCipher == null) return;
      if (input.trim().toLowerCase() == currentCipher.encryptedText) {
        ToastService.showSuccessToast(message: "🎉Congrats");
        if (state.currentIndex < state.playfairCiphers.length - 1) {
          emit(state.copyWith(currentIndex: state.currentIndex + 1));
        } else {
          if (state.caesarCiphers.isNotEmpty) {
            emit(
              state.copyWith(activeCipher: CipherType.caesar, currentIndex: 0),
            );
          } else {
            emit(state.copyWith(currentIndex: 0));
          }
        }
      } else {
        ToastService.showErrorToast(
          message: "Incorrect encrypted text. Please try again.",
        );
      }
    }
  }

  void skipCipher() {
    if (state.activeCipher == CipherType.caesar) {
      if (state.currentIndex < state.caesarCiphers.length - 1) {
        emit(state.copyWith(currentIndex: state.currentIndex + 1));
      } else {
        if (state.playfairCiphers.isNotEmpty) {
          emit(
            state.copyWith(activeCipher: CipherType.playfair, currentIndex: 0),
          );
        } else {
          emit(state.copyWith(currentIndex: 0));
        }
      }
    } else if (state.activeCipher == CipherType.playfair) {
      if (state.currentIndex < state.playfairCiphers.length - 1) {
        emit(state.copyWith(currentIndex: state.currentIndex + 1));
      } else {
        if (state.caesarCiphers.isNotEmpty) {
          emit(
            state.copyWith(activeCipher: CipherType.caesar, currentIndex: 0),
          );
        } else {
          emit(state.copyWith(currentIndex: 0));
        }
      }
    }
  }
}
