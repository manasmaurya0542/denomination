import 'package:denomination/controllers/data_controller.dart';
import 'package:denomination/utils/const_strings.dart';
import 'package:denomination/widget/save_update_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

Widget floatingButtonWidget(
    {required BuildContext context, required DataController controller}) {
  return SpeedDial(
    icon: Icons.electric_bolt_rounded,
    iconTheme: const IconThemeData(size: 22, color: Colors.white),
    backgroundColor: const Color(0xFF196CCE),
    visible: true,
    curve: Curves.bounceIn,
    children: [
      // FAB 1
      SpeedDialChild(
          child: const Icon(Icons.restart_alt_rounded, color: Colors.white),
          backgroundColor: const Color(0xFF333333),
          onTap: () {
            controller.ids.value != 0
                ? controller.clearOnlyField()
                : controller.clearField();
          },
          label: Strings.clear,
          labelStyle: const TextStyle(
              fontWeight: FontWeight.w500, color: Colors.white, fontSize: 16.0),
          labelBackgroundColor: const Color(0xFF343434)),
      // FAB 2
      SpeedDialChild(
        child: const Icon(
          Icons.file_download_outlined,
          color: Colors.white,
        ),
        backgroundColor: const Color(0xFF343434),
        onTap: () async {
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return const CustomAlertDialog();
            },
          );
        },
        label: controller.ids.value != 0 ? Strings.update : Strings.save,
        labelStyle: const TextStyle(
            fontWeight: FontWeight.w500, color: Colors.white, fontSize: 16.0),
        labelBackgroundColor: const Color(0xFF343434),
      )
    ],
  );
}
