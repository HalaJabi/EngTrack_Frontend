import 'package:flutter/material.dart';
import 'package:front/constants/app_constants.dart';
import 'package:front/controllers/quiz_provider.dart';
import 'package:front/helpers/UserManger.dart';
import 'package:front/views/common/app_style.dart';
import 'package:front/views/pages/quiz/textfild.dart';

class Page1 extends StatelessWidget {
  final TextEditingController option1 = TextEditingController();
  final TextEditingController option2 = TextEditingController();
  final TextEditingController option3 = TextEditingController();
  final TextEditingController option4 = TextEditingController();
  final TextEditingController correct = TextEditingController();
  final TextEditingController question = TextEditingController();

  @override
  void dispose() {
    option1.dispose();
    option2.dispose();
    option3.dispose();
    option4.dispose();
    correct.dispose();
    question.dispose();
  }

  bool _validateFields() {
    return option1.text.isNotEmpty &&
        option2.text.isNotEmpty &&
        option3.text.isNotEmpty &&
        option4.text.isNotEmpty &&
      
        question.text.isNotEmpty;
  }

  void _submitForm() {
    if (_validateFields()) {
      print("All fields are filled");

      UserManager.setquestions(question1:question.text);
      UserManager.setoption1(option:option1.text);
      UserManager.setoption2(option:option2.text);
      UserManager.setoption3(option:option3.text);
      UserManager.setoption4(option:option4.text);
    } else {
      // Show a message to the user that some fields are empty
      print("Please fill in all fields");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15),
      child: Column(
        children: [
          TProgress(
           
            controller: question,
            hintText: "Question",
            prefix: Icon(Icons.question_mark),
          ),
          SizedBox(
            height: 15,
          ),
          TProgress(
             width: 250.0,
            controller: option1,
            hintText: "option1",
            prefix: Icon(Icons.question_answer),
          ),
          SizedBox(
            height: 15,
          ),
          TProgress(
             width: 250.0,
            controller: option2,
            hintText: "option2",
            prefix: Icon(Icons.question_answer),
          ),
          SizedBox(
            height: 15,
          ),
          TProgress(
             width: 250.0,
            controller: option3,
            hintText: "option3",
            prefix: Icon(Icons.question_answer),
          ),
          SizedBox(
            height: 15,
          ),
          TProgress(
             width: 250.0,
            controller: option4,
            hintText: "option4",
            prefix: Icon(Icons.question_answer),
          ),
          SizedBox(
            height: 15,
          ),


     
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                
                child: ElevatedButton(
                  onPressed: _submitForm,


                  
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.withOpacity(.3),
                    
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.orange, width: 2), // Border color and width
                      ),
                    
                    ),
                  child: Text("Save",style: appstyle(14, Colors.black, FontWeight.w400),),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
