import 'dart:convert';

GetJobRes getJobResFromJson(String str) => GetJobRes.fromJson(json.decode(str));

String getJobResToJson(GetJobRes data) => json.encode(data.toJson());

class GetJobRes {
  GetJobRes({
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
  
    required this.updatedAt,
  });

  factory GetJobRes.fromJson(Map<String, dynamic> json) => GetJobRes(
        id: json["_id"] ?? '', // Provide a default value if '_id' is null
        title:
            json["title"] ?? '', // Provide a default value if 'title' is null
        location: json["location"] ??
            '', // Provide a default value if 'location' is null
        company: json["company"] ??
            '', // Provide a default value if 'company' is null
        // hiring: json["hiring"] ?? false, // Provide a default value if 'hiring' is null
        description: json["description"] ??
            '', // Provide a default value if 'description' is null
        salary:
            json["salary"] ?? '', // Provide a default value if 'salary' is null
        period:
            json["period"] ?? '', // Provide a default value if 'period' is null
        contract: json["contract"] ??
            '', // Provide a default value if 'contract' is null
        requirements: json["requirements"] ??
            [], // Provide a default value if 'requirements' is null or an empty list
        imageUrl: json["imageUrl"] ??
            '', // Provide a default value if 'imageUrl' is null
        adminId: json["adminId"] ??
            '',
      //      user:json["user"]?? '', // Provide a default value if 'adminId' is null
        updatedAt: DateTime.parse(json["updatedAt"] ?? ''),
      );

  final String id;
  final String title;
  final String location;
  final String company;
  // final bool hiring;
  final String description;
  final String salary;
  final String period;
  final String contract;
  final String requirements;
  final String imageUrl;
  final String adminId;
  //final String user;
  final DateTime updatedAt;

  Map<String, dynamic> toJson() => {
        '_id': id,
        'title': title,
        'location': location,
        'company': company,
        //  'hiring': hiring,
        'description': description,
        'salary': salary,
        'period': period,
        'contract': contract,
        'requirements': requirements,
        'imageUrl': imageUrl,
        'adminId': adminId,
       // 'user': user,
        'updatedAt': updatedAt.toIso8601String(),
      };
}