
import 'dart:convert';

import 'package:vizmo_lakshmi_calender/Model/Response/events_model.dart';

import 'ApiClient.dart';
import 'Repository/Repo.dart';
// import 'Response/NewData.dart';
import 'ServerURL.dart';


class ApiInterface implements Repo {
  final ApiClient _apiService = ApiClient();

  @override
  Future<EventModel> getEVentsDetails({required Map<String, dynamic> query}) async {
    // TODO: implement getEVentsDetails
    // try {
      var response =
          await _apiService.fetchGetData(
          ServerURL.getUrl(RequestType.event), {})
     ;
      print("DIRECT DATA");
      print(response);
      return EventModel.fromJson(jsonDecode(response));
    // } catch (err) {
    //   print(err)
    //   return EventModel();
    // }
  }
}
