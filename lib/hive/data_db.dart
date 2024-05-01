import 'dart:convert';
import 'package:denomination/models/data_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DataDb {
  static DataDb? _instance;

  DataDb._();

  static DataDb get instance => _instance ??= DataDb._();

  Box? dataBox;

  Future<void> setSecureDataBase() async {
    const secureStorage = FlutterSecureStorage();
    final encryptionKey = await secureStorage.read(key: 'key');
    if (encryptionKey == null) {
      final key = Hive.generateSecureKey();
      await secureStorage.write(
        key: 'key',
        value: base64UrlEncode(key),
      );
    }
    final key = await secureStorage.read(key: 'key');
    final encryptionKeyData = base64Url.decode(key!);
    // Opening the box
    dataBox = await Hive.openBox<DenomModel>('data_box',
        encryptionCipher: HiveAesCipher(encryptionKeyData));
  }

  Future<void> createData(List<DenomModel> createData) async {
    try {
      for (var item in createData) {
        dataBox?.add(item);
        print('id ${item.id} created successfully');
      }
    } catch (e) {
      print(e);
    }
  }

  Future readData() async {
    try {
      return dataBox?.values.toList() ?? [] as List<DenomModel>;
    } catch (e) {
      return [];

    }
  }

  Future<void> updateData(
    int id,
    DenomModel dataModel,
  ) async {
    try {
      var list = dataBox?.values.toList() ?? [];
      int index = list.indexWhere((data) => data.id == id);
      if (index != -1) {
        dataBox?.putAt(index, dataModel);
        print('updated successfully');
      } else {
        print('DB data with id $id not found');
      }
    } catch (e) {
      print(e);
    }
  }

  Future deleteData(int id) async {
    try {
      var list = dataBox?.values.toList() ?? [];
      int index = list.indexWhere((data) => data.id == id);
      if (index != -1) {
        dataBox?.deleteAt(index);
      }
      print('$id deleted successfully');
      // return noteBox?.values.toList() ?? [] as List<NoteModel>;
    } catch (e) {
      print("Error while deleting:$e");
    }
  }
}
