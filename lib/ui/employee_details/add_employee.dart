import 'dart:math';

import 'package:employee/bloc/cubit/employee_cubit.dart';
import 'package:employee/models/employee_hive_model.dart';
import 'package:employee/ui/__shared/custom_dialogs/show_calender.dart';
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
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key});

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  final EmployeeCubit employeeCubit = EmployeeCubit();

  final TextEditingController nameController = TextEditingController();

  final _employeeFormKey = GlobalKey<FormState>();

  late final Box box;

  String? fromDate, toDate;
  String? role;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: employeeCubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Add Employee Details',
            style: AppExTheme.headlineSmall(context).copyWith(
              color: AppColors.employeeWhite,
            ),
          ),
          backgroundColor: Colors.lightBlue,
        ),
        body: BlocBuilder<EmployeeCubit, EmployeeState>(
          bloc: employeeCubit,
          builder: (_, state) {
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
                          onPressed: () => Nav.popAndPush(context, route: AppRoutes.employeeList),
                          label: 'Cancel',
                        ),
                        const SizedBox(width: 20),
                        CustomSaveButton(
                          onPressed: () async {
                            Random random = Random();
                            int randomNumber = random.nextInt(100);
                            if (role == null || fromDate == null || toDate == null) {
                              Nav.snackBar(context, message: 'Please select role of the employee');
                            } else {
                              if (_employeeFormKey.currentState!.validate()) {
                                employeeCubit.addEmployee(Employee(
                                  employeeName: nameController.text,
                                  employeeDesignation: role!,
                                  from: fromDate!,
                                  to: toDate!,
                                  employeeId: randomNumber.toString(),
                                ));
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

class CalDialog extends StatelessWidget {
  final bool fromDate;
  const CalDialog({super.key, required this.fromDate});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.employeeWhite,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              child: CalendarWidget(fromDate: fromDate),
            ),
          ),
        ),
      ],
    );
  }
}
