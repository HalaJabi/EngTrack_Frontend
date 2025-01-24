import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) =>
    json.encode(data.toJson());

class LoginResponseModel {
  final String id;
  final String profile;
  final String userToken;
  final bool isAdmin;
  final bool isAgent;
  final bool user;
   final String username;
   
  final String email;
  //  final bool isFreelancer;

  LoginResponseModel({
    required this.id,
    required this.profile,
    required this.userToken,
    required this.isAdmin,
    required this.isAgent,
    required this.user,
      required this.username,
        required this.email,
    // required this.isFreelancer,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        id: json["_id"] ??' ',
        profile: json["profile"]??' ',
        userToken: json["userToken"]??' ',
        isAdmin: json["isAdmin"]??' ',
        isAgent: json["isAgent"]??' ',
        user: json["user"]??' ',
        username: json["username"]??' ',
         email: json["email"]??' ',
        //    isFreelancer: json["isFreelancer"]
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "profile": profile,
        "userToken": userToken,
        "isAdmin": isAdmin,
        "isAgent": isAgent,
        "user": user,
         "username": username,
           "email": email,
        //    "isFreelancer":isFreelancer,
      };
}
