import 'dart:async';
import 'dart:convert';

import 'package:faculty_app/blocs/admin/admin_scheduled_bloc.dart';
import 'package:faculty_app/models/admin/deatils_reponse.dart';
import 'package:faculty_app/models/admin/scheduled_list_response.dart';
import 'package:faculty_app/models/common_response.dart';
import 'package:faculty_app/ui/committe/committe_home_screen.dart';
import 'package:faculty_app/ui/committe/update_invite_screen.dart';
import 'package:faculty_app/utils/user.dart';
import 'package:faculty_app/widgets/app_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:faculty_app/utils/api_helper.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class ViewScheduleScreen extends StatefulWidget {
  final Hearings details;

  const ViewScheduleScreen({Key? key, required this.details}) : super(key: key);

  @override
  _ViewScheduleScreenState createState() => _ViewScheduleScreenState();
}

class _ViewScheduleScreenState extends State<ViewScheduleScreen>
    with TickerProviderStateMixin {

  final AdminScheduleBloc _bloc = AdminScheduleBloc();
  late AnimationController _controller;
  List<Jurours> jurorsData = [];
  List<Verdicts> verdictData = [];
  late Future<void> _fetchJuryDetailsFuture;
  Verdict? verdict;
  String? judgement;
  Future<void> _fetchJuryDetails() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://cocoalabs.in/VettedProfilesHub/public/api/profiles/${widget.details.id}/show'),
        headers: {
          'Authorization': 'Bearer ${UserDetails.apiToken}',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final jurorsJson =
            jsonResponse['profile']['jurours']; // Remove type declaration here
        setState(() {
          jurorsData = jurorsJson != null
              ? jurorsJson.map<Jurours>((e) => Jurours.fromJson(e)).toList()
              : [];
        });
        final verdictJson = jsonResponse['profile']['verdict'];
        final verdictsJson = jsonResponse['profile']['verdicts'];
        print("ggu${verdictJson}");
        // if (verdictJson != null) {
        setState(() {
          // Check if verdictJson is not null before assigning it to verdict
          verdict = verdictJson != null ? Verdict.fromJson(verdictJson) : null;
          verdictData = verdictsJson != null
              ? verdictsJson.map<Verdicts>((e) => Verdicts.fromJson(e)).toList()
              : [];
          print("hbshxb${verdict}");
          print("bhbhj${verdictData}");
        });
      } else {
        print('Failed to fetch jury details: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching jury details: $error');
    }
  }

  String _formatDate(String? dateString) {
    if (dateString != null && dateString.isNotEmpty) {
      final dateTime = DateTime.parse(dateString);
      return DateFormat('dd-MM-yyyy').format(dateTime);
    } else {
      return '';
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _tabController = TabController(length: 4, vsync: this);
    _fetchJuryDetailsFuture = _fetchJuryDetails();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  TabController? _tabController;
  static const List<Tab> _tabs = [
    Tab(
      icon: Text("Job & Personal"),
    ),
    Tab(
      icon: Text("complaint "),
    ),
    Tab(
      icon: Text("Hearing "),
    ),
    Tab(
      icon: Text("Jurours"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    print("Status-->${widget.details.status}");
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
        title: const Text("", style: TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder<void>(
            future: _fetchJuryDetailsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      if (widget.details.image != null)
                        Container(
                          height: 300,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage('${widget.details.image}'),
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                      Row(
                        children: [
                          UserDetails.userRole == "committee" && verdict == null
                              ? Align(
                              alignment: AlignmentDirectional.bottomEnd,
                              child: ElevatedButton(
                                  onPressed: () {
                                    Get.to(UpdateInviteScreen(
                                        id: widget.details.id.toString(),
                                        date: widget.details.scheduledDate
                                            .toString(),
                                        time: widget.details.scheduledTime
                                            .toString(),
                                        link: widget.details.meetingLink
                                            .toString()));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: primaryColor,
                                  ),
                                  child: Text("Add Judgements")))
                              : SizedBox(),
                          SizedBox(width: 10,),
                          if (verdictData
                              .isNotEmpty) // Show verdictData only if it's not empty
                            Align(
                              alignment: AlignmentDirectional.bottomEnd,
                              child: ElevatedButton(
                                  onPressed: () {
                                    _showVerdictDataAlert(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: primaryColor,
                                  ),
                                  child: Text("View Judgements")),
                            ),
                          SizedBox(width: 10,),
                          if(UserDetails.userRole == "admin" && verdictData
                              .isNotEmpty &&  widget.details.status != "resolved" && widget.details.status != "rejected" )
                            Align(
                              alignment: AlignmentDirectional.bottomEnd,
                              child: ElevatedButton(
                                  onPressed: () {
                                    Get.to(UpdateInviteScreen(
                                        id: widget.details.id.toString(),
                                        date: widget.details.scheduledDate
                                            .toString(),
                                        time: widget.details.scheduledTime
                                            .toString(),
                                        link: widget.details.meetingLink
                                            .toString()));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: primaryColor,
                                  ),
                                  child: Text("Final Judgement")),
                            ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width,
                        child: TabBar(
                          controller: _tabController,
                          isScrollable: true, // Set isScrollable to true
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelColor: primaryColor,
                          indicatorColor: primaryColor,
                          tabs: _tabs,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 1,
                          width: MediaQuery.of(context).size.width - 2,
                          child: TabBarView(
                            controller: _tabController,
                            children: <Widget>[
                              _buildJobDetailsTab(),
                              _buildComplaintDetailsTab(),
                              _buildHearingsDetailsTab(),
                              _buildJuryDetailsTab()
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildJobDetailsTab() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle("Job Details"),
          DetailsTile("Job Title", widget.details.subject),
          DetailsTile("Department", widget.details.department),
          DetailsTile("Name", widget.details.collegeName),
          DetailsTile("Phone", widget.details.collegePhone),
          DetailsTile("Email", widget.details.collegeEmail),
          DetailsTile("Address", widget.details.collegeAddress),
          SectionTitle("Personal Details"),
          DetailsTile("Name", widget.details.name),
          DetailsTile("Email", widget.details.email),
          DetailsTile("Address", widget.details.address),
          DetailsTile("Phone", widget.details.phone),
          DetailsTile("Aadhar", widget.details.aadhar ?? "N/A"),
          DetailsTile("PAN", widget.details.pan ?? "N/A"),
        ],
      ),
    );
  }


  Widget _buildComplaintDetailsTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle("Complaint Details"),
          DetailsTile("Nature of Complaint", widget.details.complaint),
          DetailsTile("Details", widget.details.remarks),
          DetailsTile("Intensity ", widget.details.level),
          if(widget.details.claim != null)
            DetailsTile("Claim", widget.details.claim ?? ""),
        ],
      ),
    );
  }

  Widget _buildHearingsDetailsTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle("Hearings Details"),
          DetailsTile("Schedule Date", _formatDate(widget.details.scheduledDate)),
          DetailsTile("Schedule Time", widget.details.scheduledTime),
          DetailsTile("Schedule", widget.details.hearingStatus ?? ""),
          DetailsTile("Google meet", ""),
          TextButton(
              onPressed: () async {
                Uri url = Uri.parse(widget.details.meetingLink!);
                await _launchInBrowser(url);
              },
              child: Text(
                "${widget.details.meetingLink}",
                style: TextStyle(color: primaryColor),
              ))
        ],
      ),
    );
  }

  Widget _buildJuryDetailsTab() {
    return ListView.builder(
      itemCount: jurorsData.length,
      itemBuilder: (context, index) {
        var juror = jurorsData[index];
        return ListTile(
          title: Text(juror.name ?? 'No Name'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(juror.email ?? 'No Email'),
              juror.description!=null? Text(juror.description ?? ''):SizedBox()
            ],
          ),
        );
      },
    );
  }

  Widget SectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }

  Widget DetailsTile(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(label,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          SizedBox(
            width: 10,
          ),
          Text(":", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(
            width: 10,
          ),
          Flexible(
            // Wrap the Text widget with Flexible
            child: Text(
              value ?? 'N/A',
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
              overflow: TextOverflow.visible, // Allow overflow
            ),
          ),
        ],
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

  void _showVerdictDataAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Judgements"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: verdictData.map((verdict) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Juror name:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          verdict.jurorName ?? "N/A",
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Text(
                          "Status:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          verdict.status!.toUpperCase() ?? "N/A",
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Text(
                          "Judgements:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            verdict.verdict ?? "N/A",
                            style: TextStyle(fontSize: 14),
                            maxLines: 3, // Set maximum number of lines
                            overflow: TextOverflow.ellipsis, // Handle overflow
                          ),
                        ),
                      ],
                    ),
                    Divider(), // Add a divider between each verdict
                    SizedBox(height: 12),
                  ],
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Close',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

}
