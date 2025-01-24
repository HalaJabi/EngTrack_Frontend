import 'package:flutter/material.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/views/common/app_style.dart';
import 'package:front/views/common/reusable_text.dart';

class HeadingWidget extends StatelessWidget {
  const HeadingWidget({super.key, required this.text, this.onTap});
  final String text;
  final void Function()? onTap;
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ReusableText(
            text: text,
            style: appstyle(20, Color(kDark.value), FontWeight.w600)),
        GestureDetector(
          onTap: onTap,
          child: ReusableText(
              text: "See all",
              style: appstyle(18, Color(kOrange.value), FontWeight.w500)),
        )
      ],
    );
  }
}
