import 'package:employee/ui/employee_details/add_employee.dart';
import 'package:employee/ui/employee_details/edit_employee.dart';
import 'package:employee/ui/employee_details/employee_list.dart';
import 'package:employee/ui/employee_details/error_page.dart';
import 'package:employee/ui/employee_details/sample.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> rootNavKey = GlobalKey<NavigatorState>();

Route<dynamic> generateRoute(RouteSettings settings) {
  final dynamic args = settings.arguments;
  switch (settings.name) {
    case AppRoutes.employeeList:
      return MaterialPageRoute(
        builder: (_) => const EmployeeList(),
      );

    case AppRoutes.sample:
      return MaterialPageRoute(
        builder: (_) => Sample(),
      );

    case AppRoutes.addEmployee:
      return MaterialPageRoute(
        builder: (_) => const AddEmployee(),
      );

    case AppRoutes.editEmployee:
      return MaterialPageRoute(
        builder: (_) => const EditEmployee(),
      );

    default:
      return _errorRoute(args, settings.name);
  }
}

MaterialPageRoute _errorRoute(dynamic args, String? name) {
  return MaterialPageRoute(
    builder: (_) => Center(
      child: Scaffold(
        appBar: AppBar(),
        body: ErrorPage(message: name),
      ),
    ),
  );
}

class AppRoutes {
  //Authentication
  static const String onboarding = '/';
  static const String employeeList = '/employee_list';
  static const String addEmployee = '/add_employee';
  static const String sample = '/sample';
  static const String editEmployee = '/edit_employee';
  static const String deleteEmployee = '/delete_employee';
}

class BouncyPageRoute extends PageRouteBuilder {
  final Widget child;

  BouncyPageRoute({required this.child})
      : super(
          pageBuilder: (context, animation, secAnimation) => child,
          transitionDuration: const Duration(milliseconds: 1000),
          transitionsBuilder: (context, animation, secAnimation, child) {
            animation = CurvedAnimation(
              parent: animation,
              curve: Curves.elasticInOut,
            );
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
}

class FadePageRoute extends PageRouteBuilder {
  final Widget child;

  FadePageRoute({required this.child})
      : super(
          pageBuilder: (context, animation, secAnimation) => child,
          transitionDuration: const Duration(milliseconds: 100),
          transitionsBuilder: (context, animation, secAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
}
