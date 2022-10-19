import 'package:flutter/material.dart';

void showConnectionSnackbar(BuildContext context, String message) {
  final SnackBar snackBar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
