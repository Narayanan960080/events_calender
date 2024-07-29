

import 'package:vizmo_lakshmi_calender/Model/Response/events_model.dart';

abstract class Repo {

  Future<EventModel> getEVentsDetails(
      {required Map<String, dynamic> query});

}