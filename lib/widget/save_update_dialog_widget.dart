import 'package:denomination/controllers/data_controller.dart';
import 'package:denomination/utils/const_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAlertDialog extends StatefulWidget {
  const CustomAlertDialog({super.key});

  @override
  _CustomAlertDialogState createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  @override
  Widget build(BuildContext context) {
    final DataController dataController = Get.put(DataController());
    return AlertDialog(
      title: Align(
        alignment: Alignment.topRight,
        child: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(Icons.close),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonFormField<String>(
            value: dataController.selectedValue.value,
            onChanged: (value) {
              setState(() {
                dataController.selectedValue.value = value!;
              });
            },
            items: [
              DropdownMenuItem(
                value: Strings.general,
                child: Text(Strings.general),
              ),
              DropdownMenuItem(
                value: Strings.optionTwo,
                child: Text(Strings.optionTwo),
              ),
              DropdownMenuItem(
                value: Strings.optionThree,
                child: Text(Strings.optionThree),
              ),
            ],
            decoration: InputDecoration(
              labelText: Strings.category,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: dataController.remarkController.value,
            decoration: InputDecoration(
              labelText: Strings.fillForm,
              border: const OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        Center(
          child: ElevatedButton(
            onPressed: () {
              if (dataController.ids.value != 0) {
                // update data
                dataController.toggleUpdateDenom(
                    dataController.tempDenom.value,
                    dataController.remarkController.value.text,
                    dataController.selectedValue.value);
              } else {
                //Create new data
                dataController.toggleSavedDenom(
                    dataController.selectedValue.value,
                    dataController.remarkController.value.text);
                Navigator.of(context).pop();
              }
            },
            child: dataController.ids.value != 0
                ? Text(Strings.update)
                : Text(Strings.save),
          ),
        )
      ],
    );
  }
}
