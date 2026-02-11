import 'package:motion_ai/features/auth/data/datasources/ml_kit_text_remote_data_source.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class MlKitTextRemoteDataSourceImpl implements MlKitTextRemoteDataSource {
  @override
  Future<String> extractTextFromImage(String imagePath) async {
    final inputImage = InputImage.fromFilePath(imagePath);
    final recognizer = GoogleMlKit.vision.textRecognizer();
    try {
      final result = await recognizer.processImage(inputImage);
      return result.text.trim();
    } finally {
      await recognizer.close();
    }
  }
}

