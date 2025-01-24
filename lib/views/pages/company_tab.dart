import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class CompanyTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          SizedBox(height: 25.0),
          Text(
            "description",
            style: GoogleFonts.questrial(
              fontSize: 16.0,
              color: Color(0xFF21202A),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15.0),
          Text(
            "HI", // Replace "HI" with your company's about text
            style: GoogleFonts.questrial(
              fontSize: 14.0,
              color: Color(0xFF21202A),
              fontWeight: FontWeight.w300,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}