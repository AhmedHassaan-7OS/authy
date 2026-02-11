import 'package:authy/features/auth/domain/repositories/ai_text_repository.dart';

class ExtractTextFromImageUseCase {
  final AiTextRepository _repository;

  ExtractTextFromImageUseCase(this._repository);

  Future<String> call(String imagePath) {
    return _repository.extractTextFromImage(imagePath);
  }
}
