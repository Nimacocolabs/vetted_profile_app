import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:faculty_app/models/signup_login_response.dart';
import 'package:faculty_app/ui/admin/admin_home_screen.dart';
import 'package:faculty_app/ui/college/college_home_screen.dart';
import 'package:faculty_app/ui/committe/committe_home_screen.dart';
import 'package:faculty_app/ui/login_signUp_Screen/forgot_password_screen.dart';
import 'package:faculty_app/ui/login_signUp_Screen/otp_screen.dart';
import 'package:faculty_app/ui/login_signUp_Screen/signup_screen.dart';
import 'package:faculty_app/utils/api_helper.dart';
import 'package:faculty_app/utils/shared_prefs.dart';
import 'package:faculty_app/utils/string_formatter_and_validator.dart';
import 'package:faculty_app/widgets/app_dialogs.dart';
import 'package:faculty_app/widgets/app_text_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  FormatAndValidate formatAndValidate = FormatAndValidate();
  var _lkey = new GlobalKey<FormState>();
  TextFieldControl _email = TextFieldControl();
  TextFieldControl _password = TextFieldControl();
  String? _deviceId;
  //Get Device Information
  void _getDeviceId() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String? deviceId;

    if (kIsWeb) {
      final webBrowserInfo = await deviceInfo.webBrowserInfo;
      deviceId =
      '${webBrowserInfo.vendor ?? '-'} + ${webBrowserInfo.userAgent ?? '-'} + ${webBrowserInfo.hardwareConcurrency.toString()}';
    } else if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.id;
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor;
    } else if (Platform.isLinux) {
      final linuxInfo = await deviceInfo.linuxInfo;
      deviceId = linuxInfo.machineId;
    } else if (Platform.isWindows) {
      final windowsInfo = await deviceInfo.windowsInfo;
      deviceId = windowsInfo.deviceId;
    } else if (Platform.isMacOS) {
      final macOsInfo = await deviceInfo.macOsInfo;
      deviceId = macOsInfo.systemGUID;
    }
    setState(() {
      _deviceId = deviceId;
    });
  }
  void initState() {
    super.initState();
    _getDeviceId();
  }
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
                      .height * 0.07,
                ),
                Image.asset(
                  "assets/images/logo2-full-white.png",
                  height: 150,
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  child: Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.62,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.85,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                            child: Text(
                              "LOGIN",
                              style: GoogleFonts.aladin(fontSize: 30),
                            )),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                            child: Text(
                              "WELCOME ! Login with your Credentials",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w600),
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
                          child: Text("Email",
                            style: TextStyle(fontWeight: FontWeight.w500),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                            right: 20,
                            bottom: 10,
                          ),
                          child: AppTextBox(
                            textFieldControl: _email,
                            prefixIcon: Icon(
                              Icons.email_outlined, color: primaryColor,),
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
                          child: Text("Password",
                            style: TextStyle(fontWeight: FontWeight.w500),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                            right: 20,
                          ),
                          child: AppTextBox(
                            textFieldControl: _password,
                            prefixIcon: Icon(
                              Icons.lock_outlined, color: primaryColor,),
                            hintText: 'Password',
                            obscureText: true,
                            textInputAction: TextInputAction.done,
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional.bottomEnd,
                          child: TextButton(
                            onPressed: () {
                              Get.to(ForgotPasswordScreen());
                              _email.controller.clear();
                              _password.controller.clear();
                            },
                            child: Text(
                              'Forgot Password ?',
                              style: TextStyle(
                                  color: primaryColor, fontSize: 15),
                            ),
                          ),
                        ),
                        Center(
                          child: SizedBox(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.054,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.23,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Create your account ",
                              style: TextStyle(fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            SizedBox(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.004,
                            ),
                            TextButton(
                                child: Text(
                                  "Sign Up",
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 15, color: primaryColor,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                onPressed: () {
                                  Get.to(SignUpScreen());
                                  _email.controller.clear();
                                  _password.controller.clear();
                                }),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Video Help?",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.002,
                            ),
                            TextButton(
                                child: Text(
                                  "Malayalam",
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 15, color: primaryColor,
                                  ),
                                ),
                                onPressed: () {
                                  launchUrl(
                                      Uri.parse("https://youtu.be/5Sc2X0b0T6g"),
                                      mode: LaunchMode.externalApplication);
                                }),
                            Text(
                              "Or",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                                child: Text(
                                  "English",
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 15, color: primaryColor,
                                  ),
                                ),
                                onPressed: () {
                                  launchUrl(
                                      Uri.parse("https://youtu.be/RVFQ7SEwM8k"),
                                      mode: LaunchMode.externalApplication);
                                }),
                          ],
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

// Future _login(String email, String password) async {
//   AppDialogs.loading();
//   Map<String, dynamic> body = {};
//   body["email"] = email;
//   body["password"] = password;
//   try {
//     LoginSignupResponse response = await _authBloc.login(json.encode(body));
//     Get.back();
//     if (response.success!) {
//       await SharedPrefs.logIn(response);
//       if (response.user!.role == "admin") {
//         Get.offAll(() => AdminHomeScreen());
//       } else if (response.user!.role == "college") {
//         Get.offAll(() => CollegeHomeScreen());
//       } else {
//         Get.offAll(() => CommitteHomeScreen());
//       }
//     } else if (response.status == 422) {
//       if (response.errors != null) {
//         if (response.errors!.email != null &&
//             response.errors!.email!.isNotEmpty) {
//           toastMessage(response.errors!.email![0] ?? 'Unknown email error');
//         }
//       } else {
//         toastMessage(response.message ?? '');
//       }
//     } else {
//       toastMessage(response.message ?? '');
//     }
//   } catch (error) {
//     if (error is Errors) {
//       toastMessage(error.email);
//     } else {
//       Get.back();
//       toastMessage('Please enter valid credentials');
//     }
//   }
// }

  Future<void> _login(String email, String password) async {
    AppDialogs.loading();
    Map<String, dynamic> body = {};
    body["email"] = email;
    body["password"] = password;
    body["device_id"] = _deviceId;
    try {
      final response = await http.post(
        Uri.parse('https://facultycheck.com/backend/api/login'),
        body: body,
      );

      Get.back();
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        LoginSignupResponse loginResponse = LoginSignupResponse.fromJson(jsonResponse);
        if (loginResponse.success!) {
          await SharedPrefs.logIn(loginResponse);
          _email.controller.clear();
          _password.controller.clear();
          if (loginResponse.otpRequired == true) {
            toastMessage(loginResponse.message ?? '');
            Get.to(() => OtpScreen(msg:loginResponse.displayMessage.toString(),deviceId:loginResponse.deviceId.toString(),userId:loginResponse.userId.toString()));
          }
          else if (loginResponse.otpRequired == false && loginResponse.user!.role == "admin") {
            Get.offAll(() => AdminHomeScreen());
          } else if (loginResponse.otpRequired == false && loginResponse.user!.role == "college") {
            Get.offAll(() => CollegeHomeScreen());
          } else if (loginResponse.otpRequired == false && loginResponse.user!.role == "committee")  {
            Get.offAll(() => CommitteHomeScreen());
          } else
            {
              toastMessage('You are not authorized!');
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

}
