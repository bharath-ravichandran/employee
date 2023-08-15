import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<String?> datePicker(context) async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1950),
    lastDate: DateTime(2100),
  );

  if (pickedDate != null) {
    String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
    return formattedDate;
  }
  return pickedDate.toString();
}
