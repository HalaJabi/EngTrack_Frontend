import 'stage_model.dart';

class Task {
  final String id;
  final String title;
  final String description;
  //final int commentCount;
 // final int attachmentCount;
  final Stage? stage;
  //final ImageProvider? image;

  Task({
    required this.id,
    required this.title,
    required this.description,
   // required this.commentCount,
   // required this.attachmentCount,
    this.stage,
    //this.image,
  });

  Task copyWith({
    String? id,
    String? title,
    String? description,
    //int? commentCount,
    //int? attachmentCount,
    Stage? stage,
    //ImageProvider? image,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
    //  commentCount: commentCount ?? this.commentCount,
   //   attachmentCount: attachmentCount ?? this.attachmentCount,
      stage: stage ?? this.stage,
//image: image ?? this.image,
    );
  }

  static List<Task> tasks = [
    Task(
      id: '1',
      title: 'Build a New eCommerce App',
      description:
          'Building a Flutter eCommerce app involves designing an intuitive user interface, implementing essential features like product catalog.',
    //  commentCount: 3,
      //attachmentCount: 1,
      /*image: const NetworkImage(
        'https://images.unsplash.com/photo-1660748054768-33282c43c318?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1277&q=80',
      ),*/
      stage: Stage.stages[0],
    ),
    Task(
      id: '2',
      title: 'Build a Database Management System',
      description:
          'Design and implement a database management system (DBMS) capable of storing, retrieving.',
      //commentCount: 3,
      //attachmentCount: 0,
      stage: Stage.stages[0],
    ),
    Task(
      id: '3',
      title: 'Create a Flutter Course',
      description:
          'Creating a comprehensive Flutter course involves several key steps to ensure that learners receive a thorough understanding of the framework and its capabilities.',
      //commentCount: 2,
     // attachmentCount: 1,
      stage: Stage.stages[0],
    ),
    Task(
      id: '4',
      title: 'Create a Machine Learning Model',
      description:
          ' Collect and preprocess data, choose appropriate algorithms, train and evaluate the model, and deploy it in a production environment.',
     // commentCount: 3,
    // attachmentCount: 0,
      stage: Stage.stages[0],
    ),
    Task(
      id: '5',
      title: 'Create a Recipe App',
      description:
          ' Develop an app that provides users with a collection of recipes for various cuisines and dietary preferences.',
     // commentCount: 3,
     // attachmentCount: 0,
      stage: Stage.stages[1],
    ),
    Task(
      id: '6',
      title: 'Develop a Real-Time Chat Application',
      description:
      'Create a real-time chat application that allows users to exchange text messages.',
      //commentCount: 3,
      //attachmentCount: 0,
      stage: Stage.stages[2],
    ),
  ];
}
