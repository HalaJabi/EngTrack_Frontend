import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/views/common/app_bar.dart';
import 'package:front/views/common/custom_btn.dart';
import 'package:front/views/common/height_spacer.dart';
import 'package:front/views/pages/quiz/eng_quiz.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
/*

class UploadPDF extends StatelessWidget {

    

    

  var uuid = Uuid();
double similarityScore = 0.0;

  



  Future<File?> pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      return File(result.files.single.path!);
    } else {
      return null;
    }
  }

  Future<firebase_storage.UploadTask?> uploadFile(File? file) async {
    if (file == null) {
      print("No file was picked");
      return null;
    }
    firebase_storage.UploadTask? uploadTask;
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('file')
        .child("${uuid.v1()}.pdf");

    final metadata = firebase_storage.SettableMetadata(
        contentType: 'application/pdf',
        customMetadata: {'picked-file-path': file.path});
    print("uploading");
    uploadTask = ref.putFile(file, metadata);
    print("done");
    return uploadTask;
  }











  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: ('Apply now'),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(CupertinoIcons.arrow_left),
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'To complete job Steps',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SliderP(),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const HeightSpacer(size: 100),
                Text(
                  'Step 1:Please Upload your CV',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                  width: 230,
                  height: 50,
                  color: Color(kOrange.value),
                  onTap: () async {


          
                    // Call function to pick PDF
                    File? file = await pickPDF();

                    if (file != null) {
                      // Upload file to Firebase Storage
                      firebase_storage.UploadTask? uploadTask =
                          await uploadFile(file);
                      if (uploadTask != null) {
                        // Handle successful upload
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('File uploaded successfully'),
                          ),

                        );



                      //   await uploadPDFAndCheckSimilarity(context);
                      } else {
                        // Handle unsuccessful upload
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Failed to upload file'),
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('No file was picked'),
                        ),
                      );
                    }
                  },
                  text: "Pick and Upload PDF"),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              'Step 2:Please Go to quiz',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                  width: 230,
                  height: 50,
                  color: Color(kOrange.value),
                  onTap: () {
                    Get.to(welcom_quiz());
                  },
                  text: "Go to quiz"),
            ],
          ),





        ],
      ),
    );
  }
}

class SliderP extends StatefulWidget {
  SliderP({Key? key}) : super(key: key);

  @override
  State<SliderP> createState() => _SliderPState();
}

class _SliderPState extends State<SliderP> {
  int activeIndex = 0;
  final controller = CarouselController();
  final urlImages = [
    'https://img.freepik.com/premium-vector/questionnaire-clipboard-evaluation-planning-project_1200-422.jpg?w=740',
    'https://i.pinimg.com/564x/bd/07/0c/bd070c4d518330e6ad48f4e31ce626c7.jpg',
    'https://i.pinimg.com/564x/ab/e6/be/abe6be59033330ad371639996de14b81.jpg',
    'https://i.pinimg.com/564x/cb/60/47/cb60470c48cf43854156aaa4822808cf.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          carouselController: controller,
          itemCount: urlImages.length,
          itemBuilder: (context, index, realIndex) {
            final urlImage = urlImages[index];
            return buildImage(urlImage, index);
          },
          options: CarouselOptions(
            height: 200,
            autoPlay: true,
            enableInfiniteScroll: false,
            autoPlayAnimationDuration: Duration(seconds: 2),
            enlargeCenterPage: true,
            onPageChanged: (index, reason) =>
                setState(() => activeIndex = index),
          ),
        ),
        SizedBox(height: 12),
        buildIndicator(),
      ],
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        onDotClicked: animateToSlide,
        effect: ExpandingDotsEffect(
            dotWidth: 15, activeDotColor: Color(0xffFE7A36)),
        activeIndex: activeIndex,
        count: urlImages.length,
      );

  void animateToSlide(int index) => controller.animateToPage(index);
}

Widget buildImage(String urlImage, int index) => Container(
      child: Image.network(urlImage, fit: BoxFit.cover),
    );
*/
import 'dart:convert';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/views/common/app_bar.dart';
import 'package:front/views/common/custom_btn.dart';
import 'package:front/views/common/height_spacer.dart';
import 'package:front/views/pages/quiz/eng_quiz.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:http/http.dart' as http;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class UploadPDF extends StatefulWidget {
  @override
  _UploadPDFState createState() => _UploadPDFState();
}

class _UploadPDFState extends State<UploadPDF> {
  var uuid = Uuid();

  double similarityScore = 0.0; // Variable to hold the similarity score


  Future<File?> pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      return File(result.files.single.path!);
    } else {
      return null;
    }
  }

  Future<void> uploadPDFAndCheckSimilarity(File file) async {
    var uri = Uri.parse('http://192.168.1.21:5000/upload'); // Replace with server URL

    var request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('file', file.path));

    var response = await request.send();
print('Response status code: ${response.statusCode}');

    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      var json = jsonDecode(responseData);
      setState(() {
        similarityScore = json['average_similarity_score']; // Update the score
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('File uploaded successfully. Similarity score: $similarityScore%')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload file')),
      );
    }
  }





  Future<firebase_storage.UploadTask?> uploadFileToFirebase(File? file) async {
    if (file == null) {
      print("No file was picked");
      return null;
    }
    firebase_storage.UploadTask? uploadTask;
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('file')
        .child("${uuid.v1()}.pdf");

    final metadata = firebase_storage.SettableMetadata(
        contentType: 'application/pdf',
        customMetadata: {'picked-file-path': file.path});
    print("uploading");
    uploadTask = ref.putFile(file, metadata);
    print("done");
    return uploadTask;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: ('Apply now'),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(CupertinoIcons.arrow_left),
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'To complete job Steps',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SliderP(),
        /*  Padding(

            padding: const EdgeInsets.all(10),
            child: Column(
              children: [



                const HeightSpacer(size: 100),
                Text(
                  'Step 1: Please Upload your CV',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                // Display similarity score if it's greater than 0
                if (similarityScore > 0)
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      'Similarity Score: ${similarityScore.toStringAsFixed(2)}%',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),
              ],
            ),
          ),*/
     




/*
    
         Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [



              
              CustomButton(
                width: 230,
                height: 50,
                color: Color(kOrange.value),
                onTap: () async {
                  // Call function to pick PDF



                  File? file = await pickPDF();

                  if (file != null) {
                    // Upload file to Firebase Storage
                    firebase_storage.UploadTask? uploadTask = await uploadFileToFirebase(file);
                    if (uploadTask != null) {
                      // Handle successful upload
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('File uploaded to Firebase successfully')),
                      );

                      // Upload PDF and check similarity score
                      await uploadPDFAndCheckSimilarity(file);
                    } else {
                      // Handle unsuccessful upload
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to upload file to Firebase')),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('No file was picked')),
                    );
                  }
                },
                text: "Pick and Upload PDF",
              ),
            ],
          ),


*/


















          Column(
            
            children: [
                 const HeightSpacer(size: 100),
              Padding(
                
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Please Go to quiz',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                width: 230,
                height: 50,
                color: Color(kOrange.value),
                onTap: () {
                  Get.to(welcom_quiz());
                },
                text: "Go to quiz",
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SliderP extends StatefulWidget {
  SliderP({Key? key}) : super(key: key);

  @override
  State<SliderP> createState() => _SliderPState();
}

class _SliderPState extends State<SliderP> {
  int activeIndex = 0;
  final controller = CarouselController();
  final urlImages = [
    'https://img.freepik.com/premium-vector/questionnaire-clipboard-evaluation-planning-project_1200-422.jpg?w=740',
    'https://i.pinimg.com/564x/bd/07/0c/bd070c4d518330e6ad48f4e31ce626c7.jpg',
    'https://i.pinimg.com/564x/ab/e6/be/abe6be59033330ad371639996de14b81.jpg',
    'https://i.pinimg.com/564x/cb/60/47/cb60470c48cf43854156aaa4822808cf.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          carouselController: controller,
          itemCount: urlImages.length,
          itemBuilder: (context, index, realIndex) {
            final urlImage = urlImages[index];
            return buildImage(urlImage, index);
          },
          options: CarouselOptions(
            height: 200,
            autoPlay: true,
            enableInfiniteScroll: false,
            autoPlayAnimationDuration: Duration(seconds: 2),
            enlargeCenterPage: true,
            onPageChanged: (index, reason) => setState(() => activeIndex = index),
          ),
        ),
        SizedBox(height: 12),
        buildIndicator(),
      ],
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
    onDotClicked: animateToSlide,
    effect: ExpandingDotsEffect(
      dotWidth: 15,
      activeDotColor: Color(0xffFE7A36),
    ),
    activeIndex: activeIndex,
    count: urlImages.length,
  );

  void animateToSlide(int index) => controller.animateToPage(index);
}

Widget buildImage(String urlImage, int index) => Container(
  child: Image.network(urlImage, fit: BoxFit.cover),
);
