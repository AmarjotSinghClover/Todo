import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/task_notifier.dart';
import 'package:image_picker/image_picker.dart';

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
  ValueNotifier<File?> picture = ValueNotifier(null);

  @override
  void initState() {
    nameController = TextEditingController(text: value);
    taskNotifier = Provider.of<TaskNotifier>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    picture.dispose();
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
      body: ListView(
        children: [
          const SizedBox(height: 20),
          Text(widget.formTitle),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
                key: _formKey,
                child: TextFormField(
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always, label: Text("Task Name"), border: OutlineInputBorder()),
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
          ValueListenableBuilder(
            valueListenable: picture,
            builder: (context, pictureValue, _) {
              if (pictureValue == null) {
                return Container(
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(50)),
                  child: IconButton(
                      color: Colors.white,
                      iconSize: 30,
                      onPressed: () async {
                        final ImagePicker imagePicker = ImagePicker();
                        final image = await imagePicker.pickImage(source: ImageSource.camera);
                        if (image == null) return;

                        picture.value = File(image.path);

                        // pic.readAsBytesSync();
                      },
                      icon: const Icon(
                        Icons.camera_alt,
                      )),
                );
              }

              return Image.file(pictureValue);
            },
          ),
          Container(
            color: Colors.green,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(fixedSize: Size(300, 50)),
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            _formKey.currentState?.save();
                            taskNotifier.addTask(nameController.text);
                            Navigator.of(context).pop();
                          }
                        },
                        icon: const Icon(
                          Icons.task_outlined,
                          size: 30,
                        ),
                        label: const Text(
                          "Add Task",
                          textScaleFactor: 1.5,
                        )),
                    Positioned(
                      top: 20,
                      right: -50,
                      child: Container(
                        child: Text("Fast"),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
