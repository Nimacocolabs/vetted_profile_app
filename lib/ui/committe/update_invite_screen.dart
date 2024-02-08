import 'package:faculty_app/utils/api_helper.dart';
import 'package:faculty_app/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';


class UpdateInviteScreen extends StatefulWidget {
  @override
  _UpdateInviteScreenState createState() => _UpdateInviteScreenState();
}

class _UpdateInviteScreenState extends State<UpdateInviteScreen> {
  String? _meetLink ="https://meet.google.com/mnd-tpqm-gbb";
  TextFieldControl _detailed = TextFieldControl();
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
        title: const Text("Invite details", style: TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Date for schedule :", style: TextStyle(fontWeight: FontWeight.w500),),
              SizedBox(height: 10,),
              Text("Time for schedule :", style: TextStyle(fontWeight: FontWeight.w500),),
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
                          child: Text(
                            _meetLink ?? "Link not uploaded by admin yet",
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (() {
                          Clipboard.setData(
                              ClipboardData(text: _meetLink ?? ""));
                          toastMessage(
                              "Google meet link copied");
                        }),
                        child: Icon(Icons.copy),
                      )
                    ],
                  )),
              SizedBox(height: 20,),
              Text(
                "Detailed Explanation",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
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
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
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
    );
  }

}
