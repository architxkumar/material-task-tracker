import 'package:flutter/material.dart';

void showFloatingSnackBar(BuildContext context, String text) {
  final snackBar = SnackBar(
    showCloseIcon: true,
    width: 240,
    content: Text(text),
    behavior: SnackBarBehavior.floating,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
