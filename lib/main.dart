import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/task_notifier.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final TaskNotifier _taskNotifier = TaskNotifier();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => _taskNotifier)],
      builder: (context, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            textTheme: TextTheme(bodyText2: TextStyle(fontSize: 30)),
            primaryTextTheme: TextTheme(bodyText2: TextStyle(fontSize: 30)),
            primarySwatch: Colors.red,
          ),
          home: HomePage(),
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskNotifier = Provider.of<TaskNotifier>(context, listen: false);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AddTaskForm();
              },
            );
          }),
      appBar: AppBar(
        title: Text("TODO APP"),
      ),
      body: Consumer<TaskNotifier>(
        builder: (context, tasNotifier, child) {
          return Column(
            children: tasNotifier.tasks
                .map((task) => ListTile(
                      title: Text(task),
                    ))
                .toList(),
          );
        },
      ),
    );
  }
}

class AddTaskForm extends StatefulWidget {
  final String formTitle;
  const AddTaskForm({
    this.formTitle = "Add Task",
    super.key,
  });

  @override
  State<AddTaskForm> createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
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
    return AlertDialog(
      title: Text(widget.formTitle),
      content: Form(
          key: _formKey,
          child: TextFormField(
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
      actions: [
        ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                _formKey.currentState?.save();
                taskNotifier.addTask(nameController.text);
                Navigator.of(context).pop();
              }
            },
            child: Text("Add"))
      ],
    );
  }
}
