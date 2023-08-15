import 'dart:math';

import 'package:employee/__shared/custom_widgets/custom_cancel_button_widget.dart';
import 'package:employee/__shared/custom_widgets/custom_dropdown_widget.dart';
import 'package:employee/__shared/custom_widgets/custom_input_texfield_widget.dart';
import 'package:employee/__shared/custom_widgets/custom_save_button_widget.dart';
import 'package:employee/models/employee_hive_model.dart';
import 'package:employee/utils/app_assets.dart';
import 'package:employee/utils/app_routes.dart';
import 'package:employee/utils/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key});

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  final TextEditingController nameController = TextEditingController();
  final _employeeFormKey = GlobalKey<FormState>();
  late final Box box;

  String? _fieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field can\'t be empty';
    }
    return null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    box = Hive.box('employeeBox');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Employee Details',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
              ),
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
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
              CustomDropDownWidget(),
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
                        addEmployee(
                          nameController.text,
                          'SE',
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
      ),
    );
  }

  addEmployee(String name, String designation, String from, String to) async {
    Random random = Random();
    int randomNumber = random.nextInt(100);
    Employee newEmployee = Employee(
      randomNumber.toString(),
      employeeId: randomNumber.toString(),
      employeeName: name,
      employeeDesignation: designation,
      from: from,
      to: to,
    );

    int a = await box.add(newEmployee);
    print('a : $a');
    print('Info added to box!  ${newEmployee.key}');
  }
}
