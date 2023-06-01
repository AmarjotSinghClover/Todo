import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/task_notifier.dart';
import 'package:todo/router/router.dart';

class HomePage extends StatelessWidget {
  static const Key titleWidgetKey = Key("titleWidgetKey");
  static const Key addTaskButtonKey = Key("addTaskButtonKey");
  static const Key taskListWidgetKey = Key("taskListWidgetKey");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          key: addTaskButtonKey,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed(AppRouter.addPage);
          }),
      appBar: AppBar(
        title: Text(
          "TODO APP",
          key: titleWidgetKey,
        ),
      ),
      body: Consumer<TaskNotifier>(
        key: taskListWidgetKey,
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
