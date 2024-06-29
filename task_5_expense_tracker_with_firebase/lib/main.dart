import 'package:expense_tracker/providers/auth_provider.dart';
import 'package:expense_tracker/providers/email_verification_provider.dart';
import 'package:expense_tracker/providers/expense_provider.dart';
import 'package:expense_tracker/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthServiceProvider()),
        ChangeNotifierProvider(create: (_) => ExpenseServiceProvider()),
        ChangeNotifierProvider(create: (_) => EmailVerificationProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(393, 852),
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            builder: EasyLoading.init(),
            title: 'Expense Tracker',
            initialRoute: AppRoutes.login,
            routes: AppRoutes.routes,
            theme: ThemeData(
              appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
              textTheme: GoogleFonts.lexendTextTheme(),
              scaffoldBackgroundColor: Colors.white,
              primarySwatch: Colors.blue,
            ),
          );
        });
  }
}
