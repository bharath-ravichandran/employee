import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  String? message;
  ErrorPage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Error - Something went wrong',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
              ),
        ),
      ),
      body: Center(
        child: Image.asset('assets/images/not_found.png'),
      ),
    );
  }
}
