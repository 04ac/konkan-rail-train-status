part of 'train_timeline_info_bloc.dart';

@immutable
abstract class TrainTimelineInfoEvent {}

class TrainTimelineRefreshBtnClickedEvent extends TrainTimelineInfoEvent {
  final String trainNo;

  TrainTimelineRefreshBtnClickedEvent({required this.trainNo});
}
