import 'package:denomination/hive/data_db.dart';
import 'package:denomination/models/data_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'screen/home_screen.dart';

void main() async{
  await Hive.initFlutter();
  Hive.registerAdapter(DenomModelAdapter());
  await DataDb.instance.setSecureDataBase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Denomination',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Home()
    );
  }
}
