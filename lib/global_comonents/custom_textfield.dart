import 'package:flutter/material.dart';
import '../settings/constants.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.suffixIcon,
      this.keyboardType,
      this.obscureText = false,
      this.maxLength,
      this.maxLines,
      this.errorText,
      required this.onChange,
      this.textAlign,
      this.prefix,
      this.enabled,
      this.onTap,
      this.labelText,
      this.focusNode});
  final TextEditingController controller;
  final String hintText;
  final String? labelText;
  final String? errorText;
  final Widget? suffixIcon;
  final Widget? prefix;
  final bool obscureText;
  final bool? enabled;
  final FocusNode? focusNode;

  final TextInputType? keyboardType;
  final VoidCallback onChange;
  final VoidCallback? onTap;
  final int? maxLength;
  final int? maxLines;
  final TextAlign? textAlign;
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0),
      child: TextFormField(
        enabled: widget.enabled,
        controller: widget.controller,
        textAlign: widget.textAlign ?? TextAlign.start,

        // cursorHeight: 17,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText,
        cursorColor: Colors.black,
        onChanged: (value) {
          widget.onChange();
        },
        maxLines: widget.maxLines ?? 1,

        maxLength: widget.maxLength,
        focusNode: widget.focusNode,
        onTap: widget.onTap,

        decoration: InputDecoration(
          prefixIcon: widget.prefix,
          labelText: widget.labelText,
          contentPadding: widget.maxLines != null
              ? null
              : EdgeInsets.symmetric(vertical: 0, horizontal: 17),
          errorText: widget.errorText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.black,
            ),
            gapPadding: 0,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.black,
            ),
            gapPadding: 0,
          ),
          hintText: widget.hintText,
          hintStyle: Constants.Montserrat.copyWith(
            color: Colors.grey,
            fontSize: 13,
          ),
          suffixIcon: widget.suffixIcon,
        ),
      ),
    );
  }
}
