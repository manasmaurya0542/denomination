import 'package:denomination/utils/const_strings.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final int index;
  final TextEditingController controller;
  final Function onChanged;

  const MyTextField(
      {super.key,
        required this.index,
        required this.controller,
        required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 110,
      child: TextField(
        controller: controller,
        onChanged: (val) => onChanged(val),
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        textAlignVertical: TextAlignVertical.center,
        enabled: true,
        keyboardType: TextInputType.number,
        onTap: () {},
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.blueGrey,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.lightBlue, width: 1.0),
          ),
          contentPadding:
          const EdgeInsets.symmetric(vertical: 15, horizontal: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: index == 0 ? Strings.trySix : "",
          hintStyle: const TextStyle(color: Colors.white),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: const Icon(Icons.cancel),
        ),
      ),
    );
  }
}