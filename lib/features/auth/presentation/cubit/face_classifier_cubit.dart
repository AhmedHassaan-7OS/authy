import 'package:motion_ai/features/auth/domain/usecases/classify_face_from_image_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'face_classifier_state.dart';

class FaceClassifierCubit extends Cubit<FaceClassifierState> {
  final ClassifyFaceFromImageUseCase _classifyFaceFromImage;

  FaceClassifierCubit({
    required ClassifyFaceFromImageUseCase classifyFaceFromImage,
  })  : _classifyFaceFromImage = classifyFaceFromImage,
        super(const FaceClassifierState());

  Future<void> classifyFromImage(String imagePath) async {
    emit(
      state.copyWith(
        status: FaceClassifierStatus.loading,
        clearError: true,
      ),
    );
    try {
      final result = await _classifyFaceFromImage(imagePath);
      emit(
        state.copyWith(
          status: FaceClassifierStatus.success,
          result: result,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: FaceClassifierStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}

