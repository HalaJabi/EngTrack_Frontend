import 'package:flutter/material.dart';
  //import 'package:tasks/theme.dart';

class MyButton extends StatelessWidget {
  final Function? onTap;
  final String? label;

  MyButton({
    this.onTap,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        height: 50,
        width: 130,
        decoration: BoxDecoration(
          color: Color(0xffFE7A36),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(
          child: Text(
            label!,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}


