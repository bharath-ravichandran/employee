import 'package:flutter/material.dart';

class CustomSaveButton extends StatelessWidget {
  final void Function()? onPressed;
  const CustomSaveButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.lightBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6), // <-- Radius
        ),
      ),
      child: Text(
        'Save',
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white,
            ),
      ),
    );
  }
}
