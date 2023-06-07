// import 'package:get_storage/get_storage.dart';

// class StorageService {
//   Future<void> init() async {
//     await GetStorage.init();
//   }

//   // Future<void> writeData(String key, dynamic value) async {
//   //   await GetStorage("key").write(key, value);
//   // }

//   // dynamic readData(String key) {
//   //   return GetStorage("key").read(key);
//   // }

//   // bool isBoxEmpty(String boxName) {
//   //   final box = GetStorage(boxName);
//   //   final value = box.read(boxName);
//   //   return value == null;
//   // }
//   void writeData(String boxName, String key, dynamic value) async {
//     final box = GetStorage(boxName);
//     await box.write(key, value);
//   }

//   dynamic readData(String boxName, String key) async {
//     final box = GetStorage(boxName);
//     return await box.read(key);
//   }

//   bool isBoxEmpty(String boxName) {
//     final box = GetStorage(boxName);
//     final keys = box.getKeys();
//     return keys.isEmpty;
//   }
// }
