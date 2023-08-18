import 'package:employee/bloc/cubit/employee_cubit.dart';
import 'package:employee/ui/__shared/custom_widgets/custom_slide_menu_widget.dart';
import 'package:employee/ui/employee_details/edit_employee.dart';
import 'package:employee/utils/app_assets.dart';
import 'package:employee/utils/app_colors.dart';
import 'package:employee/utils/app_routes.dart';
import 'package:employee/utils/app_theme.dart';
import 'package:employee/utils/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'error_page.dart';

class EmployeeList extends StatelessWidget {
  EmployeeList({super.key});

  final EmployeeCubit employeeCubit = EmployeeCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Employee List',
          style: AppExTheme.headlineSmall(context),
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: BlocProvider.value(
        value: employeeCubit,
        child: BlocConsumer<EmployeeCubit, EmployeeState>(
          bloc: employeeCubit..getAllEmployees(),
          listener: (_, state) {
            if (state is EmployeeInitial) {
              Center(
                child: Image.asset(AppImages.notFound),
              );
            } else if (state is EmployeeLoading) {
              const Center(child: CircularProgressIndicator());
            } else if (state is EditEmployeeState) {
              EditEmployee(
                employee: state.employee,
              );
            } else if (state is EmployeeSuccess) {
              ListView(
                children: ListTile.divideTiles(
                  context: context,
                  tiles: List.generate(state.empl.length, (index) {
                    return CustomSlideMenu(
                      menuItems: <Widget>[
                        Container(
                          color: AppColors.employeeError,
                          height: 80,
                          child: IconButton(
                            color: AppColors.employeeWhite,
                            icon: const Icon(
                              Icons.delete_forever_outlined,
                              size: 36,
                            ),
                            onPressed: () {
                              employeeCubit.deleteEmployee(state.empl[index].employeeId);
                              Nav.snackBar(context, message: 'Employee data has been deleted');
                            },
                          ),
                        ),
                      ],
                      child: InkWell(
                        onTap: () {
                          Nav.to(context, route: AppRoutes.editEmployee, arguments: state.empl[index]);
                        },
                        child: ListTile(
                          title: Text(
                            state.empl[index].employeeName,
                            style: AppExTheme.headlineSmall(context).copyWith(color: AppColors.employeeTextBlack),
                          ),
                          subtitle: Text(
                            '${state.empl[index].employeeId} - ${state.empl[index].employeeDesignation}\n${state.empl[index].from} - ${state.empl[index].to}',
                            style: AppExTheme.headlineSmall(context).copyWith(color: AppColors.employeeTextBlack),
                          ),
                        ),
                      ),
                    );
                  }),
                ).toList(),
              );
            } else if (state is EmployeeError) {
              Nav.error(context, message: state.message);
            }
          },
          builder: (_, state) {
            if (state is EmployeeInitial) {
              return Center(
                child: Image.asset(AppImages.notFound),
              );
            } else if (state is EmployeeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is EditEmployeeState) {
              return EditEmployee(
                employee: state.employee,
              );
            } else if (state is EmployeeSuccess) {
              return Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: ListTile.divideTiles(
                        context: context,
                        tiles: List.generate(state.empl.length, (index) {
                          return CustomSlideMenu(
                            menuItems: <Widget>[
                              Container(
                                color: AppColors.employeeError,
                                height: 80,
                                child: IconButton(
                                  color: AppColors.employeeWhite,
                                  icon: const Icon(
                                    Icons.delete_forever_outlined,
                                    size: 36,
                                  ),
                                  onPressed: () {
                                    employeeCubit.deleteEmployee(state.empl[index].employeeId);
                                    Nav.snackBar(context, message: 'Employee data has been deleted');
                                  },
                                ),
                              ),
                            ],
                            child: InkWell(
                              onTap: () {
                                // employeeCubit.getEmployee(state.empl[index].employeeId);
                                Nav.to(context, route: AppRoutes.editEmployee, arguments: state.empl[index]);
                              },
                              child: ListTile(
                                title: Text(
                                  state.empl[index].employeeName,
                                  style: AppExTheme.headlineSmall(context).copyWith(color: AppColors.employeeTextBlack),
                                ),
                                subtitle: Text(
                                  '${state.empl[index].employeeId} - ${state.empl[index].employeeDesignation}\n${state.empl[index].from} - ${state.empl[index].to}',
                                  style: AppExTheme.titleSmall(context).copyWith(color: AppColors.employeeTextBlack),
                                ),
                              ),
                            ),
                          );
                        }),
                      ).toList(),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    height: 50,
                    width: double.infinity,
                    color: AppColors.employeeGrey1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Swipe left to delete',
                        textAlign: TextAlign.center,
                        style: AppExTheme.bodySmall(context).copyWith(color: AppColors.employeeGrey),
                      ),
                    ),
                  )
                ],
              );
            } else if (state is EmployeeError) {
              return const ErrorPage(message: 'Something went wrong');
            }
            return const SizedBox.shrink();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.employeeAppBar,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        onPressed: () {
          Nav.popAndPush(context, route: AppRoutes.addEmployee);
          // Nav.popAndPush(context, route: AppRoutes.sample);
        },
        child: const Icon(
          Icons.add,
          color: AppColors.employeeWhite,
          size: 36,
        ),
      ),
    );
  }
}
