import 'package:flutter/material.dart';
import 'package:flutter_hive_db_app/home_page.dart';
import 'package:hive/hive.dart';

import '../models/task_model.dart';

class TaskEditor extends StatefulWidget {
  Task? task;
  TaskEditor({this.task, super.key});

  @override
  State<TaskEditor> createState() => _TaskEditorState();
}

class _TaskEditorState extends State<TaskEditor> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _taskTitle = TextEditingController(
      text: widget.task == null ? null : widget.task!.title!
    );
    TextEditingController _taskNote = TextEditingController(
      text: widget.task == null ? null : widget.task!.note!
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          widget.task == null ? "Add a new Task" : "Update your Task",
          style: const TextStyle(color: Colors.black),
        ),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Your Tark's Title",
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            TextField(
              controller: _taskTitle,
              decoration: InputDecoration(
                fillColor: Colors.blue.shade100.withAlpha(75),
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8.0 )
                ),
                hintText: "Your Task"
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            const Text(
              "Your Tark's Note",
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            TextField(
              keyboardType: TextInputType.multiline,
              minLines: 5,
              maxLines: 25,
              controller: _taskNote,
              decoration: InputDecoration(
                fillColor: Colors.blue.shade100.withAlpha(75),
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8.0 )
                ),
                hintText: "Write some Notes"
              ),
            ), 
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: 60.0,
                  child: RawMaterialButton(
                    onPressed: () async {
                      // now let's add the function to delete or update our task
                      var newTask = Task(
                        title: _taskTitle.text,
                        note: _taskNote.text,
                        creation_date: DateTime.now(),
                        done: false,
                      );
                      Box<Task> taskbox = Hive.box<Task>("tasks");
                      // to Update the Task
                      if(widget.task != null) {
                        widget.task!.title = newTask.title;
                        widget.task!.note = newTask.note;
                        widget.task!.save();
                        // if you encounter any Error, make sure that you extended your Task class to Hive object to be able to use the save() method
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage(),)); 
                      } else {
                        // to add a new Task
                        await taskbox.add(newTask);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage(),));
                      }
                    },
                    fillColor: Colors.blueAccent.shade700,
                    child: Text(
                      widget.task == null ? "Add new Task" : "Update Task",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
