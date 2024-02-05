import 'dart:async';
import 'dart:convert';
import 'package:faculty_app/blocs/auth_bloc.dart';
import 'package:faculty_app/models/signup_response.dart';
import 'package:faculty_app/ui/admin/admin_home_screen.dart';
import 'package:faculty_app/ui/college/college_home_screen.dart';
import 'package:faculty_app/ui/committe/committe_home_screen.dart';
import 'package:faculty_app/ui/screens/login_signUp_Screen/signup_screen.dart';
import 'package:faculty_app/utils/api_helper.dart';
import 'package:faculty_app/utils/shared_prefs.dart';
import 'package:faculty_app/utils/string_formatter_and_validator.dart';
import 'package:faculty_app/widgets/app_dialogs.dart';
import 'package:faculty_app/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthBloc _authBloc = AuthBloc();

  FormatAndValidate formatAndValidate = FormatAndValidate();
  var _lkey = new GlobalKey<FormState>();
  TextFieldControl _email = TextFieldControl();
  TextFieldControl _password = TextFieldControl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff191970), Color(0xff96DED1)],),
        ),
        child: Form(
          key: _lkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.1,
                ),
                Text("Vetted Profile", style: GoogleFonts.aladin(fontSize: 30,
                    fontWeight: FontWeight.bold,color: Colors.white)),
                // Image.asset(
                //   "assets/images/logoicon.png",
                //   height: 150,
                // ),
                SizedBox(
                  height: 60,
                ),
                Card(
                  child: Container(
                    height: MediaQuery
                      .of(context)
                      .size
                      .height* 0.56,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width* 0.85,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height:10,
                        ),
                        Center(
                            child: Text(
                              "LOGIN",
                              style: GoogleFonts.aladin(
                                  fontWeight: FontWeight.w200, fontSize: 30),
                            )),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                            child: Text(
                              "WELCOME ! Login with your Credentials",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            )),
                        SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                            right: 20,
                            bottom: 5,
                          ),
                          child: Text("Email",style: TextStyle(fontWeight: FontWeight.w500),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                            right: 20,
                            bottom: 10,
                          ),
                          child: AppTextBox(
                            textFieldControl: _email,
                            prefixIcon: Icon(Icons.email_outlined,color: primaryColor,),
                            hintText: 'Email',
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                            right: 20,
                            bottom: 5,
                          ),
                          child: Text("Password",style: TextStyle(fontWeight: FontWeight.w500),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                            right: 20,
                          ),
                          child: AppTextBox(
                            textFieldControl: _password,
                            prefixIcon: Icon(Icons.lock_outlined,color: primaryColor,),
                            hintText: 'Password',
                            obscureText: true,
                            textInputAction: TextInputAction.done,
                          ),
                        ),
                        SizedBox(height: 5),
                        // Align(
                        //   alignment: AlignmentDirectional.bottomEnd,
                        //   child: TextButton(
                        //     onPressed: () {},
                        //     child: Text(
                        //       'Forgot Password ?',
                        //       style: TextStyle(
                        //           color: primaryColor, fontSize: 15),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(height: 15),
                        Center(
                          child: SizedBox(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height* 0.054,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width* 0.23,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all(primaryColor)),
                                onPressed: () {
                                  _validate();
                                },
                                child: Text("LOGIN")),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20, left: 50),
                          child: Row(
                            children: [
                              Text(
                                "Create your account ",
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.004,
                              ),
                              TextButton(
                                  child: Text(
                                    "Sign Up",
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold,
                                        fontSize: 15,color: primaryColor,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  onPressed: () {
                                    Get.to(SignUpScreen());
                                  }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  elevation: 8,
                  shadowColor: Colors.green,
                  margin: EdgeInsets.all(20),
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.blue, width: 1)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


  _validate() async {
    var email = _email.controller.text;
    var password = _password.controller.text;

    if (formatAndValidate.validateEmailID(email) != null) {
      return toastMessage(formatAndValidate.validateEmailID(email));
    } else if (password == "" || password.length < 6) {
      return toastMessage("Password length must be more than 6");
    }
    return await _login(email, password);
  }

  Future _login(String email, String password) async {
    AppDialogs.loading();
    Map<String, dynamic> body = {};
    body["email"] = email;
    body["password"] = password;
    try {
      LoginSignupResponse response = await _authBloc.login(json.encode(body));
      Get.back();
      print("response.status-->${response.status}");
      print("response.success-->${response.success}");
      print("Role--->${response.user!.role}");
      if (response.success!) {
        await SharedPrefs.logIn(response);
        if (response.user!.role == "admin") {
          Get.offAll(() => AdminHomeScreen());
        } else if (response.user!.role == "college") {
          Get.offAll(() => CollegeHomeScreen());
        } else {
          Get.offAll(() => CommitteHomeScreen());
        }
      } else if (response.status == 422) {
        if (response.errors != null) {
          if (response.errors!.email != null &&
              response.errors!.email!.isNotEmpty) {
            toastMessage(response.errors!.email![0] ?? 'Unknown email error');
          }
        } else {
          toastMessage(response.message ?? '');
        }
      } else {
        toastMessage(response.message ?? '');
      }
    } catch (error) {
      if (error is Errors) {
        toastMessage(error.email);
      } else {
        Get.back();
        toastMessage('Something went wrong. Please try again');
      }
    }
  }
  }

