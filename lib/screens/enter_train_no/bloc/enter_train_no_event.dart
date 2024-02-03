part of 'enter_train_no_bloc.dart';

@immutable
sealed class EnterTrainNoEvent {}

class EnterTrainNoActionEvent extends EnterTrainNoEvent {}

class SearchBtnClickedActionEvent extends EnterTrainNoActionEvent {
  final String trainNo;

  SearchBtnClickedActionEvent({required this.trainNo});
}
