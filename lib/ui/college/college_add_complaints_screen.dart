import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:faculty_app/blocs/college/college_complaint_bloc.dart';
import 'package:faculty_app/models/common_response.dart';
import 'package:faculty_app/ui/college/college_home_screen.dart';
import 'package:faculty_app/utils/api_helper.dart';
import 'package:faculty_app/utils/string_formatter_and_validator.dart';
import 'package:faculty_app/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:image_picker/image_picker.dart';



class AddComplaintScreen extends StatefulWidget {
  const AddComplaintScreen({Key? key}) : super(key: key);

  @override
  State<AddComplaintScreen> createState() => _AddComplaintScreenState();
}

class _AddComplaintScreenState extends State<AddComplaintScreen> {
  final CollegeComplaintBloc _bloc = CollegeComplaintBloc();
  //
  // CollegeComplaintBloc? _bloc;

  TextFieldControl _name = TextFieldControl();
  TextFieldControl _email = TextFieldControl();
  TextFieldControl _phone = TextFieldControl();
  TextFieldControl _address = TextFieldControl();
  TextFieldControl _pancardnumber = TextFieldControl();
  TextFieldControl _adharcardnumber = TextFieldControl();
  TextFieldControl _jobTitle = TextFieldControl();
  TextFieldControl _department = TextFieldControl();
  TextFieldControl _nature = TextFieldControl();
  TextFieldControl _detailed = TextFieldControl();
  String? intensity;

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



  FormatAndValidate formatAndValidate = FormatAndValidate();


  @override
  void initState() {
    // _bloc = CollegeComplaintBloc();
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
        title: const Text("Add Complaint",style: TextStyle(color: Colors.white),),
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
                ),
                Text(
                  "Email address",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                AppTextBox(
                  textFieldControl: _email,
                  hintText: 'Enter mail address',
                  keyboardType: TextInputType.emailAddress,
                ),
                Text(
                  "Address",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                AppTextBox(
                    textFieldControl: _address,
                    hintText: 'Enter address',
                    keyboardType: TextInputType.streetAddress),
                Text(
                  "Phone number",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                AppTextBox(
                  textFieldControl: _phone,
                  hintText: 'Enter Phone number',
                  keyboardType: TextInputType.phone,
                ),
                Text(
                  "PAN Card number",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                AppTextBox(
                    textFieldControl: _pancardnumber,
                    hintText: 'Enter pan card number',
                    keyboardType: TextInputType.text),
                Text(
                  "Aadhar card number",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                AppTextBox(
                    textFieldControl: _adharcardnumber,
                    hintText: 'Enter Aadhaar card number',
                    keyboardType: TextInputType.number),
                Text(
                  "Job Position",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                AppTextBox(
                    textFieldControl: _jobTitle,
                    hintText: 'Enter job position ',
                    keyboardType: TextInputType.text),
                Text(
                  "Department",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                AppTextBox(
                    textFieldControl: _department,
                    hintText: 'Enter department',
                    keyboardType: TextInputType.text ),
                Text(
                  "Intensity of Complaint",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Radio(
                      value: 'low',
                      groupValue: intensity,
                      onChanged: (value) {
                        setState(() {
                          intensity = value.toString();
                        });
                      },
                      activeColor: primaryColor,
                    ),
                    Text(
                      "Low",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    Radio(
                      value: 'medium',
                      groupValue: intensity,
                      onChanged: (value) {
                        setState(() {
                          intensity = value.toString();
                        });
                      },
                      activeColor: primaryColor,
                    ),
                    Text(
                      "Medium",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    Radio(
                      value: 'high',
                      groupValue: intensity,
                      onChanged: (value) {
                        setState(() {
                          intensity = value.toString();
                        });
                      },
                      activeColor: primaryColor,
                    ),
                    Text(
                      "High",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
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
                SizedBox(height: 6,),
                Text(
                  "Nature of the Complaint",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                AppTextBox(
                    textFieldControl: _nature,
                    hintText: 'Enter nature of the complaint',
                    keyboardType: TextInputType.text ),
                Text(
                  "Detailed Explanation",
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
                        hintText: "Explanation",
                        hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                        contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                      ),
                    )),
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
    var name = _name.controller.text;
    var email = _email.controller.text;
    var phone = _phone.controller.text;
    var address = _address.controller.text;
    var department = _department.controller.text;
    var subject = _jobTitle.controller.text;
    var complaint = _nature.controller.text;
    var adharNo = _adharcardnumber.controller.text;
    var details = _detailed.controller.text;

    if (formatAndValidate.validateName(name) != null) {
      return toastMessage(formatAndValidate.validateName(name));
    } else if (formatAndValidate.validateEmailID(email) != null) {
      return toastMessage(formatAndValidate.validateEmailID(email));
    } else if (formatAndValidate.validatePhoneNo(phone) != null) {
      return toastMessage(formatAndValidate.validatePhoneNo(phone));
    } else if (formatAndValidate.validateAddress(address) != null) {
      return toastMessage(formatAndValidate.validateAddress(address));
    } else if (intensity == null) {
      return toastMessage("Please select intensity");
    } else if (formatAndValidate.validateName(subject) != null) {
      return toastMessage("Please enter job title");
    } else if (formatAndValidate.validateName(department) != null) {
      return toastMessage("Please enter department");
    } else if (formatAndValidate.validateAddress(complaint) != null) {
      return toastMessage("Please enter nature of complaint");
    }
    if (adharNo.isNotEmpty && formatAndValidate.validateAadhaar(adharNo) != null) {
      return toastMessage(formatAndValidate.validateAadhaar(adharNo));
    }
    var pancardnumber = _pancardnumber.controller.text;
    if (pancardnumber.isNotEmpty && formatAndValidate.validatePANCard(pancardnumber) != null) {
      return toastMessage(formatAndValidate.validatePANCard(pancardnumber));
    }
    if (details.isNotEmpty && formatAndValidate.validateAddress(details) != null) {
      return toastMessage("Please enter valid remarks");
    }

    await _addComplaint(
      name,
      email,
      phone,
      address,
      department,
      subject,
      complaint,
      intensity!,
      adharNo,
      details,
      pancardnumber,
    );
  }
  Future _addComplaint(
      String name,
      String email,
      String phone,
      String address,
      String department,
      String subject,
      String complaint,
      String intensity,
      String adharNo,
      String details,
      String pancardnumber,
      ) async {
    var formData = FormData();
    if (_selectedImage != null) {
      String fileName = _selectedImage?.path
          ?.split('/')
          ?.last ?? "";
      MultipartFile imageFile = await MultipartFile.fromFile(
          _selectedImage!.path, filename: fileName);
      formData.files.add(MapEntry(
        "image",
        imageFile,
      ));
    }
    formData.fields..add(MapEntry("name", name));
    formData.fields..add(MapEntry("email", email));
    formData.fields..add(MapEntry("phone", phone));
    formData.fields..add(MapEntry("address", address));
    formData.fields..add(MapEntry("department", department));
    formData.fields..add(MapEntry("subject", subject));
    formData.fields..add(MapEntry("complaint",complaint));
    formData.fields..add(MapEntry("level", intensity));
    if (adharNo.isNotEmpty)
      formData.fields..add(MapEntry("aadhar", adharNo));
    if (details.isNotEmpty) formData.fields..add(MapEntry("remarks", details));
    if (pancardnumber.isNotEmpty) formData.fields
      ..add(MapEntry("pan", pancardnumber));

    _bloc!.addComplaint(formData).then((value) {
      Get.back();
      CommonResponse response = value;
      if (response.success!) {
        toastMessage("${response.message}");
        Get.to(() => CollegeHomeScreen());
      } else {
        toastMessage("${response.message}");
      }
    }).catchError((err) {
      Get.back();
      toastMessage('${err}');
    });
  }

}
