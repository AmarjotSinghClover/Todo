import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/task_notifier.dart';
import 'package:todo/router/router.dart';

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
          initialRoute: AppRouter.home,
          onGenerateRoute: AppRouter.routes,
        );
      },
    );
  }
}
