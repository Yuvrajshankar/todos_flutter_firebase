import 'package:flutter/material.dart';
import 'package:todos_flutter_firebase/utils/colors.dart';

void showCustomPopup({
  required BuildContext context,
  required Widget content,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: content,
        backgroundColor: navColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(
              color: textColor,
            )),
      );
    },
  );
}
