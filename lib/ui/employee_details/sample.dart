import 'dart:math';

import 'package:employee/bloc/cubit/employee_cubit.dart';
import 'package:employee/models/employee_hive_model.dart';
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

class Sample extends StatelessWidget {
  Sample({super.key});

  final TextEditingController nameController = TextEditingController();
  final _employeeFormKey = GlobalKey<FormState>();
  late final Box box;

  DateTime? fromDate, toDate;

  @override
  Widget build(BuildContext context) {
    var role;
    return BlocProvider.value(
      value: EmployeeCubit(),
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
          bloc: EmployeeCubit(),
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
                          onPressed: () => Navigator.of(context).pop(),
                          label: 'Cancel',
                        ),
                        const SizedBox(width: 20),
                        CustomSaveButton(
                          onPressed: () async {
                            if (_employeeFormKey.currentState!.validate()) {
                              // addEmployee(
                              //   nameController.text,
                              //   'SE',
                              //   '01-01-2000',
                              //   '01-01-2001',
                              // );

                              EmployeeCubit().addEmployee(
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
        // body: BlocBuilder<EmployeeCubit, EmployeeState>(
        //   bloc: EmployeeCubit(),
        //   builder: (_, state) {
        //     print('object state : $state');
        //     if (state is EmployeeInitial) {
        //     } else if (state is EmployeeLoading) {
        //       return const Center(child: CircularProgressIndicator());
        //     } else if (state is EmployeeSuccess) {
        //       return Center(
        //           child: Scaffold(
        //         body: ,
        //       ));
        //     } else if (state is EmployeeError) {
        //       return ErrorPage(message: 'Something went wrong');
        //     }
        //     return const CircularProgressIndicator();
        //   },
        // ),
      ),
    );
  }

  String? _fieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field can\'t be empty';
    }
    return null;
  }

  void addEmployee(String name, String designation, String from, String to) {
    Random random = Random();
    int randomNumber = random.nextInt(100);
    Employee newEmployee = Employee(
      employeeId: randomNumber.toString(),
      employeeName: name,
      employeeDesignation: designation,
      from: from,
      to: to,
    );

    box.add(newEmployee);
    print('Info added to box!  ${newEmployee.employeeId}');
  }
}
