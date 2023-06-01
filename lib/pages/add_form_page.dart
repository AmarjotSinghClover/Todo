import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/task_notifier.dart';

class AddTaskPage extends StatefulWidget {
  final String formTitle;
  const AddTaskPage({
    this.formTitle = "Add Task",
    super.key,
  });

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  late TaskNotifier taskNotifier;

  String value = "abc";
  late TextEditingController nameController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    nameController = TextEditingController(text: value);
    taskNotifier = Provider.of<TaskNotifier>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    taskNotifier.enteredText = "";
  }

  @override
  Widget build(BuildContext context) {
    nameController.text = taskNotifier.enteredText;
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text(widget.formTitle),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Text(widget.formTitle),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
                key: _formKey,
                child: TextFormField(
                  decoration: InputDecoration(label: Text("Task Name"), border: OutlineInputBorder()),
                  onChanged: (value) {
                    taskNotifier.enteredText = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Required";
                    }
                    return null;
                  },
                  controller: nameController,
                )),
          ),
          ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  _formKey.currentState?.save();
                  taskNotifier.addTask(nameController.text);
                  Navigator.of(context).pop();
                }
              },
              child: const Text("Add"))
        ],
      ),
    );
  }
}
