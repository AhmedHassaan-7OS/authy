import 'package:authy/features/auth/domain/usecases/extract_text_from_image_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ai_text_state.dart';

class AiTextCubit extends Cubit<AiTextState> {
  final ExtractTextFromImageUseCase _extractTextFromImage;

  AiTextCubit({required ExtractTextFromImageUseCase extractTextFromImage})
      : _extractTextFromImage = extractTextFromImage,
        super(const AiTextState());

  Future<void> extractFromImage(String imagePath) async {
    emit(
      state.copyWith(
        status: AiTextStatus.loading,
        clearError: true,
      ),
    );
    try {
      final text = await _extractTextFromImage(imagePath);
      emit(
        state.copyWith(
          status: AiTextStatus.success,
          extractedText: text,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AiTextStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
