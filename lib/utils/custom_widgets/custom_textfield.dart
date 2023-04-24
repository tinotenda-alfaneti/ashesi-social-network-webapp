import 'package:ashesi_social_network/utils/custom_styles.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController fieldController;
  final String labelText;
  final TextInputType keyboardType;

  const CustomTextField(
      {required this.fieldController,
      required this.keyboardType,
      required this.labelText,
      super.key});

  @override
  State<CustomTextField> createState() =>
      _CustomTextFieldState(fieldController, keyboardType, labelText);
}

class _CustomTextFieldState extends State<CustomTextField> {
  final TextEditingController fieldController;
  final String labelText;
  final TextInputType keyboardType;

  _CustomTextFieldState(
      this.fieldController, this.keyboardType, this.labelText);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 5),
      child: TextField(
        style: textFieldStyle,
        controller: fieldController,
        enableSuggestions: false,
        autocorrect: false,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
        ),
      ),
    );
  }
}
