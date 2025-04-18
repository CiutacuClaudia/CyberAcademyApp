import 'package:equatable/equatable.dart';
import '../models/caesar_cipher_request.dart';
import '../models/playfair_cipher_request.dart';

enum CryptoStateEnum { initial, loading, success, failure }
enum CipherType { caesar, playfair }

class CryptoState extends Equatable {
  final CryptoStateEnum status;
  final List<CaesarCipher> caesarCiphers;
  final List<PlayfairCipher> playfairCiphers;
  final int currentIndex;
  final CipherType activeCipher;
  final String? errorMessage;

  const CryptoState({
    required this.status,
    this.caesarCiphers = const [],
    this.playfairCiphers = const [],
    this.currentIndex = 0,
    this.activeCipher = CipherType.caesar,
    this.errorMessage,
  });

  CryptoState copyWith({
    CryptoStateEnum? status,
    List<CaesarCipher>? caesarCiphers,
    List<PlayfairCipher>? playfairCiphers,
    int? currentIndex,
    CipherType? activeCipher,
    String? errorMessage,
  }) {
    return CryptoState(
      status: status ?? this.status,
      caesarCiphers: caesarCiphers ?? this.caesarCiphers,
      playfairCiphers: playfairCiphers ?? this.playfairCiphers,
      currentIndex: currentIndex ?? this.currentIndex,
      activeCipher: activeCipher ?? this.activeCipher,
      errorMessage: errorMessage,
    );
  }

  CaesarCipher? get currentCaesarCipher {
    if (caesarCiphers.isNotEmpty) {
      return caesarCiphers[currentIndex % caesarCiphers.length];
    }
    return null;
  }

  PlayfairCipher? get currentPlayfairCipher {
    if (playfairCiphers.isNotEmpty) {
      return playfairCiphers[currentIndex % playfairCiphers.length];
    }
    return null;
  }

  @override
  List<Object?> get props => [
    status,
    caesarCiphers,
    playfairCiphers,
    currentIndex,
    activeCipher,
    errorMessage,
  ];
}
