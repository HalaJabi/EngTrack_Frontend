import 'dart:convert';

List<WebRes> webResFromJson(String str) => List<WebRes>.from(json.decode(str).map((x) => WebRes.fromJson(x)));

String webResToJson(List<WebRes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WebRes {
    final String id;
    final String title;
    final String location;
    final String company;
    final String description;
    final String salary;
    final String period;
    final String contract;
    final String adminId;
    final String requirements;
    final DateTime createdAt;
    final DateTime updatedAt;

    WebRes({
        required this.id,
        required this.title,
        required this.location,
        required this.company,
        required this.description,
        required this.salary,
        required this.period,
        required this.contract,
        required this.adminId,
        required this.requirements,
        required this.createdAt,
        required this.updatedAt,
            });

    factory WebRes.fromJson(Map<String, dynamic> json) => WebRes(
        id: json["_id"]  ?? '',
        title: json["title"] ?? '',
        location: json["location"] ?? '',
        company: json["company"] ?? '',
        description: json["description"] ?? '',
        salary: json["salary"] ?? '',
        period: json["period"] ?? '',
        contract: json["contract"] ?? '',
        adminId: json["adminId"] ?? '',
        requirements: json["requirements"] ?? '',
        createdAt: DateTime.parse(json["createdAt"] ?? '',),
        updatedAt: DateTime.parse(json["updatedAt"] ?? '',),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "location": location,
        "company": company,
        "description": description,
        "salary": salary,
        "period": period,
        "contract": contract,
        "adminId": adminId,
        "requirements": requirements,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}