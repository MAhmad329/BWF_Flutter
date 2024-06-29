// import 'package:expense_tracker/providers/auth_provider.dart';
// import 'package:expense_tracker/screens/home_screen.dart';
// import 'package:expense_tracker/screens/login_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import 'const.dart';
//
// class AuthWrapper extends StatelessWidget {
//   const AuthWrapper({super.key});
//   @override
//   Widget build(BuildContext context) {
//     final authService = Provider.of<AuthServiceProvider>(context);
//     return StreamBuilder<User?>(
//       stream: authService.loggedInUser,
//       builder: (_, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Scaffold(
//             body: Center(
//               child: CircularProgressIndicator(
//                 color: AppColors.primaryGreen,
//               ),
//             ),
//           );
//         }
//         final User? user = snapshot.data;
//         if (user == null) {
//           return const LoginScreen();
//         } else {
//           return HomeScreen();
//         }
//       },
//     );
//   }
// }
