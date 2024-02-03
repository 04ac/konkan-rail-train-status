import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:konkan_rail_timetable/screens/enter_train_no/repository/enter_train_no_repo.dart';
import 'package:konkan_rail_timetable/screens/fetch_trains_data/repository/fetch_trains_data_repo.dart';
import 'package:meta/meta.dart';
part 'enter_train_no_event.dart';
part 'enter_train_no_state.dart';

class EnterTrainNoBloc extends Bloc<EnterTrainNoEvent, EnterTrainNoState> {
  EnterTrainNoBloc() : super(EnterTrainNoInitial()) {
    on<SearchBtnClickedActionEvent>(searchBtnClickedActionEvent);
  }

  FutureOr<void> searchBtnClickedActionEvent(SearchBtnClickedActionEvent event,
      Emitter<EnterTrainNoState> emit) async {
    emit(EnterTrainNoLoadingState());

    final data = await EnterTrainNoRepo.getSingleTrainData(event.trainNo);

    if (data["success"] == false) {
      emit(EnterTrainNoErrorStateRequestFailed());
    } else {
      final Map<String, dynamic> jsonResult =
          await FetchTrainsDataRepo.getStations();

      emit(EnterTrainNoSuccessState(
          data: data, trainNo: event.trainNo, stations: jsonResult));
    }
  }
}
