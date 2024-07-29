//
// import '../Utils/Local/encrypt.dart';
//
class ServerURL {


  static String baseurl =
      "https://mock.apidog.com/m1/561191-524377-default/"; //current

  static getUrl(RequestType requestTypes) {
    switch (requestTypes) {
      case RequestType.event:
        return baseurl + RequestType.event.name;
      default:
        // TODO: Handle this case.
    }
  }
}

enum RequestType {
  event(name: 'Event');

  const RequestType({
    required this.name,
  });

  final String name;
}


