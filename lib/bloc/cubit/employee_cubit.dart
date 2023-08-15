import 'dart:math';

import 'package:employee/models/employee_hive_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

part 'employee_state.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  final employee = Hive.box('employeeBox');

  EmployeeCubit() : super(EmployeeInitial());

  late final List<Employee> list = [];

  addEmployee(String name, String designation, String from, String to) async {
    emit(EmployeeLoading());
    Random random = Random();
    int randomNumber = random.nextInt(100);
    Employee newEmployee = Employee(
      randomNumber.toString(),
      employeeId: randomNumber.toString(),
      employeeName: name,
      employeeDesignation: designation,
      from: from,
      to: to,
    );

    var a = employee.add(newEmployee);
    if (kDebugMode) {
      print('Info added to box!  ${newEmployee.employeeId}, $a}');
    }
  }

  getAllEmployees() async {
    emit(EmployeeLoading());
    final employeeMap = employee.values;
    for (Employee emp in employeeMap) {
      list.add(emp);
    }
    emit(EmployeeSuccess(empl: list));
  }

  deleteEmployee(int key) async {
    emit(EmployeeLoading());
    if (kDebugMode) {
      print('delete : ${key.runtimeType}');
    }
    await employee.delete(key);
    emit(const EmployeeSuccess(empl: []));
  }
}
