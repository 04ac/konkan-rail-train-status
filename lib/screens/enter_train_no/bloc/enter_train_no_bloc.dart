import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:konkan_rail_timetable/screens/enter_train_no/repository/enter_train_no_repo.dart';
import 'package:meta/meta.dart';
import 'package:flutter/services.dart' show rootBundle;

part 'enter_train_no_event.dart';
part 'enter_train_no_state.dart';

class EnterTrainNoBloc extends Bloc<EnterTrainNoEvent, EnterTrainNoState> {
  EnterTrainNoBloc() : super(EnterTrainNoInitial()) {
    on<SearchBtnClickedActionEvent>(searchBtnClickedActionEvent);
  }

  Future<String> getStationsJson() {
    return rootBundle.loadString('lib/utils/stations.json');
  }

  FutureOr<void> searchBtnClickedActionEvent(SearchBtnClickedActionEvent event,
      Emitter<EnterTrainNoState> emit) async {
    emit(EnterTrainNoLoadingState());
    if (event.trainNo == "") {
      emit(EnterTrainNoErrorStateBlankInput());
    } else {
      final data = await EnterTrainNoRepo.getSingleTrainData(event.trainNo);
      final Map<String, dynamic> jsonResult =
          jsonDecode(await getStationsJson());

      if (data["success"] == false) {
        emit(EnterTrainNoErrorStateRequestFailed());
      } else {
        emit(EnterTrainNoSuccessState(
            data: data, trainNo: event.trainNo, stations: jsonResult));
      }
    }
  }
}
