class CreatePhishingPart {
  final String text;
  final bool isPhishing;
  final int? reasonId;

  const CreatePhishingPart({
    this.text = '',
    this.isPhishing = false,
    this.reasonId,
  });

  CreatePhishingPart copyWith({
    String? text,
    bool? isPhishing,
    int? reasonId,
  }) {
    return CreatePhishingPart(
      text: text ?? this.text,
      isPhishing: isPhishing ?? this.isPhishing,
      reasonId: reasonId ?? this.reasonId,
    );
  }

  Map<String, dynamic> toJson() => {
    'text': text,
    'phishing': isPhishing,
    'reason': reasonId != null ? reasonId.toString() : '',
  };
}
