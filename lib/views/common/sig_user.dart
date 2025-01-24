import 'package:flutter/material.dart';

class EducationDropdownsignup extends StatefulWidget {
  final TextEditingController controller;

  const EducationDropdownsignup({Key? key, required this.controller}) : super(key: key);

  @override
  _EducationDropdownsignupState createState() => _EducationDropdownsignupState();
}

class _EducationDropdownsignupState extends State<EducationDropdownsignup> {
  String? _selectedEducation;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selectedEducation,
      items: [
        DropdownMenuItem(
          value: 'Company',
          child: Text('Company'),
        ),
        DropdownMenuItem(
          value: 'Engineer',
          child: Text('Engineer'),
        ),
        DropdownMenuItem(
          value: 'User',
          child: Text('User'),
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
        hintText: 'What is your account type', // Hint text
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      ),
      style: TextStyle(
        color: Colors.black, // Change the text color
        fontSize: 16.0, // Adjust font size
      ),
      
    );
  }
}
