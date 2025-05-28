import 'package:equatable/equatable.dart';
import '../../phishing/models/phishing_reason_request.dart';
import '../model/create_phishing_part.dart';

enum CreatePhishingStatus { initial, loading, success, failure }

class CreatePhishingState extends Equatable {
  final CreatePhishingStatus status;
  final String subject;
  final List<CreatePhishingPart> parts;
  final List<PhishingReasonRequest> reasons;
  final String? errorMessage;
  final bool justSubmitted;

  const CreatePhishingState({
    required this.status,
    this.subject = '',
    this.parts = const [],
    this.reasons = const [],
    this.errorMessage,
    this.justSubmitted = false,
  });

  bool get isValid =>
      subject.isNotEmpty &&
      parts.isNotEmpty &&
      parts.every(
        (p) => p.text.isNotEmpty && (!p.isPhishing || p.reasonId != null),
      );

  bool get canPreview => isValid;

  bool get canSubmit => isValid;

  CreatePhishingState copyWith({
    CreatePhishingStatus? status,
    String? subject,
    List<CreatePhishingPart>? parts,
    List<PhishingReasonRequest>? reasons,
    String? errorMessage,
    bool? justSubmitted,
  }) {
    return CreatePhishingState(
      status: status ?? this.status,
      subject: subject ?? this.subject,
      parts: parts ?? this.parts,
      reasons: reasons ?? this.reasons,
      errorMessage: errorMessage ?? this.errorMessage,
      justSubmitted: justSubmitted ?? this.justSubmitted,
    );
  }

  @override
  List<Object?> get props => [
    status,
    subject,
    parts,
    reasons,
    errorMessage,
    justSubmitted,
  ];
}
