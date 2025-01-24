import 'package:flutter/material.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/views/common/app_style.dart';

class CustomField extends StatelessWidget {
  const CustomField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.validator,
    this.keyboard,
    this.suffixIcon,
    this.obscureText, this.onEditingComplete,this.color, this.hintStyle,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboard;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final void Function()? onEditingComplete;
  final bool? obscureText;
  final  Color? color;
   final TextStyle? hintStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color??Color(kOrange.value),
      child: TextField(
          keyboardType: keyboard,
          obscureText: obscureText ?? false,
          onEditingComplete: onEditingComplete,
          decoration: InputDecoration(
              hintText: hintText.toUpperCase(),
              suffixIcon: suffixIcon,
              suffixIconColor: Color(kLight.value),
               hintStyle: hintStyle?.copyWith(color: Color(kLight.value)), // تعديل هنا
          // contentPadding: EdgeInsets.only(left: 24),
              // contentPadding: EdgeInsets.only(left: 24),
              errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: Colors.white, width: 0.5),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: Colors.transparent, width: 0),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: Colors.red, width: 0.5),
              ),
              disabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: Colors.grey, width: 0),
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: Colors.transparent, width: 0),
              ),
              border: InputBorder.none),
          controller: controller,
          cursorHeight: 25,
          style: appstyle(14, Color(kDark.value), FontWeight.w500),
          onSubmitted: validator),
    );
  }
}
