import 'package:equatable/equatable.dart';

enum AiTextStatus { initial, loading, success, failure }

class AiTextState extends Equatable {
  final AiTextStatus status;
  final String extractedText;
  final String? errorMessage;

  const AiTextState({
    this.status = AiTextStatus.initial,
    this.extractedText = '',
    this.errorMessage,
  });

  AiTextState copyWith({
    AiTextStatus? status,
    String? extractedText,
    String? errorMessage,
    bool clearError = false,
  }) {
    return AiTextState(
      status: status ?? this.status,
      extractedText: extractedText ?? this.extractedText,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [status, extractedText, errorMessage];
}
