import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/views/common/app_style.dart';

import 'package:front/views/common/height_spacer.dart';
import 'package:front/views/common/reusable_text.dart';
import 'package:front/views/common/width_spacer.dart';
/*
class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key, this.onTap});

  final void Function()? onTap;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: onTap,
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: width * 0.84,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      FeatherIcons.search,
                      color: Color(kDark.value),
                      size: 20,
                    ),
                    WidthSpacer(width: 20),
                    ReusableText(
                        text: "Search for jobs",
                        style:
                            appstyle(18, Color(kDark.value), FontWeight.w500))
                  ],
                ),
              ),
              Icon(
                FontAwesomeIcons.searchengin,
                color: Color(kDarkGrey.value),
                size: 20.h,
              )
            ],
          ),
          HeightSpacer(size: 7),
          Divider(
            color: Color(kDarkGrey.value),
            thickness: 0.5,
            endIndent: 40.w,
          )
        ],
      ),
    );
  }
}


*/



class SearchWidget extends StatelessWidget {
  const SearchWidget({Key? key, this.onTap}) : super(key: key);

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: onTap,

      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: BoxDecoration(
          color: Color(0xFFFAF0E6), // لون الخلفية
         
          borderRadius: BorderRadius.circular(45), // شكل الحدود المستديرة
        ),
       
        child: Column(
          children: [
           
            Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    
                    children: [
                      Icon(
                        FeatherIcons.search,
                        color: Color(kDark.value),
                        size: 20,
                      ),
                      WidthSpacer(width: 20),
                      ReusableText(
                        align: TextAlign.center,
                        text: "Search for jobs",
                        
                        style: appstyle(15, Color(kDark.value), FontWeight.w500),
                      ),
                    ],
                  ),
                ),
               
              ],
            ),
          
             SizedBox(height: 5), 
           /* Divider(
              color: Color(kDarkGrey.value),
              thickness: 0.5,
              endIndent: 40.w,
            )*/
          ],
        ),
      ),
    );
  }
}

