import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {
  final void Function()? onPressed;

  const CancelButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.lightBlue.shade50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6), // <-- Radius
        ),
      ),
      child: Text(
        'Cancel',
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.lightBlue,
            ),
      ),
    );
  }
}
