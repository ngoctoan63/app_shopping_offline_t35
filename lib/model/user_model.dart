import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  String displayName;
  String userId;
  String email;
  String imgURL;
  String firstName;
  String lastName;
  String phoneNumber;
  String address;
  UserModel({
    this.displayName = '',
    required this.userId,
    required this.email,
    this.imgURL = '',
    this.firstName = '',
    this.lastName = '',
    this.phoneNumber = '',
    this.address = '',
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'displayName': displayName,
      'userId': userId,
      'email': email,
      'imgURL': imgURL,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'address': address,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      displayName: map['displayName'] as String,
      userId: map['userId'] as String,
      email: map['email'] as String,
      imgURL: map['imgURL'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      phoneNumber: map['phoneNumber'] as String,
      address: map['address'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
