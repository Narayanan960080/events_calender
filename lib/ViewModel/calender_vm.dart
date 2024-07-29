import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vizmo_lakshmi_calender/Model/Response/events_model.dart';

import '../Model/ApiInterface.dart';
import '../Model/ApiResponse.dart';

class CalenderVM extends Cubit<ApiResponse<EventModel>>{
  CalenderVM() : super(ApiResponse.loading());
  final ApiInterface _apiInterface = ApiInterface();

  getLeadListFeedBackId({required Map<String, dynamic> data}) async {
    try {
    emit(ApiResponse.loading());
    var events = await _apiInterface.getEVentsDetails(query: data);
    emit(ApiResponse.completed(events));
    } catch (err) {
      emit(ApiResponse.error(err.toString()));
    }
  }

}