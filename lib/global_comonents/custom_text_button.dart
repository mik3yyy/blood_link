import 'package:flutter/material.dart';
import '../settings/constants.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
      {super.key,
      required this.text,
      this.fontsize,
      required this.onPressed,
      this.minWidth = 40,
      this.color,
      this.height,
      this.width});
  final String text;
  final double? fontsize;
  final VoidCallback onPressed;
  final double? minWidth;
  final double? width;
  final double? height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: minWidth,
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Center(
        child: Text(
          text,
          style: Constants.Montserrat.copyWith(
            color: color ?? Constants.black,
            fontSize: fontsize,
          ),
        ),
      ),
    );
  }
}
