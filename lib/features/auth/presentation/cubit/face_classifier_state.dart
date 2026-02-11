import 'package:motion_ai/features/auth/domain/entities/face_classification_result.dart';
import 'package:equatable/equatable.dart';

enum FaceClassifierStatus { initial, loading, success, failure }

class FaceClassifierState extends Equatable {
  final FaceClassifierStatus status;
  final FaceClassificationResult? result;
  final String? errorMessage;

  const FaceClassifierState({
    this.status = FaceClassifierStatus.initial,
    this.result,
    this.errorMessage,
  });

  FaceClassifierState copyWith({
    FaceClassifierStatus? status,
    FaceClassificationResult? result,
    String? errorMessage,
    bool clearError = false,
  }) {
    return FaceClassifierState(
      status: status ?? this.status,
      result: result ?? this.result,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [status, result, errorMessage];
}

