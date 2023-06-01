import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:todo/pages/home_page.dart';
import 'package:todo/providers/task_notifier.dart';

void main() {
  late TaskNotifier taskNotifier;
  setUp(() {
    taskNotifier = TaskNotifier();
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => taskNotifier)],
      child: MaterialApp(home: HomePage()),
    ));

    await tester.pumpAndSettle();

    final addTask = find.byKey(HomePage.addTaskButtonKey);
    expect(addTask, findsOneWidget);

    final titleWidget = find.byKey(HomePage.titleWidgetKey);
    expect(titleWidget, findsOneWidget);

    final taskListWidget = find.byKey(HomePage.taskListWidgetKey);
    expect(taskListWidget, findsOneWidget);

    final tasks = find.descendant(of: taskListWidget, matching: find.byType(ListTile));
    expect(tasks, findsOneWidget);


    taskNotifier.addTask("Task2");
    await tester.pumpAndSettle();
    final task2 = find.descendant(of: taskListWidget, matching: find.text("Task2"));
    expect(task2, findsOneWidget);

  });
}
