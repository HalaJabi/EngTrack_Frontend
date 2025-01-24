

import 'dart:convert';


List<JobsResponse> jobsResponseFromJson(String str) =>
 List<JobsResponse>.from(json.decode(str).map((x) => JobsResponse.fromJson(x)));



//JobsResponse jobResFromJson(String str) => JobsResponse.fromJson(json.decode(str));



class JobsResponse {
    JobsResponse({

        required this.id,
        required this.title,
        required this.location,
        required this.company,
 
        required this.description,
        required this.salary,
        required this.period,
        required this.contract,
        required this.requirements,
        required this.imageUrl,
        required this.adminId,
         // required this.user,
        required this.createdAt,
        required this.updatedAt,
    });

    final String id;
    final String title;
    final String location;
    final String company;
    //final bool hiring;
    final String description;
    final String salary;
    final String period;
    final String contract;
    final String requirements;
    final String imageUrl;
    final String adminId;
   //  final String user;
    final DateTime createdAt;
    final DateTime updatedAt;

    factory JobsResponse.fromJson(Map<String, dynamic> json) => JobsResponse(
    id: json["_id"] ?? '', // Provide a default value if '_id' is null
    title: json["title"] ?? '', // Provide a default value if 'title' is null
    location: json["location"] ?? '', // Provide a default value if 'location' is null
    company: json["company"] ?? '', // Provide a default value if 'company' is null
   // hiring: json["hiring"] ?? false, // Provide a default value if 'hiring' is null
    description: json["description"] ?? '', // Provide a default value if 'description' is null
    salary: json["salary"] ?? '', // Provide a default value if 'salary' is null
    period: json["period"] ?? '', // Provide a default value if 'period' is null
    contract: json["contract"] ?? '', // Provide a default value if 'contract' is null
    requirements:json["requirements"] ?? '', // Provide a default value if 'requirements' is null or an empty list
    imageUrl: json["imageUrl"] ?? '', // Provide a default value if 'imageUrl' is null
    adminId: json["adminId"] ?? '', 
   //  user: json["user"] ?? '', // Provide a default value if 'adminId' is null
    createdAt: DateTime.parse(json["createdAt"] ?? ''), // Provide a default value if 'createdAt' is null or not in valid DateTime format
    updatedAt: DateTime.parse(json["updatedAt"] ?? ''), // Provide a default value if 'updatedAt' is null or not in valid DateTime format
);


}






