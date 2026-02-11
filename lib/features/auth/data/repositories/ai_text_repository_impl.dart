import 'package:motion_ai/features/auth/data/datasources/ml_kit_text_remote_data_source.dart';
import 'package:motion_ai/features/auth/domain/repositories/ai_text_repository.dart';

class AiTextRepositoryImpl implements AiTextRepository {
  final MlKitTextRemoteDataSource _remoteDataSource;

  AiTextRepositoryImpl(this._remoteDataSource);

  @override
  Future<String> extractTextFromImage(String imagePath) {
    return _remoteDataSource.extractTextFromImage(imagePath);
  }
}

