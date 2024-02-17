import 'dart:async';
import 'dart:convert';

import 'package:faculty_app/blocs/admin/admin_scheduled_bloc.dart';
import 'package:faculty_app/models/common_response.dart';
import 'package:faculty_app/ui/committe/committe_home_screen.dart';
import 'package:faculty_app/utils/api_helper.dart';
import 'package:faculty_app/utils/string_formatter_and_validator.dart';
import 'package:faculty_app/utils/user.dart';
import 'package:faculty_app/widgets/app_dialogs.dart';
import 'package:faculty_app/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';


class UpdateInviteScreen extends StatefulWidget {
  @override
  final String id;
  final String date;
  final String time;
  final String link;

  const UpdateInviteScreen({Key? key, required this.id,required this.date,required this.time,required this.link}) : super(key: key);
  _UpdateInviteScreenState createState() => _UpdateInviteScreenState();
}

class _UpdateInviteScreenState extends State<UpdateInviteScreen> {

  final AdminScheduleBloc _bloc = AdminScheduleBloc();
  String? intensity;
  String? judgement;
  TextFieldControl _detailed = TextFieldControl();

  FormatAndValidate formatAndValidate = FormatAndValidate();
  String _formatDate(String? dateString) {
    if (dateString != null && dateString.isNotEmpty) {
      final dateTime = DateTime.parse(dateString);
      return DateFormat('dd-MM-yyyy').format(dateTime);
    } else {
      return '';
    }
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
        title: const Text("Comments", style: TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Date for schedule : ${_formatDate(widget.date)}", style: TextStyle(fontWeight: FontWeight.w500),),
                SizedBox(height: 10,),
                Text("Time for schedule : ${widget.time}", style: TextStyle(fontWeight: FontWeight.w500),),
                SizedBox(height: 20,),
                Text("Google meet link for schedule", style: TextStyle(fontWeight: FontWeight.w500),),
                SizedBox(height: 10,),
                Container(
                    width: screenWidth,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: screenWidth - 80,
                            child: InkWell(
                              onTap: () async{
                                Uri url = Uri.parse(widget.link!);
                                await _launchInBrowser(url);
                              },
                              child: Text(
                                widget.link ?? "Link not uploaded by admin yet",
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (() {
                            Clipboard.setData(
                                ClipboardData(text: widget.link ?? ""));
                            toastMessage(
                                "Google meet link copied");
                          }),
                          child: Icon(Icons.copy),
                        )
                      ],
                    )),
                SizedBox(height: 25,),
            if(UserDetails.userRole =="committee")
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey), // Border color
                borderRadius: BorderRadius.circular(10), // Border radius
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Status",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                        value: 'approved',
                        groupValue: intensity,
                        onChanged: (value) {
                          setState(() {
                            intensity = value.toString();
                          });
                        },
                        activeColor: primaryColor,
                      ),
                      Text(
                        "Approve",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      Radio(
                        value: 'rejected',
                        groupValue: intensity,
                        onChanged: (value) {
                          setState(() {
                            intensity = value.toString();
                          });
                        },
                        activeColor: primaryColor,
                      ),
                      Text(
                        "Reject",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     Radio(
                  //       value: 'postponed',
                  //       groupValue: intensity,
                  //       onChanged: (value) {
                  //         setState(() {
                  //           intensity = value.toString();
                  //         });
                  //       },
                  //       activeColor: primaryColor,
                  //     ),
                  //     Text(
                  //       "Postponed",
                  //       style: TextStyle(
                  //         fontWeight: FontWeight.w500,
                  //         fontSize: 16,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Text(
                    "Judgements",
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
                          hintText: "Comments",
                          hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                          contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                        ),
                      )),
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
                if(UserDetails.userRole =="admin")
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey), // Border color
                      borderRadius: BorderRadius.circular(10), // Border radius
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Status",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio(
                              value: 'resolved',
                              groupValue: judgement,
                              onChanged: (value) {
                                setState(() {
                                  judgement = value.toString();
                                });
                              },
                              activeColor: primaryColor,
                            ),
                            Text(
                              "Approve",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              value: 'rejected',
                              groupValue: judgement,
                              onChanged: (value) {
                                setState(() {
                                  judgement = value.toString();
                                });
                              },
                              activeColor: primaryColor,
                            ),
                            Text(
                              "Reject",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height:35,
                            child: ElevatedButton(
                              onPressed: () {
                                _validate1();
                              },
                              style: ElevatedButton.styleFrom(primary: primaryColor),
                              child: Text("Submit"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }


  _validate() async {
    var details = _detailed.controller.text;


     if (intensity == null) {
      return toastMessage("Please select status");
    }

    if (details.isNotEmpty && formatAndValidate.validateAddress(details) != null) {
      return toastMessage("Please enter comments");
    }

    await _addComments(
      intensity!,
      details,

    );
  }
  Future _addComments(
      String intensity,
      String details,
      ) async {

    AppDialogs.loading();

    Map<String, dynamic> body = {};
    body["status"] = intensity;
    if (details.isNotEmpty) body["verdict"] = details;

    try {
      CommonResponse response =
      await _bloc!.addComments(widget.id,json.encode(body));
      Get.back();
      if (response.success!) {
        Get.to(CommitteHomeScreen());
        toastMessage('${response.message!}');
      } else {
        toastMessage('${response.message!}');
      }
    } catch (e, s) {
      Completer().completeError(e, s);
      toastMessage('Hearing not started yet!');
      Get.to(CommitteHomeScreen());
    }
  }


  _validate1() async {


    if (judgement == null) {
      return toastMessage("Please select status");
    }

    await _addComments1(
      judgement!,

    );
  }
  Future _addComments1(
      String judgement,
      ) async {

    AppDialogs.loading();

    Map<String, dynamic> body = {};
    body["status"] = judgement;

    try {
      CommonResponse response =
      await _bloc!.addfinalComments(widget.id.toString(),json.encode(body));
      Get.back();
      if (response.success!) {
        Get.to(CommitteHomeScreen());
        toastMessage('${response.message!}');
      } else {
        toastMessage('${response.message!}');
      }
    } catch (e, s) {
      Completer().completeError(e, s);
      toastMessage('Hearing not started yet!');
      Get.to(CommitteHomeScreen());
    }
  }

}
