import 'dart:ffi';

import 'package:denomination/hive/data_db.dart';
import 'package:denomination/models/data_model.dart';
import 'package:denomination/utils/const_strings.dart';
import 'package:denomination/utils/snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

class DataController extends GetxController {
  Rx<DenomModel> tempDenom = Rx<DenomModel>(DenomModel());
  var dataList = <DenomModel>[].obs;
  var textFieldValues = <int, TextEditingController>{}.obs;
  var totalSum = 0.0.obs;
  var ids = 0.obs;
  List<String> shareString = [];
  var formatter = DateFormat.yMMMMd().add_jm().format(DateTime.now());
  var selectedValue = "".obs;
  Rx<TextEditingController> remarkController = TextEditingController().obs;

  @override
  void onInit() {
    clearField();
    fetchAllData();

    super.onInit();
  }

  void getTotalSum() {
    totalSum.value = 0.0;
    textFieldValues.forEach((key, value) {
      int val = int.parse(value.text == '' ? "0" : value.text);
      totalSum.value += key * val;
    });
  }

  void loadData(int id, String title, String remark) {
    ids.value = id;
    selectedValue.value = title;
    remarkController.value = TextEditingController(text: remark);
    textFieldValues.value = tempDenom.value.values!.map((key, value) =>
        MapEntry(key, TextEditingController(text: value.toString())));
    getTotalSum();
  }

  void clearField() {
    ids.value = 0;
    selectedValue.value = Strings.general;
    remarkController.value = TextEditingController();
    clearOnlyField();
    getTotalSum();
  }

  void clearOnlyField() {
    for (var element in Strings.multiplyNumber) {
      textFieldValues[element] = TextEditingController();
    }
  }

  Future<void> fetchAllData() async {
    List<DenomModel> tmp = await DataDb.instance.readData();
    if (tmp.isEmpty) {
      clearField();
    }
    dataList.assignAll(tmp);
  }

  Future<void> onTapRemoveSelectedIds(int id) async {
    print(id);
    await DataDb.instance.deleteData(id);
    showSnackBar(Strings.delete, Strings.deletedMsg);
    fetchAllData();
  }

  Future<void> toggleSavedDenom(String title, String content) async {
    var dateTimes = DateTime.now();
    var dateTimeEpoch = dateTimes.millisecondsSinceEpoch ~/ 1000;
    var totalValue = 0;
    var mapValuesData = textFieldValues.map((key, value) {
      int val = int.parse(value.text == '' ? "0" : value.text);
      totalValue += key * val;
      return MapEntry(key, val);
    });
    DenomModel denomModel = DenomModel(
        id: dateTimeEpoch,
        categoryName: title,
        remark: content,
        values: mapValuesData,
        dateTime: formatter,
        total: totalValue.toString()); //totalAmount.toString());
    await DataDb.instance.createData([denomModel]).then((_) {
      fetchAllData();
      clearField();
      showSnackBar(Strings.saved, Strings.savedMsg);
    });
  }

  Future<void> toggleUpdateDenom(
      DenomModel dataModel, String remark, String title) async {
    var totalValue = 0;
    var mapValuesData = textFieldValues.map((key, value) {
      int val = int.parse(value.text == '' ? "0" : value.text);
      totalValue += key * val;
      return MapEntry(key, val);
    });
    await DataDb.instance
        .updateData(
            dataModel.id ?? -1,
            DenomModel(
                id: dataModel.id,
                categoryName: title,
                remark: remark,
                values: mapValuesData,
                dateTime: formatter,
                // Updated date
                total: totalValue.toString()))
        .then((_) {
      fetchAllData();
      clearField();
      Get.back();
      showSnackBar(Strings.update, Strings.updateMsg);
    });
  }

  Future<void> toggleOnShare(DenomModel dataModel) async {
    List mutiplyConvertToList = dataModel.values!.values.toList();
    List<String> finalStrings = List.generate(
        Strings.multiplyNumber.length,
        (index) =>
            "${Strings.rupeeSign} ${Strings.multiplyNumber[index]} * ${mutiplyConvertToList[index]} = ${Strings.rupeeSign} ${Strings.multiplyNumber[index] * mutiplyConvertToList[index]}");
    String listOfAddedStrings = finalStrings.join("\n");
    Share.share(
        'Denomination\n${dataModel.categoryName}\nDenomination\n${dataModel.dateTime}\n${dataModel.remark}\n----------------------------\nRupee x Count = Total\n$listOfAddedStrings');
  }
}
