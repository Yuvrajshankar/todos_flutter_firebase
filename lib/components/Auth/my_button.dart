import 'package:flutter/material.dart';
import 'package:todos_flutter_firebase/utils/colors.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final Widget content;

  const MyButton({
    super.key,
    required this.onTap,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: selectColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: content,
        ),
      ),
    );
  }
}
