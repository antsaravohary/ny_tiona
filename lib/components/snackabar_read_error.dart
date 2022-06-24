import 'package:flutter/material.dart';

class SnackbarReadError extends SnackBar {
  const SnackbarReadError({Key? key})
      : super(key: key, content: const Text('Echec de lecture'));
}
