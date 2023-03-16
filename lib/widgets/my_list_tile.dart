import 'package:flutter/material.dart';
import 'package:flutter_hive_db_app/models/task_model.dart';
import 'package:flutter_hive_db_app/screens/task_editor.dart';

class MyListTile extends StatefulWidget {
  Task task;
  int index;
  MyListTile(this.task, this.index, {super.key});

  @override
  State<MyListTile> createState() => _MyListTileState();
}

class _MyListTileState extends State<MyListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      width: double.infinity,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.task.title!,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold
                  ),
                )
              ),
              IconButton(
                onPressed: (){
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => TaskEditor(
                        task: widget.task,
                      ),
                    )
                  );
                }, 
                icon: const Icon(
                  Icons.edit,
                  color: Colors.green,
                ),
              ),
              IconButton(
                onPressed: (){
                  widget.task.delete();
                  // we just finished the app
                  // I hope that you enjoyed this tutorial, please don't forget to like and subcribe, and see you in the next video
                }, 
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          const Divider(
            color: Colors.black87,
            height: 20.0,
            thickness: 1.0,
          ),
          Text(
            widget.task.note!,
            style: const TextStyle(
              fontSize: 16.0,
            ),
          )
        ],
      ),
    );
  }
}