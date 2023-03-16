import 'package:flutter/material.dart';
import 'package:flutter_hive_db_app/models/task_model.dart';
import 'package:hive_flutter/adapters.dart';

import 'home_page.dart';

late Box box;
void main() async {
  await Hive.initFlutter();
  // now let's create our Hive model class
  Hive.registerAdapter<Task>(TaskAdapter());
  box = await Hive.openBox<Task>("tasks");
  box.add(Task(
    title: "this is the first Task", 
    note: "this is the first task made with the app",
    creation_date: DateTime.now()
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage()
    );
  }
}