import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final String? message;
  const ErrorPage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          message!,
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
