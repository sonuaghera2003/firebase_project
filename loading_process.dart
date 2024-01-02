import 'package:flutter/material.dart';

void showLoadingProcess(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const Center(
      child: CircularProgressIndicator(),
    ),
  );
}

void hideLoadingProcess(BuildContext context) {
  Navigator.pop(context);
}
