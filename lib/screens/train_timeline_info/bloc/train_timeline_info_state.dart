part of 'train_timeline_info_bloc.dart';

@immutable
abstract class TrainTimelineInfoState {}

class TrainTimelineInfoInitial extends TrainTimelineInfoState {}

class TrainTimelineInfoLoading extends TrainTimelineInfoState {}

class TrainTimelineInfoFailure extends TrainTimelineInfoState {}

class TrainTimelineInfoSuccess extends TrainTimelineInfoState {
  final Map<String, dynamic> data;

  TrainTimelineInfoSuccess({required this.data});
}
