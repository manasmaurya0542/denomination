import 'dart:ffi';

import 'package:denomination/controllers/data_controller.dart';
import 'package:denomination/utils/const_strings.dart';
import 'package:denomination/utils/primary_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CountsList extends StatefulWidget {
  final int index;
  const CountsList({super.key, required this.index});

  @override
  State<CountsList> createState() => _CountsListState();
}

class _CountsListState extends State<CountsList> {
  TextStyle styles = const TextStyle(
      fontWeight: FontWeight.w600, fontSize: 24, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    final DataController dataController = Get.put(DataController());
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${Strings.rupeeSign} ${Strings.multiplyNumber[widget.index]}",
                    style: styles,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    Strings.multiplySign,
                    style: styles,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            MyTextField(
                controller: dataController.textFieldValues[Strings.multiplyNumber[widget.index]]!, //1
                index: widget.index,
                onChanged: (val) {
                  dataController.textFieldValues[Strings.multiplyNumber[widget.index]]?.text = val;
                  dataController.getTotalSum();
                  setState(() {});
                }),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                "${Strings.equalSign} ${Strings.rupeeSign} ${ dataController
                    .textFieldValues[Strings.multiplyNumber[widget.index]]?.text ==
                    ''
                    ? 0
                    : int.parse(dataController
                    .textFieldValues[Strings.multiplyNumber[widget.index]]?.text ??
                    "0")*Strings.multiplyNumber[widget.index]}",
                style: styles,
              ),
            ),
          ],
        ),
      );
    });
  }
}
