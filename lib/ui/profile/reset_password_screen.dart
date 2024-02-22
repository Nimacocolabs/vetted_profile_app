import 'dart:async';
import 'dart:convert';
import 'package:faculty_app/blocs/profile_bloc.dart';
import 'package:faculty_app/models/common_response.dart';
import 'package:faculty_app/ui/profile/profile_screen.dart';
import 'package:faculty_app/utils/api_helper.dart';
import 'package:faculty_app/utils/string_formatter_and_validator.dart';
import 'package:faculty_app/widgets/app_dialogs.dart';
import 'package:faculty_app/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextFieldControl _oldPassword = TextFieldControl();
  TextFieldControl _password = TextFieldControl();
  TextFieldControl _confirmPassword = TextFieldControl();

  FormatAndValidate formatAndValidate = FormatAndValidate();

  late ProfileBloc _bloc;

  @override
  void initState() {
    _bloc = ProfileBloc();
    super.initState();
  }

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
          "Reset password",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Current Password",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                AppTextBox(
                  textFieldControl: _oldPassword,
                  hintText: 'Enter your password',
                  obscureText: true,
                ),
                Text(
                  "New Password",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                AppTextBox(
                  textFieldControl: _password,
                  hintText: 'Enter your password',
                  obscureText: true,
                ),
                Text(
                  "Confirm password",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                AppTextBox(
                  textFieldControl: _confirmPassword,
                  hintText: 'Confirm your password',
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: SizedBox(
                    width: 300,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        _validatePassword();
                      },
                      style: ElevatedButton.styleFrom(primary: primaryColor),
                      child: Text("Reset Password"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  _validatePassword() async {
    var oldPassword = _oldPassword.controller.text;
    var password = _password.controller.text;
    var confirmPassword = _confirmPassword.controller.text;
    if (oldPassword == "") {
      return toastMessage("Current password is required");
    } else if (password == "" || password.length < 6) {
      return toastMessage("Password length must be more than 6");
    } else if (password != confirmPassword) {
      return toastMessage("Password doesn't match");
    }
    await _changePassword(oldPassword, password);
    _oldPassword.controller.text = "";
    _password.controller.text = "";
    _confirmPassword.controller.text = "";
    setState(() {});
  }

  Future _changePassword(String oldPassword, String password) async {
    AppDialogs.loading();

    Map<String, dynamic> body = {};
    body["current_password"] = oldPassword;
    body["password"] = password;
    body["password_confirmation"] = password;

    try {
      CommonResponse response = await _bloc.changePassword(json.encode(body));
      Get.back();
      toastMessage('${response.message!}');
      Get.offAll(() => ProfileScreenUser());
    } catch (e, s) {
      Completer().completeError(e, s);
      Get.back();
      toastMessage('Incorrect current password');
    }
  }

}
