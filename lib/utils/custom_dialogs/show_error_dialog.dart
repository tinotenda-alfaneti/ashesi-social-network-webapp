import 'package:ashesi_social_network/utils/custom_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showDialog(
    context: context,
    builder: ((context) {
      return AlertDialog(
        title: const Text("ERROR"),
        content: Text(
          text,
          style: GoogleFonts.ubuntu(color: themeColor),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("OK"),
          )
        ],
      );
    }),
  );
}
