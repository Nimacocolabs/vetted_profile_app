import 'dart:async';
import 'dart:convert';

import 'package:faculty_app/blocs/auth_bloc.dart';
import 'package:faculty_app/models/common_response.dart';
import 'package:faculty_app/ui/login_signUp_Screen/login_screen.dart';
import 'package:faculty_app/utils/api_helper.dart';
import 'package:faculty_app/utils/string_formatter_and_validator.dart';
import 'package:faculty_app/widgets/app_dialogs.dart';
import 'package:faculty_app/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  AuthBloc? _authBloc;

  TextFieldControl _collegeName = TextFieldControl();
  TextFieldControl _collegeCode = TextFieldControl();
  TextFieldControl _collegeEmail = TextFieldControl();
  TextFieldControl _collegePhone = TextFieldControl();
  TextFieldControl _collegeAddress = TextFieldControl();
  TextFieldControl _collegeCity = TextFieldControl();
  TextFieldControl _AdminName = TextFieldControl();
  TextFieldControl _AdminEmail = TextFieldControl();
  TextFieldControl _AdminNumber = TextFieldControl();

  String? _selectedState;
  FormatAndValidate formatAndValidate = FormatAndValidate();

  List<String> _states = [
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal',
    'Andaman and Nicobar Islands',
    'Chandigarh',
    'Dadra and Nagar Haveli and Daman and Diu',
    'Lakshadweep',
    'Delhi',
    'Puducherry',
  ];

  @override
  void initState() {
    _authBloc = AuthBloc();
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
              colors: [secondaryColor,primaryColor],
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Colors.white),
        title: const Text("Sign Up",style: TextStyle(color: Colors.white),),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      'Create\nAccount',
                      style: TextStyle(
                        // color: blueGrey7xx,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 8,),
                  Text(
                    "College Name",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  AppTextBox(
                    textFieldControl: _collegeName,
                    hintText: 'Enter name',
                  ),
                  Text(
                    "College Code",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  AppTextBox(
                    textFieldControl: _collegeCode,
                    hintText: 'Enter college code',
                    keyboardType: TextInputType.name,
                  ),
                  Text(
                    "Email address",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  AppTextBox(
                    textFieldControl: _collegeEmail,
                    hintText: 'Enter mail address',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  Text(
                    "Phone number",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  AppTextBox(
                    textFieldControl: _collegePhone,
                    hintText: 'Enter Phone number',
                    keyboardType: TextInputType.phone,
                  ),
                  Text(
                    "College Address",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  AppTextBox(
                    textFieldControl: _collegeAddress,
                    hintText: 'Enter address',
                    keyboardType: TextInputType.streetAddress),
                  Text(
                    "College City",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  AppTextBox(
                      textFieldControl: _collegeCity,
                      hintText: 'Enter city',
                      keyboardType: TextInputType.name),
                  Text(
                    "State",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 5,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: DropdownButton<String>(
                      value: _selectedState,
                      items: _states.map((String state) {
                        return DropdownMenuItem<String>(
                          value: state,
                          child: Text(state),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedState = newValue;
                        });
                      },
                      isExpanded: true,
                      underline: Container(),
                      hint: Text('Select State'),
                    ),
                  ),
                  SizedBox(height: 8,),
                  Text(
                    "Administrator's name",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  AppTextBox(
                      textFieldControl: _AdminName,
                      hintText: 'Enter name',
                      keyboardType: TextInputType.name),
                  Text(
                    "Administrator's email",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  AppTextBox(
                      textFieldControl: _AdminEmail,
                      hintText: 'Enter email',
                      keyboardType: TextInputType.emailAddress ),
                  Text(
                    "Contact Number",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  AppTextBox(
                      textFieldControl: _AdminNumber,
                      hintText: 'Enter phone number',
                      keyboardType: TextInputType.phone ),
                  SizedBox(height: 10,),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          _validate();
                        },
                        style: ElevatedButton.styleFrom(primary: primaryColor),
                        child: Text("Sign Up"),
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

  _validate() async {

    var college_name = _collegeName.controller.text;
    var college_code = _collegeCode.controller.text;
    var college_email = _collegeEmail.controller.text;
    var college_phone = _collegePhone.controller.text;
    var college_address =_collegeAddress.controller.text;
    var college_city= _collegeCity.controller.text;
    var name=_AdminName.controller.text;
    var email=_AdminEmail.controller.text;
    var phone=_AdminNumber.controller.text;

    if (formatAndValidate.validateName(college_name) != null) {
      return toastMessage(formatAndValidate.validateName(college_name));
    }  else if (college_code == null) {
      return toastMessage("Enter valid code");
    } else if (formatAndValidate.validateEmailID(college_email) != null) {
      return toastMessage(formatAndValidate.validateEmailID(college_email));
    } else if (formatAndValidate.validatePhoneNo(college_phone) != null) {
      return toastMessage(formatAndValidate.validatePhoneNo(college_phone));
    } else if (formatAndValidate.validateAddress(college_address) != null) {
      return toastMessage(formatAndValidate.validateAddress(college_address));
    } else if (formatAndValidate.validateName(college_city) != null) {
      return toastMessage(formatAndValidate.validateName(college_city));
    }else if (_selectedState == null) {
      return toastMessage("Please select State");
    } else if (formatAndValidate.validateName(name) != null) {
      return toastMessage(formatAndValidate.validateName(name));
    }else if (formatAndValidate.validateEmailID(email) != null) {
      return toastMessage(formatAndValidate.validateEmailID(email));
    }else if (formatAndValidate.validatePhoneNo(phone) != null) {
      return toastMessage(formatAndValidate.validatePhoneNo(phone));
    }
    return
      await _signUp(college_name,college_code,college_email,college_phone,college_address,college_city,_selectedState!,name,email,phone);
  }

  Future _signUp(
      String college_name,
      String college_code,
      String college_email,
      String college_phone,
      String college_address,
      String college_city,
      String selectedState,
      String name,
      String email,
      String phone,
      ) async {
    AppDialogs.loading();

    Map<String, dynamic> body = {};
    body["name"] = name;
    body["email"] = email;
    body["phone"] = phone;
    body["college_name"] = college_name;
    body["code"] = college_code;
    body["college_email"] = college_email;
    body["college_phone"] = college_phone;
    body["address"] = college_address;
    body["city"] = college_city;
    body["state"] = selectedState;
    try {
      CommonResponse response =
      await _authBloc!.userRegistration(json.encode(body));
      Get.back();
      if (response.success!) {
        Get.to(LoginScreen());
        showAlert(context,"${response.message}");
      } else {
        toastMessage('${response.message!}');
      }
    } catch (e, s) {
      Completer().completeError(e, s);
      Get.back();
      toastMessage('Something went wrong. Please try again');
    }
  }

  void showAlert(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Success"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "College registered successfully",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 8),
              Text(
                "Please wait for a few hours for approval\nand check your email !",
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
              ),
            ],
          ),
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
                Navigator.of(context).pop();
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
