import 'package:employee/bloc/cubit/employee_cubit.dart';
import 'package:employee/ui/__shared/custom_widgets/custom_cancel_button_widget.dart';
import 'package:employee/ui/__shared/custom_widgets/custom_dropdown_widget.dart';
import 'package:employee/ui/__shared/custom_widgets/custom_input_texfield_widget.dart';
import 'package:employee/ui/__shared/custom_widgets/custom_save_button_widget.dart';
import 'package:employee/utils/app_assets.dart';
import 'package:employee/utils/app_colors.dart';
import 'package:employee/utils/app_routes.dart';
import 'package:employee/utils/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';

import '../../ui/__shared/custom_dialogs/show_calender.dart';
import '../../ui/__shared/custom_widgets/calender_button.dart';

class AddEmployee extends StatelessWidget {
  AddEmployee({super.key});

  final EmployeeCubit employeeCubit = EmployeeCubit();
  final TextEditingController nameController = TextEditingController();
  final _employeeFormKey = GlobalKey<FormState>();
  late final Box box;

  DateTime? fromDate, toDate;

  @override
  Widget build(BuildContext context) {
    var role;
    return BlocProvider.value(
      value: employeeCubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Add Employee Details',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
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
                        print('calling on data : $data');
                        role = data;
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CalenderButton(
                            onTap: () async {
                              var res = await showDialog(
                                context: context,
                                builder: (_) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Material(
                                          borderRadius: BorderRadius.circular(12),
                                          color: AppColors.employeeWhite,
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 12,
                                            ),
                                            child: CalendarWidget(fromDate: true),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                              print('fromdate calling1 : $res');
                              fromDate = res;
                              print('fromdate calling2 : $fromDate');
                            },
                            date: fromDate,
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
                            onTap: () async {
                              var res = await showDialog(
                                context: context,
                                builder: (_) {
                                  return const Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Material(
                                        color: Colors.white,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 12,
                                          ),
                                          child: CalendarWidget(fromDate: false),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                              print('fromdate calling1 : $res');
                              toDate = res;
                              print('fromdate calling1 : $toDate');
                            },
                            date: toDate,
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
                            if (_employeeFormKey.currentState!.validate()) {
                              employeeCubit.addEmployee(
                                nameController.text,
                                role,
                                '01-01-2000',
                                '01-01-2001',
                              );
                              Nav.popAndPush(context, route: AppRoutes.employeeList);
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
