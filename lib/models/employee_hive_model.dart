import 'package:hive/hive.dart';

part 'employee_hive_model.g.dart';

@HiveType(typeId: 1)
class Employee {
  @HiveField(0)
  final String employeeId;

  @HiveField(1)
  final String employeeName;

  @HiveField(2)
  final String employeeDesignation;

  @HiveField(3)
  final String from;

  @HiveField(4)
  final String to;

  @HiveField(5)
  final String key;

  Employee(
    this.key, {
    required this.employeeId,
    required this.employeeName,
    required this.employeeDesignation,
    required this.from,
    required this.to,
  });
}
