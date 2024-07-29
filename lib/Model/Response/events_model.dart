class EventModel {
  List<Data>? data;

  EventModel({this.data});

  EventModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? createdAt;
  String? title;
  String? description;
  String? status;
  String? startAt;
  int? duration;
  String? id;

  Data(
      {this.createdAt,
        this.title,
        this.description,
        this.status,
        this.startAt,
        this.duration,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    startAt = json['startAt'];
    duration = json['duration'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['title'] = title;
    data['description'] = description;
    data['status'] = status;
    data['startAt'] = startAt;
    data['duration'] = duration;
    data['id'] = id;
    return data;
  }
}