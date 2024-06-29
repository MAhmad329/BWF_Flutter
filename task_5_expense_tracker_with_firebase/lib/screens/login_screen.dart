// screens/login_screen.dart
import 'package:expense_tracker/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../const.dart';
import '../providers/auth_provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Provider.of<AuthServiceProvider>(context, listen: false).errorMessage =
        null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<AuthServiceProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                Column(
                  children: [
                    const Center(
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                            color: AppColors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    const Center(
                      child: Text(
                        'Welcome Back',
                        style: TextStyle(
                          color: AppColors.darkGrey,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            CustomTextField(
                              hintText: 'Email',
                              controller: _emailController,
                              obscureText: false,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Email';
                                }

                                String emailRegex =
                                    r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
                                RegExp regex = RegExp(emailRegex);

                                if (!regex.hasMatch(value)) {
                                  return 'Please Enter a Valid Email';
                                }

                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomTextField(
                              isPasswordField: true,
                              obscureText:
                                  userProvider.isPasswordVisible == true
                                      ? false
                                      : true,
                              controller: _passwordController,
                              hintText: "Enter your Password",
                              suffixTap: () {
                                userProvider.changePasswordVisibility();
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter a password';
                                }

                                return null;
                              },
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            if (userProvider.errorMessage != null)
                              Text(
                                userProvider.errorMessage!,
                                style: const TextStyle(color: Colors.red),
                              ),
                          ],
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          child: const Text(
                            "Forget Password?",
                            style: TextStyle(
                                color: AppColors.primaryGreen, fontSize: 14),
                            textAlign: TextAlign.end,
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, '/forget_password');
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    CustomButton(
                      title: "Sign In",
                      onPress: () {
                        if (_formKey.currentState!.validate()) {
                          userProvider
                              .signInWithEmail(_emailController.text,
                                  _passwordController.text)
                              .then((_) {
                            if (userProvider.user != null) {
                              if (!userProvider.user!.isVerified) {
                                Navigator.pushReplacementNamed(
                                    context, '/email_verification');
                              } else {
                                Navigator.pushReplacementNamed(
                                    context, '/home');
                              }
                            }
                          });
                        }
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(color: AppColors.black),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignupScreen()),
                        );
                      },
                      child: const Text(
                        " Sign Up here",
                        style: TextStyle(
                            color: AppColors.primaryGreen,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
