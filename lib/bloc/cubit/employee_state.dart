part of 'employee_cubit.dart';

abstract class EmployeeState extends Equatable {
  const EmployeeState();

  @override
  List<Object> get props => [];
}

class EmployeeInitial extends EmployeeState {
  String? route;

  EmployeeInitial({this.route});
}

class EmployeeLoading extends EmployeeState {}

class EmployeeSuccess extends EmployeeState {
  final List<Employee> empl;

  const EmployeeSuccess({required this.empl});
}

class EmployeeError extends EmployeeState {
  final String message;

  const EmployeeError({required this.message});
}
