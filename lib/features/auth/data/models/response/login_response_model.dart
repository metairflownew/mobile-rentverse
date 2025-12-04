// features/auth/data/models/response/login_response_model.dart
import 'package:rentverse/features/auth/data/models/response/user_model.dart';

class LoginResponseModel {
  final String token;
  final UserModel user;

  LoginResponseModel({required this.token, required this.user});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json['token'] ?? '', // Ambil token di sini
      user: UserModel.fromJson(json), // Ambil user sisanya
    );
  }
}
