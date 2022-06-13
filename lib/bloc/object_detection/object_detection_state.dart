part of 'object_detection_cubit.dart';

@immutable
abstract class ObjectDetectionState {}

class ObjectDetectionInitial extends ObjectDetectionState {}

class ObjectDetectionLoadingState extends ObjectDetectionState {}

class ObjectDetectionErrorState extends ObjectDetectionState {
  final error;

  ObjectDetectionErrorState(this.error);
}

class ObjectDetectionSuccessState extends ObjectDetectionState {}
