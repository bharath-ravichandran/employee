import 'package:employee/utils/app_colors.dart';
import 'package:flutter/material.dart';

class Nav {
  final BuildContext context;

  Nav.to(this.context, {required String route, Object? arguments}) {
    Navigator.of(context).pushNamed(route, arguments: arguments);
  }

  Nav.popAndPush(this.context, {required String route, Object? arguments}) {
    Navigator.of(context).popAndPushNamed(route, arguments: arguments);
  }

  Nav.replace(this.context, {required String route, Object? arguments}) {
    Navigator.of(context).pushReplacementNamed(route, arguments: arguments);
  }

  Nav.dialog(
    this.context, {
    required String route,
  }) {
    Navigator.of(context).pushNamed(route);
  }

  Nav.snackBar(
    this.context, {
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: AppColors.employeePrimary,
          content: Text(
            message,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.employeeWhite),
          )),
    );
  }

  Nav.success(
    this.context, {
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.employeeSuccess,
        content: Text(
          message,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.employeeWhite),
        ),
      ),
    );
  }

  Nav.warning(
    this.context, {
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.employeeWarning,
        content: Text(
          message,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.employeeWhite),
        ),
      ),
    );
  }

  Nav.error(
    this.context, {
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.employeeError,
        content: Text(
          message,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.employeeWhite),
        ),
      ),
    );
  }
}
