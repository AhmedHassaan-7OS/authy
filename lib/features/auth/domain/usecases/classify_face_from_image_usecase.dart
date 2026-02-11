import 'package:motion_ai/features/auth/domain/entities/face_classification_result.dart';
import 'package:motion_ai/features/auth/domain/repositories/face_classifier_repository.dart';

class ClassifyFaceFromImageUseCase {
  final FaceClassifierRepository _repository;

  ClassifyFaceFromImageUseCase(this._repository);

  Future<FaceClassificationResult> call(String imagePath) {
    return _repository.classifyImage(imagePath);
  }
}

