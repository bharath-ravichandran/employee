part of 'employee_cubit.dart';

abstract class EmployeeState extends Equatable {
  const EmployeeState();

  @override
  List<Object> get props => [];
}

class EmployeeLoading extends EmployeeState {}

class EmployeeSuccess extends EmployeeState {
  final String message;

  const EmployeeSuccess({required this.message});
}

class EmployeeError extends EmployeeState {
  final String message;

  const EmployeeError({required this.message});
}
