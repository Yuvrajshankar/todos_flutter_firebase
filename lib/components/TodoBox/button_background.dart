import 'package:flutter/material.dart';
import 'package:todos_flutter_firebase/utils/colors.dart';

class ButtonBackground extends StatelessWidget {
  final Icon icon;
  final Function() onTap;

  const ButtonBackground({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 40.0,
        width: 40.0,
        decoration: BoxDecoration(
          color: buttonBackColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        // padding: EdgeInsets.all(8.0),
        child: IconButton(
          onPressed: onTap,
          icon: icon,
          iconSize: 20.0,
        ),
      ),
    );
  }
}
