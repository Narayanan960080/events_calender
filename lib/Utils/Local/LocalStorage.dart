// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//
// class LocalStorage {
//   static const storage = FlutterSecureStorage();
//
//   // set storage
//   static setValue({required String key, required String value}) async {
// // Write value
//     await storage.write(key: key, value: value);
//   }
//
//   // read storage
//   static readValue({required String key}) async {
//     // Read value
//     return await storage.read(key: key);
//   }
//
//   static Future<Map<String, String>> readAll() async {
//     // Read all values
//     return await storage.readAll();
//   }
//
//   static Future<void> delete({required String key}) async {
//     // Delete value
//     await storage.delete(key: key);
//   }
//
//   static Future<void> deleteAll() async {
//     // Delete all values
//     await storage.deleteAll();
//   }
// }
//
// enum LocalStorageKeys {
//   roleID(key: "roleID"),
//   roleName(key: "roleName"),
//   token(key: "token"),
//   emsyneToken(key: "emsyneToken"),
//   empID(key: "empID"),
//   otherEmpIds(key: "otherEmpIds"),
//   empName(key: "empName"),
//   supervisorID(key: "supervisorID"),
//   supervisorName(key: "supervisorName"),
//   mobileNo(key: "mobileNo"),
//   deviceId(key: "deviceId"),
//   unitCode(key: "unitCode");
//
//   final String key;
//   const LocalStorageKeys({required this.key});
// }
