import 'package:front/models/chatm.dart';

class UserManager {




static String userId='';

  static void setUserDetails({required String id})
  {
    userId = id;
  
  }





static ChatUser model = ChatUser(
          id: "",
          name: "",
          email: "",
       
          image: "",
          createdAt: "",
          isOnline: false,
          lastActive: "",
          pushToken: "");

  static void setchat({required ChatUser models})
  {
    model = models;
  
  }




static String jobId='';

  static void setjobDetails({required String id})
{
    jobId = id;

}


static String description='';

  static void setdescription({required String description1})
{
    description = description1;

}

static String requirements='';

  static void setrequirements({required String requirements1})
{
    requirements = requirements1;

}









static String admainId='';

  static void setadmainId({required String id})
{
    admainId = id;

}






static String back='';

  static void setback({required String id})
{
    back = id;

}



static String image='';

  static void setimage({required String image1})
{
    image = image1;

}














  static List<String> questions = [];
  static List<String> answer = [];

  static void setquestions({required String question1}) {
questions.add(question1);
  
  }



  static List<String> option1 = [];

  static void setoption1({required String option}) {
   option1.add(option);
   
  }

     static List<String> option2 = []; 

  static void setoption2({required String option}) {
   option2.add(option);
   
  }
 


  static List<String> option3 = []; 

  static void setoption3({required String option}) {
   option3.add(option);
   
  }

   static List<String> option4 = []; 

  static void setoption4({required String option}) {
   option4.add(option);
   
  }

  
}

