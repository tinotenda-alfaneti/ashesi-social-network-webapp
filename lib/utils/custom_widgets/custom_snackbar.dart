import 'package:flutter/material.dart';

class Snackbar extends StatefulWidget {
  final String errorMessage;

  const Snackbar({required this.errorMessage, super.key});

  @override
  State<Snackbar> createState() => _SnackbarState(errorMessage);
}

class _SnackbarState extends State<Snackbar> {
  final String errorMessage;

  _SnackbarState(this.errorMessage);
  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(errorMessage),
    );
  }
}
