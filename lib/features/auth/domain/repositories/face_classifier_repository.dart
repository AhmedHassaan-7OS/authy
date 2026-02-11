import 'package:authy/features/auth/domain/entities/face_classification_result.dart';

abstract class FaceClassifierRepository {
  Future<FaceClassificationResult> classifyImage(String imagePath);
}
