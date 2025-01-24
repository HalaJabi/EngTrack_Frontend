import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/controllers/image_provider.dart';
import 'package:front/controllers/login_provider.dart';
import 'package:front/models/profile_update_model.dart';
import 'package:front/views/common/app_bar.dart';
import 'package:front/views/common/app_style.dart';
import 'package:front/views/common/custom_btn.dart';
import 'package:front/views/common/custom_textfield.dart';
import 'package:front/views/common/height_spacer.dart';
import 'package:front/views/common/reusable_text.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';

class update_user extends StatefulWidget {
  const update_user({super.key});

  @override
  State<update_user> createState() => _update_userState();
}

class _update_userState extends State<update_user> {
  TextEditingController phone = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController about_us = TextEditingController();
  TextEditingController Specialties = TextEditingController();

  @override
  void dispose() {
    phone.dispose();
    location.dispose();
    about_us.dispose();
    Specialties.dispose();
   
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(



         appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: 'Update Profile',
          child: GestureDetector(
            onTap: Get.back,
            child: const Icon(Icons.arrow_back),
          ),
        ),
      ),


      
     body: Consumer<LoginNotifier>(
      builder: (context, loginNotifier, child) {

        return Form(
          key: loginNotifier.profileFormKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 60.h),
            children: [
            Row(



               mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Consumer<ImageUpoader>(
                        builder: (context, imageUploader, child) {
                          return imageUploader.imageFil.isEmpty
                              ? GestureDetector(
                                  onTap: () {
                                    imageUploader.pickImage();
                                  },
                                  child: CircleAvatar(
                                     radius: 60,
                
                                    backgroundColor:  Color(k5.value),
                                    // backgroundImage: ,
                                    child: const Center(
                                      child: Icon(Icons.photo_filter_rounded),
                                    ),
                                  ),

                                )
                              : GestureDetector(
                           
                                  onTap: () {
                                    imageUploader.imageFil.clear();
                                    setState(() {});
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Color(kLightBlue.value),
                                    backgroundImage:
                                        FileImage(File(imageUploader.imageFil[0])),
                                  ),
                                );
                        },
                      ),
              ],
            ),
            
  const HeightSpacer(size: 10),
                  ReusableText(
                    align: TextAlign.center,
                      text: "Company Logo",
                      style: appstyle(14, Color(kDark.value), FontWeight.w600)),



          



/*  ReusableText(




                    
                      text: "Company Profile",
                      style: appstyle(35, Color(kDark.value), FontWeight.bold)),*/

              const HeightSpacer(size: 20),
              Form(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    controller: location,
                    hintText: "Location",
                    keyboardType: TextInputType.text,
                  suffixIcon: const Icon(Icons.location_on, color: Color(0xffFE7A36)),
                  ),




                  const HeightSpacer(size: 10),
                  CustomTextField(
                    controller: phone,
                    hintText: "Phone Number",
                    keyboardType: TextInputType.phone,
                 suffixIcon: const Icon(Icons.phone, color: Color(0xffFE7A36)),
                  ),








const HeightSpacer(size: 10),

                  CustomTextField(
                    
                    controller: about_us,
                    hintText: "About us",
                    keyboardType: TextInputType.text, line: 3,
                     suffixIcon: const Icon(Icons.group, color: Color(0xffFE7A36)),
                  
                  ),







                  const HeightSpacer(size: 10),
                  CustomTextField(
                    controller: Specialties,
                    hintText: "Specialties",
                    keyboardType: TextInputType.text,
                    suffixIcon: const Icon(Icons.category, color: Color(0xffFE7A36)),
                  ),





           



                  const HeightSpacer(size: 20),
                  Consumer<ImageUpoader>(
                    builder: (context, imageUploada, child) {
                      
return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomButton(
                              
                            width: 200,
                            height: 50,
                            color: Color(kOrange.value),
                              onTap: () {
                                if (imageUploada.imageFil.isEmpty &&
                                    imageUploada.imageUrl == null) {
                                  Get.snackbar("Image Missing",
                                      "Please upload an image to proceed",
                                      colorText: Color(kLight.value),
                                      backgroundColor: Color(kLightBlue.value),
                                      icon: const Icon(Icons.add_alert));
                                } 
                                
                                else {
                          
                          
                                  ProfileUpdateReq model = ProfileUpdateReq(
                                      location: location.text,
                                      phone: phone.text,
                                      profile: imageUploada.imageUrl.toString(),
                                      skills: [
                                        about_us.text,
                                        Specialties.text,
                                    
                                      ]);
                          
                                   loginNotifier.updateProfile(model);
                                }
                              },
                              text: "Update Profile"),
                        ],
                      );
                    },
                  )
                ],
              ))
            ],
          ),
        );
      },
    )
    );
  }
}
