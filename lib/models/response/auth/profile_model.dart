import 'dart:convert';

ProfileRes profileResFromJson(String str) =>
    ProfileRes.fromJson(json.decode(str));

String profileResToJson(ProfileRes data) => json.encode(data.toJson());

class ProfileRes {
  ProfileRes({
    required this.id,
    required this.username,
    required this.email,
    required this.isAdmin,
    required this.isAgent,
    required this.user,
    required this.skills,
    required this.updatedAt,
    required this.location,
    required this.phone,
    required this.profile,
    //   required this.isFreelancer,
  });

  factory ProfileRes.fromJson(Map<String, dynamic> json) => ProfileRes(
        id: json['_id']?? '',
        username: json['username']?? '',
        email: json['email']?? '',
        isAdmin: json['isAdmin']?? '',
        isAgent: json['isAgent']?? '',
        user: json['user']?? '',
        //    isFreelancer: json['isFreelancer'],
        skills: List<String>.from(json['skills'].map((x) => x)?? ''),
        updatedAt: DateTime.parse(json['updatedAt']?? ''),
        location: json['location']?? '',
        phone: json['phone']?? '',
        profile: json['profile']?? '',
      );

  final String id;
  final String username;
  final String email;
  final bool isAdmin;
  final bool isAgent;
  final bool user;
  //final bool isFreelancer;
  final List<String> skills;
  final DateTime updatedAt;
  final String location;
  final String phone;
  final String profile;

  Map<String, dynamic> toJson() => {
        '_id': id,
        'username': username,
        'email': email,
        'isAdmin': isAdmin,
        'isAgent': isAgent,
        'user':user,
        //  'isFreelancer': isFreelancer,
        'skills': List<dynamic>.from(skills.map((x) => x)),
        'updatedAt': updatedAt.toIso8601String(),
        'location': location,
        'phone': phone,
        'profile': profile,
      };
}
