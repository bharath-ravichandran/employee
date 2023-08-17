import 'dart:math';

import 'package:employee/models/employee_hive_model.dart';
import 'package:equatable/equatable.dart';
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
      employeeId: randomNumber.toString(),
      employeeName: name,
      employeeDesignation: designation,
      from: from,
      to: to,
    );
  }

  getEmployee(String id) {
    emit(EmployeeLoading());

    final Map<dynamic, dynamic> deliveriesMap = employee.toMap();
    dynamic desiredKey;
    deliveriesMap.forEach((key, value) {
      if (value.employeeId == id) {
        desiredKey = key;
      }
    });

    final Employee item = employee.get(desiredKey);
    print('edit emp : $item');
    emit(EditEmployeeState(item));
  }

  updateEmployee(Employee emp) async {
    emit(EmployeeLoading());

    final Map<dynamic, dynamic> deliveriesMap = employee.toMap();
    dynamic desiredKey;
    deliveriesMap.forEach((key, value) {
      if (value.employeeId == emp.employeeId) {
        desiredKey = key;
      }
    });

    await employee.put(desiredKey, emp);

    if (list.isEmpty) {
      emit(EmployeeInitial());
    } else {
      emit(EmployeeSuccess(empl: list));
    }
  }

  getAllEmployees() async {
    emit(EmployeeLoading());
    final employeeMap = employee.values;
    for (Employee emp in employeeMap) {
      list.add(emp);
    }
    if (list.isEmpty) {
      emit(EmployeeInitial());
    } else {
      emit(EmployeeSuccess(empl: list));
    }
  }

  deleteEmployee(String id) async {
    emit(EmployeeLoading());

    final Map<dynamic, dynamic> deliveriesMap = employee.toMap();
    dynamic desiredKey;
    deliveriesMap.forEach((key, value) {
      if (value.employeeId == id) {
        desiredKey = key;
      }
    });
    employee.delete(desiredKey);

    list.clear();

    final employeeMap = employee.values;
    for (Employee emp in employeeMap) {
      list.add(emp);
    }
    if (list.isEmpty) {
      emit(EmployeeInitial());
    } else {
      emit(EmployeeSuccess(empl: list));
    }
  }
}
