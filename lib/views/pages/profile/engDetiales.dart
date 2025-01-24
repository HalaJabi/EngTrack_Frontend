import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/controllers/image_provider.dart';
import 'package:front/controllers/login_provider.dart';
import 'package:front/models/profile_update_model.dart';
import 'package:front/views/common/app_style.dart';
import 'package:front/views/common/custom_btn.dart';
import 'package:front/views/common/custom_textfield.dart';
import 'package:front/views/common/edi_fild.dart';
import 'package:front/views/common/height_spacer.dart';
import 'package:front/views/common/reusable_text.dart';
import 'package:front/views/common/width_spacer.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({super.key});

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  TextEditingController phone = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController exper = TextEditingController();
  TextEditingController un_name = TextEditingController();
  TextEditingController skill2 = TextEditingController();
  TextEditingController skill3 = TextEditingController();
  TextEditingController skill4 = TextEditingController();
  TextEditingController _skillController = TextEditingController();

  @override
  void dispose() {
    phone.dispose();
    location.dispose();
    exper.dispose();
    un_name.dispose();
    skill2.dispose();
    skill3.dispose();
    skill4.dispose();
    _skillController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    
    return Scaffold(body: Consumer<LoginNotifier>(
      builder: (context, loginNotifier, child) {
        return Form(
          key: loginNotifier.profileFormKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 60.h),
            children: [
              Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  WidthSpacer(width: 100),
                  Consumer<ImageUpoader>(
                    builder: (context, imageUploader, child) {
                      return imageUploader.imageFil.isEmpty
                          ? GestureDetector(
                              onTap: () {
                                imageUploader.pickImage();
                              },
                              child: CircleAvatar(
                                radius: 60,
                                backgroundColor: Color(k5.value),
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
                                backgroundColor: Color(kOrange.value),
                                backgroundImage:
                                    FileImage(File(imageUploader.imageFil[0])),
                              ),
                            );
                    },
                  )
                ],
              ),
              const HeightSpacer(size: 20),
              Form(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      WidthSpacer(width: 100),
                      ReusableText(
                          text: "Profile Details ",
                          style: appstyle(18, Colors.black, FontWeight.bold)),
                    ],
                  ),
                  const HeightSpacer(size: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomTextField(
                      
                        width: 150,
                        controller: location,
                        hintText: "Location",
                        keyboardType: TextInputType.text,
                        suffixIcon: Icon(Icons.location_on),
                      ),
                      WidthSpacer(width: 10),
                      CustomTextField(
                          width: 150,
                          controller: phone,
                          hintText: "Phone Number",
                          keyboardType: TextInputType.phone,
                          suffixIcon: Icon(Icons.phone)),
                    ],
                  ),



const HeightSpacer(size: 20),


   Column(
            children: [
              EducationDropdownField(
                controller: _skillController,
              ),
            ],
          ),


const HeightSpacer(size: 20),


 CustomTextField(
      controller: exper,
      hintText: 'Years of Experience:',
           keyboardType: TextInputType.text,
      
   )

,


 

const HeightSpacer(size: 20),


 CustomTextField(
      controller: un_name,
      hintText: 'University Name',
           keyboardType: TextInputType.text,
     
   )

,

const HeightSpacer(size: 20),
 CustomTextField(
                    controller: skill4,
                    hintText: "Github",
                    keyboardType: TextInputType.text,
                    
                  ),





















                  const HeightSpacer(size: 10),
                  ReusableText(
                      text: "Your Skills",
                      style: appstyle(15, Color(kDark.value), FontWeight.bold)),
                  const HeightSpacer(size: 10),


        
                  //const HeightSpacer(size: 10),
                  CustomTextField(
                    controller: skill2,
                    hintText: "Skills",
                    keyboardType: TextInputType.text,
                    
                  ),
                  const HeightSpacer(size: 10),
                  CustomTextField(
                    controller: skill3,
                    hintText: "Skills",
                    keyboardType: TextInputType.text,
                    
                  ),

                      const HeightSpacer(size: 10),
                 
              
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
                                } else {
                                  ProfileUpdateReq model = ProfileUpdateReq(
                                      location: location.text,
                                      phone: phone.text,
                                      profile: imageUploada.imageUrl.toString(),
                                      skills: [
                                        exper.text,
                                        un_name.text,
                                        _skillController .text,
                                        skill2.text,
                                        skill3.text,
                                        skill4.text,
                                      
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
    ));
  }
}












