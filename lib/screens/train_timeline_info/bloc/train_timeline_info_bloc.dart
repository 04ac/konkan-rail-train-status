import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:konkan_rail_timetable/screens/enter_train_no/repository/enter_train_no_repo.dart';
import 'package:meta/meta.dart';

part 'train_timeline_info_event.dart';
part 'train_timeline_info_state.dart';

class TrainTimelineInfoBloc
    extends Bloc<TrainTimelineInfoEvent, TrainTimelineInfoState> {
  TrainTimelineInfoBloc() : super(TrainTimelineInfoInitial()) {
    on<TrainTimelineRefreshBtnClickedEvent>(trainTimelineRefreshBtnClicked);
  }

  FutureOr<void> trainTimelineRefreshBtnClicked(
      TrainTimelineRefreshBtnClickedEvent event,
      Emitter<TrainTimelineInfoState> emit) async {
    Map<String, dynamic> data = {};
    emit(TrainTimelineInfoLoading());
    try {
      Map trainData = await EnterTrainNoRepo.getSingleTrainData(event.trainNo);
      data.putIfAbsent("trains", () => trainData);
    } catch (e) {
      emit(TrainTimelineInfoFailure());
      return;
    }
    emit(TrainTimelineInfoSuccess(data: data));
  }
}
