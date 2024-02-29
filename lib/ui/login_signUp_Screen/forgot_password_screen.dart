import 'dart:convert';

import 'package:faculty_app/blocs/auth_bloc.dart';
import 'package:faculty_app/models/common_response.dart';
import 'package:faculty_app/network/api_provider.dart';
import 'package:faculty_app/ui/login_signUp_Screen/login_screen.dart';
import 'package:faculty_app/utils/api_helper.dart';
import 'package:faculty_app/utils/string_formatter_and_validator.dart';
import 'package:faculty_app/widgets/app_dialogs.dart';
import 'package:faculty_app/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../network/apis.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  AuthBloc _authBloc = AuthBloc();

  final TextFieldControl _email = TextFieldControl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [secondaryColor, primaryColor],
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Colors.white),
        title: const Text(
          "Forgot password",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Enter email address",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              AppTextBox(
                textFieldControl: _email,
                prefixIcon: Icon(Icons.email_outlined,color: primaryColor,),
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: SizedBox(
                  height: 50,
                  width: 100,
                  child: ElevatedButton(
                    style:
                    ElevatedButton.styleFrom(primary: primaryColor),
                    child: Text("Submit"),
                    onPressed: () => _validate(context),
                  ),
                ),
              )
            ]),
      ),
    );
  }

  FormatAndValidate formatAndValidate = FormatAndValidate();

  _validate(BuildContext context) async {
    var email = _email.controller.text;

    if (formatAndValidate.validateEmailID(email) != null) {
      return toastMessage(formatAndValidate.validateEmailID(email));
    }
    return _forgotPassword(context,email);
  }

  Future _forgotPassword(context,String email) async {
    AppDialogs.loading();
    Map<String, dynamic> body = {};
    body["email"] = email;
    try {
      CommonResponse response = await _authBloc.forgotPassword(json.encode(body));
      Get.back();
      if (response.success!) {
        showAlert(context,response.message!);
      } else {
        toastMessage(response.message ?? '');
      }
    } catch (error) {
        Get.back();
        toastMessage('No account registered with this email!...Please enter registered email');
    }
  }


  void showAlert(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("${message}"),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: primaryColor, // Background color
                onPrimary: Colors.white, // Text color
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // Button border radius
                ),
              ),
              onPressed: () {
                Get.to(LoginScreen());
              },
              child: Text(
                'OK',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }
}
