import 'package:employee/__shared/custom_widgets/custom_slide_menu_widget.dart';
import 'package:employee/utils/app_colors.dart';
import 'package:flutter/material.dart';

class SlidebleList extends StatefulWidget {
  const SlidebleList({Key? key}) : super(key: key);

  @override
  State<SlidebleList> createState() => _SlidebleListState();
}

class _SlidebleListState extends State<SlidebleList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: List.generate(42, (index) {
            return CustomSlideMenu(
              menuItems: <Widget>[
                Container(
                  color: Colors.red,
                  child: IconButton(
                    color: Colors.white,
                    icon: const Icon(Icons.delete_forever_outlined),
                    onPressed: () {},
                  ),
                ),
              ],
              child: ListTile(
                title: Text(
                  "Just drag me",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.employeeTextBlack,
                      ),
                ),
              ),
            );
          }),
        ).toList(),
      ),
    );
  }
}
