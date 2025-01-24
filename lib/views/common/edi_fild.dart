import 'package:flutter/material.dart';

class EducationDropdownField extends StatefulWidget {
  final TextEditingController controller;

  const EducationDropdownField({Key? key, required this.controller}) : super(key: key);

  @override
  _EducationDropdownFieldState createState() => _EducationDropdownFieldState();
}

class _EducationDropdownFieldState extends State<EducationDropdownField> {
  String? _selectedEducation;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selectedEducation,
      items: [
        DropdownMenuItem(
          value: 'High School',
          child: Text('High School'),
        ),
        DropdownMenuItem(
          value: 'Bachelor\'s Degree',
          child: Text('Bachelor\'s Degree'),
        ),
        DropdownMenuItem(
          value: 'Master\'s Degree',
          child: Text('Master\'s Degree'),
        ),
        DropdownMenuItem(
          value: 'Doctorate',
          child: Text('Doctorate'),
        ),
      ],
      onChanged: (value) {
        setState(() {
          _selectedEducation = value;
          widget.controller.text = value!;
        });
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFFAF0E6), // Background color
        hintText: 'Select Education', // Hint text
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      ),
      style: TextStyle(
        color: Colors.black, // Change the text color
        fontSize: 16.0, // Adjust font size
      ),
    );
  }
}
