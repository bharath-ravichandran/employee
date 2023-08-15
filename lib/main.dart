import 'package:employee/models/employee_hive_model.dart';
import 'package:employee/ui/employee_details/employee_list.dart';
import 'package:employee/utils/app_routes.dart';
import 'package:employee/utils/app_theme.dart';
import 'package:employee/utils/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(EmployeeAdapter());
  await Hive.openBox('employeeBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        ScreenUtils.init(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
        );
        return MaterialApp(
          title: 'Realtime Innovations Assignment',
          navigatorKey: rootNavKey,
          theme: AppTheme.init(),
          home: const EmployeeList(),
          initialRoute: AppRoutes.onboarding,
          onGenerateRoute: generateRoute,
        );
      },
    );
  }
}
