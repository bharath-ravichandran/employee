class EmployeeModel {
  late String? employeeId;
  late String? employeeName;
  late String? employeeDesignation;
  late String? fromDate;
  late String? toDate;

  EmployeeModel({
    this.employeeId,
    this.employeeName,
    this.employeeDesignation,
    this.fromDate,
    this.toDate,
  });

  EmployeeModel.fromJson(Map<String, dynamic> json) {
    employeeId = json['employee_id'];
    employeeName = json['employee_name'];
    employeeDesignation = json['employee_designation'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['employee_id'] = employeeId;
    data['employee_name'] = employeeName;
    data['employee_designation'] = employeeDesignation;
    data['from_date'] = fromDate;
    data['to_date'] = toDate;
    return data;
  }

  @override
  String toString() => toJson().toString();
}
