import 'dart:convert';
import 'package:faculty_app/models/signup_login_response.dart';
import 'package:faculty_app/ui/admin/admin_home_screen.dart';
import 'package:faculty_app/ui/college/college_home_screen.dart';
import 'package:faculty_app/ui/committe/committe_home_screen.dart';
import 'package:faculty_app/ui/login_signUp_Screen/login_screen.dart';
import 'package:faculty_app/utils/api_helper.dart';
import 'package:faculty_app/utils/shared_prefs.dart';
import 'package:faculty_app/utils/string_formatter_and_validator.dart';
import 'package:faculty_app/widgets/app_dialogs.dart';
import 'package:faculty_app/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OtpScreen extends StatefulWidget {
  final String deviceId;
  final String userId;
  final String msg;
  const OtpScreen({Key? key,required this.deviceId,required this.userId,required this.msg}) : super(key: key);
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  FormatAndValidate formatAndValidate = FormatAndValidate();
  TextFieldControl _otp = TextFieldControl();
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
          "OTP",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Padding(
                padding:  EdgeInsets.only(left: 8,right: 8),
                child: Text("${widget.msg}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(height: 30,),
              Text(
                "Enter OTP",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              AppTextBox(
                textFieldControl: _otp,
                prefixIcon: Icon(Icons.lock_outline,color: primaryColor,),
                hintText: 'OTP',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: SizedBox(
                  height: 45,
                  width: 100,
                  child: ElevatedButton(
                    style:
                    ElevatedButton.styleFrom(primary: primaryColor),
                    child: Text("Verify"),
                    onPressed: () => _validate(),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Text("Didn't receive otp ?"),
                 TextButton(onPressed: (){
                   _resendOtp();
                 }, child: Text('Resend OTP',style: TextStyle(color: primaryColor,decoration: TextDecoration.underline,),)),
               ],
             ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.001,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Back to login"),
                  TextButton(onPressed: (){
                    Get.to(LoginScreen());
                  }, child: Text('Login',style: TextStyle(color: primaryColor,decoration: TextDecoration.underline,),)),
                ],
              )
            ]),
      ),
    );
  }

  _validate() async {
    var otp = _otp.controller.text;

    if (formatAndValidate.validateOTP(otp) != null) {
      return toastMessage(formatAndValidate.validateOTP(otp));
    }
    return await _sendOtp(otp);
  }

  Future<void> _sendOtp(String otp) async {
    AppDialogs.loading();
    Map<String, dynamic> body = {};
    body["otp"] = otp;

    try {
      final response = await http.post(
        Uri.parse('https://facultycheck.com/backend/api/users/${widget.userId}/device/${widget.deviceId}/verify-otp'),
        body: body,
      );
      print("Response${response}");
      Get.back();
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print("Response${jsonResponse}");
        LoginSignupResponse loginResponse = LoginSignupResponse.fromJson(jsonResponse);
        if (loginResponse.success!) {
          await SharedPrefs.logIn(loginResponse);
         if ( loginResponse.user!.role == "admin") {
            Get.offAll(() => AdminHomeScreen());
          } else if (loginResponse.user!.role == "college") {
            Get.offAll(() => CollegeHomeScreen());
          } else {
            Get.offAll(() => CommitteHomeScreen());
          }
        } else {
          if (response.statusCode == 200) {
            toastMessage('You are not authorized!');
          } else {
            toastMessage(loginResponse.message ?? '');
          }
        }
      } else if (response.statusCode == 422) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse.containsKey('errors')) {
          final errors = jsonResponse['errors'];
          if (errors.containsKey('email')) {
            toastMessage(errors['email'][0]);
          }
        } else {
          toastMessage('Validation errors: ${jsonResponse['message']}');
        }
      } else {
        toastMessage('${json.decode(response.body)['message']}');
      }
    } catch (error) {
      Get.back();
      toastMessage('Failed to login: $error');
    }
  }

  Future<void> _resendOtp() async {
    AppDialogs.loading();
    try {
      final response = await http.get(
        Uri.parse('https://facultycheck.com/backend/api/users/${widget.userId}/device/${widget.deviceId}/resend-otp'),
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        toastMessage('OTP resent successfully');
      } else {
        toastMessage( '${json.decode(response.body)['message']}');
      }
    } catch (error) {
      toastMessage('Failed to resend OTP: $error');
    } finally {
      Navigator.of(context).pop();
    }
  }

}
