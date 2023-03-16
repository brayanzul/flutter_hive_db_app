import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hive_db_app/models/task_model.dart';
import 'package:flutter_hive_db_app/screens/task_editor.dart';
import 'package:hive_flutter/adapters.dart';

import 'widgets/my_list_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageStateState();
}

class _HomePageStateState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "My Habit App",
          style: TextStyle(color: Colors.black),
        ),
      ),
      // before we start coding the body let's init our database
      body: ValueListenableBuilder<Box<Task>>(
        valueListenable: Hive.box<Task>("tasks").listenable(),
        builder: (context, box, _){
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Today's Task",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  formatDate(DateTime.now(), [d, ", ", M, " ", yyyy]),
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 18.0,
                  ),
                ),
                const Divider(
                  height: 40.0,
                  thickness: 1.0,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: box.values.length ,
                    itemBuilder: (context, index) {
                      Task currentTask = box.getAt(index)!;
                      return MyListTile(currentTask, index);
                    },
                  )
                )
              ],
            ),
          );
        },
      ),  

      floatingActionButton: FloatingActionButton(
        // okay now we need to create a new screen to add a new task
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => TaskEditor(),));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
