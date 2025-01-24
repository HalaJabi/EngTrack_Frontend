import 'package:flutter/material.dart';

class TProgress extends StatelessWidget {
  String hintText;
  Widget prefix;
 final double? width;
  TextEditingController controller = new TextEditingController();
  TProgress(
      {this.width, required this.hintText, required this.prefix, required this.controller});
  @override
  Widget build(BuildContext context) {
    return Container(
           width: width,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.orange),
          color: Colors.grey.withOpacity(.3),
          borderRadius: BorderRadius.circular(15)),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            prefixIcon: prefix,
            hintText: hintText,
            border: OutlineInputBorder(borderSide: BorderSide.none)),
      ),
    );
  }
}
