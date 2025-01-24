import 'package:flutter/material.dart';
import 'package:front/helpers/auth_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/models/response/auth/user.dart';
import 'package:front/views/common/app_style.dart';
import 'package:front/views/common/reusable_text.dart';
import 'package:front/views/common/width_spacer.dart';
import 'package:get/get.dart';

class Profile extends StatefulWidget {
  final String id;

  const Profile({Key? key, required this.id}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late Future<bool> _isAdmin;
  late Future<UserModel?> _adminProfile;

  @override
  void initState() {
    super.initState();
    _isAdmin = AuthHelper.isAdmin(widget.id);
    _adminProfile = AuthHelper.getUserById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: FutureBuilder<bool>(
        future: _isAdmin,
        builder: (context, isAdminSnapshot) {
          if (isAdminSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (isAdminSnapshot.hasError) {
            return Center(child: Text("Error ${isAdminSnapshot.error}"));
          } else {
            if (isAdminSnapshot.data == true) {
              return FutureBuilder<UserModel?>(
                future: _adminProfile,
                builder: (context, profileSnapshot) {
                  if (profileSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (profileSnapshot.hasError) {
                    return Center(child: Text("Error ${profileSnapshot.error}"));
                  } else {
                    final userData = profileSnapshot.data!;

                    return SingleChildScrollView(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.grey,
                            backgroundImage: userData.profile != null
                                ? CachedNetworkImageProvider(userData.profile!)
                                : AssetImage('assets/images/user.png') as ImageProvider,
                          ),
                          SizedBox(height: 10),
                          ReusableText(
                            text: userData.username,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10),
                          ReusableText(
                            text: userData.location,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.orange, width: 2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ReusableText(
                                  text: "Phone Number:",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 5),
                                ReusableText(
                                  text: userData.phone,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.orange, width: 2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ReusableText(
                                  text: "About Us:",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 5),
                                ReusableText(
                                  text: userData.skills[0],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.orange, width: 2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ReusableText(
                                  text: "Specialties:",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 5),
                                ReusableText(
                                  text: userData.skills[1],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.orange, width: 2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ReusableText(
                                  text: "Founded:",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 5),
                                ReusableText(
                                  text: userData.skills[2],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.orange, width: 2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ReusableText(
                                  text: "Services:",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 5),
                                ReusableText(
                                  text: userData.skills[3],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.orange, width: 2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ReusableText(
                                  text: "Website:",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 5),
                                ReusableText(
                                  text: userData.skills[4],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              );
            }
            
            
            
            
            
            
            
            
            
            
            
            
            
            
             else {
              return Scaffold(
            
                body: FutureBuilder<UserModel?>(
                  future: _adminProfile,
                  builder: (context, profileSnapshot) {
                    if (profileSnapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (profileSnapshot.hasError) {
                      return Center(child: Text("Error ${profileSnapshot.error}"));
                    } else {
                      final userData = profileSnapshot.data!;

                      return Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Color(kOrange.value),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 60,
                                        backgroundColor: Color(k5.value),
                                        child: userData.profile == null
                                            ? Image.asset(
                                                'assets/images/user.png',
                                                width: 80,
                                                height: 100,
                                              )
                                            : ClipOval(
                                                child: CachedNetworkImage(
                                                  width: 100,
                                                  height: 100,
                                                  imageUrl: userData.profile!,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                      ),
                                    ],
                                  ),
                                  ReusableText(
                                    text: userData.username,
                                    style: appstyle(18, Color(kDark.value), FontWeight.bold),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.location_pin,
                                        color: Color(k5.value),
                                      ),
                                      const WidthSpacer(width: 5),
                                      ReusableText(
                                        text: userData.location,
                                        style: appstyle(16, Color(k5.value), FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ReusableText(
                                  text: " Presonal Infomation:",
                                  style: appstyle(16, Colors.black, FontWeight.w600),
                                ),
                              ],
                            ),
                            SizedBox(height: 30),


                            Container(


                              width: MediaQuery.of(context).size.width,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                              ),



                              child: Container(


                                  padding: EdgeInsets.only(left: 16),
                                 decoration: BoxDecoration(
                                    border: Border.all(color: Color(kOrange.value)  , width: 2,),
                                   
                                    borderRadius: BorderRadius.circular(20),
                                  ),

                                
                                child: Column(

                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                
                                        ReusableText(
                                
                                          text: "Phone Number:",
                                          style: appstyle(16, Color(kDarkGrey.value), FontWeight.w600),
                                        ),
                                
                                
                                
                                
                                      
                                      ],
                                    ),
                                  SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                
                                        ReusableText(
                                          text: userData.phone,
                                          style: appstyle(16, Colors.black, FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 80,
                              decoration: BoxDecoration(
                                 border: Border.all(color: Color(kOrange.value)  , width: 2,),
                                borderRadius: BorderRadius.circular(30),
                              ),


                                padding: EdgeInsets.only(left: 16),
                        
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      ReusableText(
                                        text: "Years of Experience:",
                                        style: appstyle(16, Color(kDarkGrey.value), FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ReusableText(
                                        text: userData.skills[0],
                                        style: appstyle(16, Colors.black, FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 80,
                              decoration: BoxDecoration(
                                 border: Border.all(color: Color(kOrange.value)  , width: 2,),
                                borderRadius: BorderRadius.circular(30),
                              ),
 padding: EdgeInsets.only(left: 16),


                              
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      ReusableText(
                                        text: "University name:",
                                        style: appstyle(16, Color(kDarkGrey.value), FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ReusableText(
                                        text: userData.skills[1],
                                        style: appstyle(16, Colors.black, FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ReusableText(
                                  text: "Presonal Skilles:",
                                  style: appstyle(16, Colors.black, FontWeight.w600),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Container(



                              width: MediaQuery.of(context).size.width,
                              height: 50,
                               padding: EdgeInsets.only(left: 16),
                              decoration: BoxDecoration(


                                 border: Border.all(color: Color(kOrange.value)  , width: 2,),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ReusableText(
                                    text: userData.skills[4],
                                    style: appstyle(16, Colors.black, FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                               padding: EdgeInsets.only(left: 16),
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              decoration: BoxDecoration(
                                 border: Border.all(color: Color(kOrange.value)  , width: 2,),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ReusableText(
                                    text: userData.skills[3],
                                    style: appstyle(16, Colors.black, FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 10),
                         ReusableText(

                              text: "Github:",
                              style: appstyle(16, Colors.black, FontWeight.w600),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                               padding: EdgeInsets.only(left: 16),
                              decoration: BoxDecoration(
                                 border: Border.all(color: Color(kOrange.value)  , width: 2,),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                     
                                  ReusableText(
                                    text: userData.skills[5],
                                    style: appstyle(16, Colors.black, FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      );
                    }
                  },
                ),
              );
            }
          }
        },
      ),
    );
  }
}
