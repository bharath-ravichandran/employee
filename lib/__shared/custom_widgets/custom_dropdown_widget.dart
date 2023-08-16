import 'package:employee/utils/app_assets.dart';
import 'package:employee/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomDropDownWidget extends StatefulWidget {
  final void Function(String) selectedValue;

  const CustomDropDownWidget({super.key, required this.selectedValue});
  @override
  _CustomDropDownWidgetState createState() => _CustomDropDownWidgetState();
}

class _CustomDropDownWidgetState extends State<CustomDropDownWidget> {
  String? _selected;
  final List<String> _items = ['Product Designer', 'Flutter Developer', 'QA Tester', 'Product Owner'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () async {
            // var res = await showModal(context);
            // print('res val : $res');
            var res = await showModalBottomSheet(
              context: context,
              backgroundColor: AppColors.employeeWhite,
              builder: (context) {
                return Container(
                  padding: const EdgeInsets.all(20),
                  height: 200,
                  alignment: Alignment.center,
                  child: ListView.separated(
                    itemCount: _items.length,
                    separatorBuilder: (context, int) {
                      return const Divider();
                    },
                    itemBuilder: (context, index) {
                      return Center(
                        child: GestureDetector(
                          child: Text(
                            _items[index],
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: AppColors.employeeTextBlack,
                                ),
                          ),
                          onTap: () async {
                            setState(() {
                              _selected = _items[index];
                            });
                            Navigator.of(context).pop(_selected);
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            );
            print('res val : $res');
            widget.selectedValue(res);
          },
          child: Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.employeeTextBlack.withOpacity(0.5),
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 10),
                SvgPicture.asset(AppIcons.work),
                const SizedBox(width: 10),
                Text(
                  _selected ?? 'Select Role',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: _selected != null ? AppColors.employeeTextBlack : AppColors.employeeGrey),
                ),
                const Expanded(child: SizedBox.shrink()),
                SvgPicture.asset(AppIcons.arrowDropdown),
                const SizedBox(width: 10),
              ],
            ),
          ),
        ),
      ],
    );
  }

  showModal(context) async {}
}
