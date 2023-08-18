import 'package:employee/bloc/cubit/employee_cubit.dart';
import 'package:employee/models/employee_hive_model.dart';
import 'package:employee/ui/__shared/custom_widgets/calender_button.dart';
import 'package:employee/ui/__shared/custom_widgets/custom_app_button_widget.dart';
import 'package:employee/ui/__shared/custom_widgets/custom_dropdown_widget.dart';
import 'package:employee/ui/__shared/custom_widgets/custom_input_texfield_widget.dart';
import 'package:employee/ui/__shared/custom_widgets/custom_save_button_widget.dart';
import 'package:employee/utils/app_assets.dart';
import 'package:employee/utils/app_colors.dart';
import 'package:employee/utils/app_routes.dart';
import 'package:employee/utils/app_theme.dart';
import 'package:employee/utils/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import 'add_employee.dart';

class EditEmployee extends StatefulWidget {
  final Employee employee;
  const EditEmployee({super.key, required this.employee});

  @override
  State<EditEmployee> createState() => _EditEmployeeState();
}

class _EditEmployeeState extends State<EditEmployee> {
  final EmployeeCubit employeeCubit = EmployeeCubit();

  final _employeeFormKey = GlobalKey<FormState>();

  String? fromDate, toDate;

  String? role;

  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = widget.employee.employeeName;
    fromDate = widget.employee.from;
    toDate = widget.employee.to;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.employeeAppBar,
        title: Text(
          'Edit Employee Details',
          style: AppExTheme.headlineSmall(context),
        ),
      ),
      body: BlocProvider.value(
        value: employeeCubit,
        child: BlocBuilder<EmployeeCubit, EmployeeState>(
          bloc: employeeCubit..getEmployee(widget.employee.employeeId),
          builder: (_, state) {
            if (state is EditEmployeeState) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _employeeFormKey,
                  child: Column(
                    children: [
                      CustomInputTextFieldWidget(
                        hintLabel: 'Employee name',
                        controller: nameController,
                        prefixWidget: SvgPicture.asset(AppIcons.person, width: 2),
                        validator: _fieldValidator,
                      ),
                      const SizedBox(height: 20),
                      CustomDropDownWidget(
                        editVal: state.employee.employeeDesignation,
                        selectedValue: (String data) {
                          role = data;
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CalenderButton(
                              fromDate: true,
                              formattedDate: fromDate,
                              callBack1: () async {
                                var res = await showDialog(
                                  context: context,
                                  builder: (_) {
                                    return const CalDialog(
                                      fromDate: true,
                                    );
                                  },
                                );
                                if (res != null) {
                                  fromDate = DateFormat('dd-MMM-yyyy').format(res);
                                  setState(() {});
                                }
                              },
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Icon(
                              Icons.arrow_right_alt,
                              color: AppColors.employeeAppBar,
                            ),
                          ),
                          Expanded(
                            child: CalenderButton(
                              fromDate: false,
                              formattedDate: toDate,
                              callBack1: () async {
                                var res = await showDialog(
                                  context: context,
                                  builder: (_) {
                                    return const CalDialog(
                                      fromDate: false,
                                    );
                                  },
                                );
                                if (res != null) {
                                  toDate = DateFormat('dd-MMM-yyyy').format(res);
                                  setState(() {});
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      Expanded(child: Container()),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AppButton(
                            onPressed: () => Navigator.of(context).pop(),
                            label: 'Cancel',
                          ),
                          const SizedBox(width: 20),
                          CustomSaveButton(
                            onPressed: () async {
                              if (role == null || fromDate == null || toDate == null) {
                                Nav.snackBar(context, message: 'Please select role of the employee');
                              } else {
                                if (_employeeFormKey.currentState!.validate()) {
                                  employeeCubit.updateEmployee(Employee(
                                    employeeId: widget.employee.employeeId,
                                    employeeName: nameController.text,
                                    employeeDesignation: role!,
                                    from: fromDate!,
                                    to: toDate!,
                                  ));
                                  Navigator.of(context).pop();
                                  Nav.popAndPush(context, route: AppRoutes.employeeList);
                                }
                              }
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }
            return Center(
              child: Image.asset(AppImages.notFound),
            );
          },
        ),
      ),
    );
  }

  String? _fieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field can\'t be empty';
    }
    return null;
  }
}
