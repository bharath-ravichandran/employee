import 'dart:developer';

import 'package:employee/models/employee_hive_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

part 'employee_state.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  final employee = Hive.box('employeeBox');

  EmployeeCubit() : super(EmployeeLoading());

  final List<Employee> list = [];

  getAllEmployees() async {
    final catMap = await employee.name;
    print(catMap);
    log('message map data list : $list');
  }
}
