import 'package:flutter/material.dart';

import '../screens/email_verification_screen.dart';
import '../screens/forget_password_screen.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/signup_screen.dart';

class AppRoutes {
  static const String home = '/home';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgetPassword = '/forget_password';

  static const String emailVerification = '/email_verification';
  static Map<String, WidgetBuilder> routes = {
    home: (context) => HomeScreen(),
    login: (context) => const LoginScreen(),
    signup: (context) => const SignupScreen(),
    forgetPassword: (context) => const ForgetPassword(),
    emailVerification: (context) => const EmailVerificationScreen(),
  };
}
