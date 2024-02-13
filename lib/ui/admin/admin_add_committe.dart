import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:faculty_app/blocs/admin/admin_committee_bloc.dart';
import 'package:faculty_app/blocs/auth_bloc.dart';
import 'package:faculty_app/models/admin/add_committe_response.dart';
import 'package:faculty_app/models/common_response.dart';
import 'package:faculty_app/ui/admin/admin_home_screen.dart';
import 'package:faculty_app/utils/api_helper.dart';
import 'package:faculty_app/utils/string_formatter_and_validator.dart';
import 'package:faculty_app/widgets/app_dialogs.dart';
import 'package:faculty_app/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:image_picker/image_picker.dart';


class AddCommitteScreen extends StatefulWidget {
  const AddCommitteScreen({Key? key}) : super(key: key);

  @override
  State<AddCommitteScreen> createState() => _AddCommitteScreenState();
}

class _AddCommitteScreenState extends State<AddCommitteScreen> {
  AdminCommitteBloc? _bloc;

  TextFieldControl _name = TextFieldControl();
  TextFieldControl _email = TextFieldControl();
  TextFieldControl _phoneNumber = TextFieldControl();
  TextFieldControl _alterphoneNumber = TextFieldControl();
  TextFieldControl _detailed = TextFieldControl();


  FormatAndValidate formatAndValidate = FormatAndValidate();
  File? _selectedImage;

  Future _pickImage() async {
    try {
      final image = await ImagePicker().getImage(source: ImageSource.gallery);
      if (image == null) return;
      _selectedImage = File(image.path);
      setState(() {});
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  void initState() {
    _bloc = AdminCommitteBloc();
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
        title: const Text("Add committee",style: TextStyle(color: Colors.white),),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8,),
                Text(
                  "Name",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                AppTextBox(
                    textFieldControl: _name,
                    hintText: 'Enter name',
                    keyboardType: TextInputType.name),
                Text(
                  "Email",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                AppTextBox(
                    textFieldControl: _email,
                    hintText: 'Enter email',
                    keyboardType: TextInputType.emailAddress ),
                Text(
                  "Contact Number",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                AppTextBox(
                    textFieldControl: _phoneNumber,
                    hintText: 'Enter phone number',
                    keyboardType: TextInputType.phone ),
                Text(
                  "Alertnate Contact Number",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                AppTextBox(
                    textFieldControl: _alterphoneNumber,
                    hintText: 'Enter phone number',
                    keyboardType: TextInputType.phone ),
                SizedBox(height: 4,),
                Text(
                  "Photo",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 4,),
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: _selectedImage != null
                        ? Image.file(_selectedImage!, fit: BoxFit.fill)
                        : Icon(Icons.camera_alt, size: 40, color: Colors.grey),
                  ),
                ),
                SizedBox(height: 4,),
                Text(
                  "Description",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: TextField(
                      scrollPhysics: BouncingScrollPhysics(),
                      controller: _detailed.controller,
                      focusNode: _detailed.focusNode,
                      minLines: 1,
                      maxLines: 100,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            borderSide: BorderSide(color: Colors.grey)),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            borderSide: BorderSide(color: Colors.black12)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            borderSide: BorderSide(color: Colors.grey)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            borderSide: BorderSide(color: primaryColor)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            borderSide: BorderSide(color: primaryColor)),
                        hintText: "Description",
                        hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                        contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                      ),
                    )),
                SizedBox(height: 10,),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                         _validate();
                      },
                      style: ElevatedButton.styleFrom(primary: primaryColor),
                      child: Text("Submit"),
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

    var name=_name.controller.text;
    var email=_email.controller.text;
    var phone=_phoneNumber.controller.text;
    var alterphone=_alterphoneNumber.controller.text;
    var image =_selectedImage;
    var description=_detailed.controller.text;
    if (formatAndValidate.validateName(name) != null) {
      return toastMessage(formatAndValidate.validateName(name));
    }   else if (formatAndValidate.validateEmailID(email) != null) {
      return toastMessage(formatAndValidate.validateEmailID(email));
    }else if (formatAndValidate.validatePhoneNo(phone) != null) {
      return toastMessage(formatAndValidate.validatePhoneNo(phone));
    }
    if (alterphone.isNotEmpty && formatAndValidate.validatePhoneNo(alterphone) != null) {
      return toastMessage(formatAndValidate.validatePhoneNo(alterphone));
    }
    if (description.isNotEmpty && formatAndValidate.validateAddress(description) != null) {
      return toastMessage("Please provide description");
    }

    return
      await _addCommitte(name,email,phone,alterphone,description,image);
  }

  Future _addCommitte(
      String name,
      String email,
      String phone,
      String alterphone,
      String description,
      File? image
      ) async {
    var formData = FormData();
    if (image != null) {
      String fileName = image?.path?.split('/')?.last ?? "";
      MultipartFile imageFile = await MultipartFile.fromFile(image.path, filename: fileName);
      formData.files.add(MapEntry(
        "image",
        imageFile,
      ));
    }
    formData.fields..add(MapEntry("name",name));
    formData.fields..add(MapEntry("email",email));
    formData.fields..add(MapEntry("phone", phone));
    if(alterphone.isNotEmpty) formData.fields..add(MapEntry("phone2", alterphone));
    if(description.isNotEmpty) formData.fields..add(MapEntry("description", description));

    _bloc!.addCommittee(formData).then((value) {
      Get.back();
      CommitteeAddResponse response = value;
      if (response.success!) {
    toastMessage("${response.message}");
    Get.to(AdminHomeScreen());
      } else {
    toastMessage("${response.message}");
      }
    }).catchError((err) {
      Get.back();
      toastMessage('Email already taken!');
    });
  }

}
