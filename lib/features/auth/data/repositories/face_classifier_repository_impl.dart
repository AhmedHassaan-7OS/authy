import 'package:motion_ai/features/auth/data/datasources/ml_kit_face_classifier_remote_data_source.dart';
import 'package:motion_ai/features/auth/domain/entities/face_classification_result.dart';
import 'package:motion_ai/features/auth/domain/repositories/face_classifier_repository.dart';

class FaceClassifierRepositoryImpl implements FaceClassifierRepository {
  final MlKitFaceClassifierRemoteDataSource _remoteDataSource;

  FaceClassifierRepositoryImpl(this._remoteDataSource);

  @override
  Future<FaceClassificationResult> classifyImage(String imagePath) {
    return _remoteDataSource.classifyImage(imagePath);
  }
}

