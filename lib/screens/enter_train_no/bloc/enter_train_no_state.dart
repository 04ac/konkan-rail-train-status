part of 'enter_train_no_bloc.dart';

@immutable
sealed class EnterTrainNoState {}

final class EnterTrainNoInitial extends EnterTrainNoState {}

class EnterTrainNoErrorStateRequestFailed extends EnterTrainNoState {}

class EnterTrainNoSuccessState extends EnterTrainNoState {
  final Map<String, dynamic> data;
  final Map<String, dynamic> stations;
  final String trainNo;

  EnterTrainNoSuccessState({
    required this.data,
    required this.trainNo,
    required this.stations,
  });
}

class EnterTrainNoLoadingState extends EnterTrainNoState {}
