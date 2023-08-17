import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final Color? color;
  final String label;
  final void Function()? onPressed;

  const AppButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.color,
    Color? textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Colors.lightBlue.shade50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6), // <-- Radius
        ),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.lightBlue,
            ),
      ),
    );
  }
}
