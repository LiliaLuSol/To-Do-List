import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    Key? key,
    required this.controller,
    this.focusNode,
    this.autofocus = true,
    this.textStyle,
    this.obscureText = false,
    this.textInputType = TextInputType.text,
    this.maxLines,
    required this.hintText,
    this.hintStyle,
    this.prefix,
    this.suffix,
    this.fillColor,
    this.validator,
    this.onChanged,
    this.enabled,
    this.maxLength,
    this.hintColor,
  }) : super(
          key: key,
        );

  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool? autofocus;
  final TextStyle? textStyle;
  final bool? obscureText;
  final TextInputType? textInputType;
  final int? maxLines;
  final int? maxLength;
  final String? hintText;
  final TextStyle? hintStyle;
  final Widget? prefix;
  final Widget? suffix;
  final Color? fillColor;
  final Color? hintColor;
  final bool? enabled;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      focusNode: focusNode ?? FocusNode(),
      autofocus: autofocus!,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Colors.black,
      ),
      obscureText: obscureText!,
      keyboardType: textInputType,
      maxLines: textInputType == TextInputType.multiline ? 3 : 1,
      maxLength: maxLength,
      decoration: InputDecoration(
        counterText: "",
        fillColor: fillColor,
        filled: true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        hintText: hintText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w300,
          color: hintColor,
        ),
        prefixIcon: prefix,
        suffixIcon: suffix,
        errorStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Colors.red,
        ),
        focusColor: Colors.white70,
        hoverColor: Colors.white70,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (val) => val!.isEmpty ? 'required' : null,
      enabled: enabled,
      cursorColor: fillColor,
    );
  }
}
