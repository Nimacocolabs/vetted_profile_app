import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:faculty_app/blocs/admin/admin_committee_bloc.dart';
import 'package:faculty_app/models/admin/member_list_response.dart';
import 'package:faculty_app/models/common_response.dart';
import 'package:faculty_app/ui/admin/admin_home_screen.dart';
import 'package:faculty_app/utils/api_helper.dart';
import 'package:faculty_app/utils/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:http/http.dart' as http;
import '../../utils/string_formatter_and_validator.dart';


class ComplaintScheduleScreen extends StatefulWidget {
  final String id;
   ComplaintScheduleScreen({Key? key, required this.id}) : super(key: key);
  @override
  _ComplaintScheduleScreenState createState() => _ComplaintScheduleScreenState();
}

class _ComplaintScheduleScreenState extends State<ComplaintScheduleScreen> {
  List<Jury> juryMembers = [];

  AdminCommitteBloc? _bloc;
  List<int> selectedOptionsIds = [];
  String? toDateInString;
  DateTime? toDate;
  bool? istoDateSelected;
  DateTime? _sheduleTime;
  String? toTimeInString;
  String? toTime;

  TextEditingController toDateController = TextEditingController();
  TextEditingController totimeController = TextEditingController();
  TextEditingController _meetLinkController=TextEditingController();
  FormatAndValidate formatAndValidate = FormatAndValidate();
  Map<String, String> headers = {
    'Authorization': 'Bearer ${UserDetails.apiToken}',
    'Accept': 'application/json', // Assuming JSON content type
  };
  void _fetchJuryMembers() async {

    final response = await http.get(Uri.parse('https://cocoalabs.in/VettedProfilesHub/public/api/admin/committee/list'),
        headers: headers
    );

    if (response.statusCode == 200) {

      final jsonResponse = json.decode(response.body);
      final List<dynamic> juryList = jsonResponse['jury'];

      setState(() {
        juryMembers = juryList.map((e) => Jury.fromJson(e)).toList();
      });
    } else {
      // If API call fails, handle the error
      throw Exception('Failed to load jury members');
    }
  }
  @override
  void initState() {
    _bloc = AdminCommitteBloc();
    super.initState();
    _fetchJuryMembers();
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
        title: const Text("Schedule Complaint", style: TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Date for schedule", style: TextStyle(fontWeight: FontWeight.w500),),
                SizedBox(height: 10,),
                TextFormField(
                  controller: toDateController,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor),
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor),
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor),
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                    hintText: 'Choose date',
                    suffixIcon: _calenderDatePick(),
                  ),
                ),
                SizedBox(height: 20,),
                Text("Time for schedule", style: TextStyle(fontWeight: FontWeight.w500),),
                SizedBox(height: 10,),
                TextFormField(
                  controller: totimeController,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor),
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor),
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor),
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                    hintText: 'Choose time',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.access_time,color: primaryColor,),
                      onPressed: () {
                        _showAddTimeAlert();
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Text("Choose committee members for schedule", style: TextStyle(fontWeight: FontWeight.w500),),
                SizedBox(height: 10,),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: primaryColor),
                  ),
                  child: MultiSelectDialogField<Jury>(
                    items: juryMembers
                        .map((member) => MultiSelectItem<Jury>(member, member.name.toString()))
                        .toList(),
                    initialValue: juryMembers,
                    selectedColor: primaryColor,
                    unselectedColor: primaryColor,
                    confirmText: Text(
                      'Submit',
                      style: TextStyle(color: primaryColor),
                    ),
                    cancelText: Text(
                      'Cancel',
                      style: TextStyle(color: primaryColor),
                    ),
                    title: Text('Select Committee\n members'),
                    buttonText: Text('Select Committee members'),
                    onConfirm: (values) {
                      setState(() {
                        selectedOptionsIds = values.map<int>((member) => member.id!).toList();
                        print("Options: $selectedOptionsIds");
                      });
                    },
                    chipDisplay: MultiSelectChipDisplay(
                      chipColor: primaryColor,
                      textStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Text("Google meet link for schedule", style: TextStyle(fontWeight: FontWeight.w500),),
                SizedBox(height: 10,),
                TextFormField(
                  controller: _meetLinkController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor),
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor),
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor),
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                    hintText: 'Paste Google meet link here',
                  ),

                ),
                SizedBox(height: 20,),
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

  _calenderDatePick() {
    return GestureDetector(
        child: new Icon(
          Icons.calendar_month_outlined,
          color: primaryColor,
        ),
        onTap: () async {
          final DateTime? datePick = await showDatePicker(
              context: context,
              initialDate: new DateTime.now(),
              firstDate: new DateTime(1900),
              lastDate: new DateTime(2030));
          if (datePick != null && datePick != toDate) {
            setState(() {
              toDate = datePick;
              istoDateSelected = true;

              // put it here
              toDateInString = toDate!.toString().split(' ').first;
              toDateController.text = toDateInString!;
            });
          }
        });
  }

  Future<void> _showAddTimeAlert() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          backgroundColor: Colors.white,
          contentPadding: EdgeInsets.all(0),
          insetPadding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 60.0,
          ),
          elevation: 0.0,
          title: Text('Select  Time for session'),
          content: StatefulBuilder(
            builder: (BuildContext context,
                void Function(void Function()) setState) {
              return Container(
                width: screenWidth,
                child: timePicker(),
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              child:  Text(
                'Select',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color:primaryColor,
                ),
              ),
              onPressed: () async {
                if (_sheduleTime == null) {
                  toastMessage("Add time");
                }
                Get.back();
              },
            )
          ],
        );
      },
    );
  }

  Widget timePicker() {
    return TimePickerSpinner(
      is24HourMode: false,
      minutesInterval: 5,
      normalTextStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      highlightedTextStyle: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.bold,
        color: primaryColor,
      ),
      spacing: 50,
      itemHeight: 80,
      alignment: Alignment.center,
      itemWidth: screenWidth / 6,
      isForce2Digits: true,
      onTimeChange: (time) {
        setState(() {
          _sheduleTime = time;
          toTimeInString = DateFormat('hh:mm aa').format(_sheduleTime!);
          toTime =DateFormat('HH:mm').format(_sheduleTime!);
          totimeController.text = toTimeInString!;
          print("hhjk${toTime}");
        });
      },
      // Customization
    );
  }

  _validate() async {
    var date  =toDateController.text;
    var time = totimeController.text;
    var link = _meetLinkController.text;


    if (formatAndValidate.validateDob(date) != null) {
      return toastMessage(formatAndValidate.validateDob(date));
    } else if (formatAndValidate.validateTime(time) != null) {
      return toastMessage(formatAndValidate.validateTime(time));
    } else if (selectedOptionsIds.isEmpty) {
      return toastMessage("Please select committee members");
    } else if (formatAndValidate.validateMeetLink(link) != null) {
      return toastMessage(formatAndValidate.validateMeetLink(link));
    }

    await _schedule(
      date,
      time,
      link,
    );

  }


  Future _schedule(
      String date,
      String time,
      String link,
      ) async {
    var formData = FormData();

    formData.fields..add(MapEntry("scheduled_date",date));
    formData.fields..add(MapEntry("scheduled_time",DateFormat('HH:mm').format(_sheduleTime!)));
    formData.fields..add(MapEntry("jury_ids", selectedOptionsIds.toString()));
    formData.fields..add(MapEntry("meeting_link", link));

    _bloc!.schedule(widget.id,formData).then((value) {
      Get.back();
      CommonResponse response = value;
      if (response.success!) {
        toastMessage("${response.message}");
        Get.to(AdminHomeScreen());
      } else {
        toastMessage("${response.message}");
      }
    }).catchError((err) {
      Get.back();
      toastMessage('${err}');
    });
  }

}



