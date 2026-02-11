import 'package:motion_ai/features/auth/domain/entities/face_classification_result.dart';

abstract class MlKitFaceClassifierRemoteDataSource {
  Future<FaceClassificationResult> classifyImage(String imagePath);
}

