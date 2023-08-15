import 'package:employee/__shared/custom_widgets/custom_slide_menu_widget.dart';
import 'package:employee/bloc/cubit/employee_cubit.dart';
import 'package:employee/utils/app_colors.dart';
import 'package:employee/utils/app_routes.dart';
import 'package:employee/utils/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'error_page.dart';

class EmployeeList extends StatelessWidget {
  const EmployeeList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Employee List',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
              ),
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body:
          // Center(
          //   child: Image.asset(AppIcons.notFound),
          // ),
          BlocProvider.value(
        value: EmployeeCubit(),
        child: BlocConsumer<EmployeeCubit, EmployeeState>(
          bloc: EmployeeCubit()..getAllEmployees(),
          listener: (_, state) {
            print('object state : $state');
            if (state is EmployeeInitial) {
              const Center(child: CircularProgressIndicator());
            } else if (state is EmployeeLoading) {
              const Center(child: CircularProgressIndicator());
            } else if (state is EmployeeSuccess) {
              ListView(
                children: ListTile.divideTiles(
                  context: context,
                  tiles: List.generate(state.empl.length, (index) {
                    return CustomSlideMenu(
                      menuItems: <Widget>[
                        Container(
                          color: Colors.red,
                          height: 80,
                          child: IconButton(
                            color: Colors.white,
                            icon: const Icon(
                              Icons.delete_forever_outlined,
                              size: 36,
                            ),
                            onPressed: () {
                              print(state.empl[index].employeeId);
                              EmployeeCubit().deleteEmployee(index);
                            },
                          ),
                        ),
                      ],
                      child: InkWell(
                        onTap: () {
                          print(state.empl[index].employeeId);
                        },
                        child: ListTile(
                          title: Text(
                            state.empl[index].employeeName,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: AppColors.employeeTextBlack,
                                ),
                          ),
                          subtitle: Text(
                            '${state.empl[index].employeeId} - ${state.empl[index].employeeDesignation}\n${state.empl[index].from} - ${state.empl[index].to}',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: AppColors.employeeTextBlack,
                                ),
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
            print('object state : $state');
            if (state is EmployeeInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is EmployeeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is EmployeeSuccess) {
              return ListView(
                children: ListTile.divideTiles(
                  context: context,
                  tiles: List.generate(state.empl.length, (index) {
                    return CustomSlideMenu(
                      menuItems: <Widget>[
                        Container(
                          color: Colors.red,
                          height: 80,
                          child: IconButton(
                            color: Colors.white,
                            icon: const Icon(
                              Icons.delete_forever_outlined,
                              size: 36,
                            ),
                            onPressed: () {
                              print(index.toString());
                              EmployeeCubit().deleteEmployee(index);
                            },
                          ),
                        ),
                      ],
                      child: InkWell(
                        onTap: () {
                          print(state.empl[index].employeeId);
                        },
                        child: ListTile(
                          title: Text(
                            state.empl[index].employeeName,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: AppColors.employeeTextBlack,
                                ),
                          ),
                          subtitle: Text(
                            '${state.empl[index].employeeId} - ${state.empl[index].employeeDesignation}\n${state.empl[index].from} - ${state.empl[index].to}',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: AppColors.employeeTextBlack,
                                ),
                          ),
                        ),
                      ),
                    );
                  }),
                ).toList(),
              );
            } else if (state is EmployeeError) {
              return ErrorPage(message: 'Something went wrong');
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
          //Nav.popAndPush(context, route: AppRoutes.addEmployee);
          Nav.popAndPush(context, route: AppRoutes.sample);
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
