import 'package:motion_ai/features/auth/domain/entities/face_category.dart';
import 'package:equatable/equatable.dart';

class FaceClassificationResult extends Equatable {
  final FaceCategory category;
  final int detectedFaces;
  final bool isHeuristic;

  const FaceClassificationResult({
    required this.category,
    required this.detectedFaces,
    this.isHeuristic = true,
  });

  @override
  List<Object?> get props => [category, detectedFaces, isHeuristic];
}

