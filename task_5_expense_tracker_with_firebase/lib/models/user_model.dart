// models/user_model.dart
class UserModel {
  final String uid;
  String userName;
  final String email;
  final String pfp;
  final bool isVerified;

  UserModel({
    required this.uid,
    required this.userName,
    required this.email,
    required this.pfp,
    required this.isVerified,
  });
}
