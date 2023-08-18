import 'package:employee/models/employee_hive_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

part 'employee_state.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  final employee = Hive.box('employeeBox');

  EmployeeCubit() : super(EmployeeInitial());

  late final List<Employee> list = [];

  //add employee cubit
  addEmployee(Employee emp) async {
    emit(EmployeeLoading());

    Employee newEmployee = Employee(
      employeeId: emp.employeeId,
      employeeName: emp.employeeName,
      employeeDesignation: emp.employeeDesignation,
      from: emp.from,
      to: emp.to,
    );

    employee.add(newEmployee);
  }

  //get employee cubit
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
    emit(EditEmployeeState(item));
  }

  //update employee cubit
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

  //get all employees cubit
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

  //delete employee cubit
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
