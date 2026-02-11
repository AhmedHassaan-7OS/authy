import 'package:motion_ai/features/auth/data/datasources/ml_kit_face_classifier_remote_data_source.dart';
import 'package:motion_ai/features/auth/domain/entities/face_category.dart';
import 'package:motion_ai/features/auth/domain/entities/face_classification_result.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class MlKitFaceClassifierRemoteDataSourceImpl
    implements MlKitFaceClassifierRemoteDataSource {
  @override
  Future<FaceClassificationResult> classifyImage(String imagePath) async {
    final inputImage = InputImage.fromFilePath(imagePath);
    final detector = GoogleMlKit.vision.faceDetector(
      FaceDetectorOptions(
        enableClassification: true,
        performanceMode: FaceDetectorMode.fast,
      ),
    );
    try {
      final faces = await detector.processImage(inputImage);
      if (faces.isEmpty) {
        return const FaceClassificationResult(
          category: FaceCategory.animalOrOther,
          detectedFaces: 0,
        );
      }
      return FaceClassificationResult(
        category: _classifyHumanFace(faces),
        detectedFaces: faces.length,
      );
    } finally {
      await detector.close();
    }
  }

  FaceCategory _classifyHumanFace(List<Face> faces) {
    final smiles = faces
        .map((f) => f.smilingProbability ?? 0)
        .reduce((a, b) => a + b) /
        faces.length;
    return smiles >= 0.55 ? FaceCategory.girl : FaceCategory.boy;
  }
}

