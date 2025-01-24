import 'package:flutter/material.dart';
import 'package:front/models/request/jobs/cr_job.dart';

import 'package:google_fonts/google_fonts.dart';


class DescriptionTab extends StatelessWidget {
 final CreateJobsRequest? job;
  DescriptionTab({this.job});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          SizedBox(height: 25.0),
          Text(
            "About Company",
            style:GoogleFonts.questrial(
              fontSize: 16.0,
              color: Color(0xFF21202A),
              fontWeight: FontWeight.bold,).copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15.0),
           Text(
            "kkkkkk", // Replace "HI" with your company's about text
            style: GoogleFonts.questrial(
              fontSize: 14.0,
              color: Color(0xFF21202A),
              fontWeight: FontWeight.w300,
              height: 1.5,
            ),
          ),
          SizedBox(height: 25.0),
          Text(
            "Job Requirements",
            style: GoogleFonts.questrial(
              fontSize: 16.0,
              color: Color(0xFF21202A),
              fontWeight: FontWeight.bold,).copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15.0),
     
        ],
      ),
    );
  }
}