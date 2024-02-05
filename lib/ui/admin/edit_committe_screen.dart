import 'dart:async';
import 'dart:convert';
import 'package:faculty_app/blocs/admin/admin_committee_bloc.dart';
import 'package:faculty_app/models/admin/committee_list_response.dart';
import 'package:faculty_app/models/common_response.dart';
import 'package:faculty_app/ui/admin/admin_committe_screen.dart';
import 'package:faculty_app/utils/api_helper.dart';
import 'package:faculty_app/utils/string_formatter_and_validator.dart';
import 'package:faculty_app/widgets/app_dialogs.dart';
import 'package:faculty_app/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class EditCommitteScreen extends StatefulWidget {
  final Committee details;
  const EditCommitteScreen({Key? key, required  this.details}) : super(key: key);

  @override
  State<EditCommitteScreen> createState() => _EditCommitteScreenState();
}

class _EditCommitteScreenState extends State<EditCommitteScreen> {
  AdminCommitteBloc? _bloc;

  TextFieldControl _name = TextFieldControl();
  TextFieldControl _email = TextFieldControl();
  TextFieldControl _phoneNumber = TextFieldControl();
  TextFieldControl _alterphoneNumber = TextFieldControl();


  FormatAndValidate formatAndValidate = FormatAndValidate();

  @override
  void initState() {
    _bloc = AdminCommitteBloc();
    _name.controller.text = widget.details.name!;
    _email.controller.text = widget.details.email!;
    _phoneNumber.controller.text = widget.details.phone!;
    _alterphoneNumber.controller.text = widget.details.phone2!;
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
        title: const Text("Edit committee",style: TextStyle(color: Colors.white),),
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
                SizedBox(height: 10,),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        print("bhjb");
                        _validate();
                      },
                      style: ElevatedButton.styleFrom(primary: primaryColor),
                      child: Text("Update"),
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

    if (formatAndValidate.validateName(name) != null) {
      return toastMessage(formatAndValidate.validateName(name));
    }   else if (formatAndValidate.validateEmailID(email) != null) {
      return toastMessage(formatAndValidate.validateEmailID(email));
    }else if (formatAndValidate.validatePhoneNo(phone) != null) {
      return toastMessage(formatAndValidate.validatePhoneNo(phone));
    }else if (formatAndValidate.validatePhoneNo(alterphone) != null) {
      return toastMessage(formatAndValidate.validatePhoneNo(alterphone));
    }
    return
      await _editCommittee(name,email,phone,alterphone);
  }

  Future _editCommittee(
      String name,
      String email,
      String phone,
      String alterphone,
      ) async {
    AppDialogs.loading();
    Map<String, dynamic> body = {};
    body["name"] = name;
    body["email"] = email;
    body["phone"] = phone;
    body["phone2"] = alterphone;
    try {
      CommonResponse response =
      await _bloc!.editCommittee(json.encode(body),widget.details.id.toString());
      Get.back();
      if (response.success!) {
        toastMessage("${response.message}");
        Get.to(AdminCommiteeScreen());
      } else {
        toastMessage('${response.message!}');
      }
    } catch (e, s) {
      Completer().completeError(e, s);
      Get.back();
      toastMessage('Something went wrong. Please try again');
    }
  }

}
