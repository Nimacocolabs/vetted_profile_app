import 'dart:convert';

import 'package:faculty_app/repositories/auth_repository.dart';
import 'package:faculty_app/ui/admin/admin_schedules_screen.dart';
import 'package:faculty_app/ui/profile/profile_screen.dart';
import 'package:faculty_app/ui/college/college_add_complaints_screen.dart';
import 'package:faculty_app/ui/college/college_allcomplaints_screen.dart';
import 'package:faculty_app/ui/college/college_complaints_screen.dart';
import 'package:flutter/material.dart';
import 'package:faculty_app/utils/api_helper.dart';
import 'package:faculty_app/utils/user.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CollegeHomeScreen extends StatefulWidget {
  const CollegeHomeScreen({Key? key}) : super(key: key);

  @override
  State<CollegeHomeScreen> createState() => _CollegeHomeScreenState();
}

class _CollegeHomeScreenState extends State<CollegeHomeScreen> {
  @override

  AuthRepository LogOut = AuthRepository();
  int? total;
  int? _profilesClaimed;
  int? _profilesRegistered;
  int? _profilesResolved;

  @override
  void initState() {
    super.initState();
    _fetchDashboardDetails();
  }

  Future<void> _fetchDashboardDetails() async {
    try {
      final response = await http.get(
        Uri.parse('https://cocoalabs.in/VettedProfilesHub/public/api/dashboard-details'),
        headers: {
          'Authorization': 'Bearer ${UserDetails.apiToken}',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final details = jsonResponse['details'];
        setState(() {
          total=details['total_profiles'];
          _profilesClaimed = details['profiles']['claimed'];
          _profilesRegistered = details['profiles']['registered'];
          _profilesResolved = details['profiles']['resolved'];
        });
      } else {
        print('Failed to fetch dashboard details: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching dashboard details: $error');
    }
  }
  String _getGreeting() {
    var now = DateTime.now();
    var hour = now.hour;

    if (hour >= 0 && hour < 12) {
      return 'Good Morning';
    } else if (hour >= 12 && hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          color: primaryColor,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: primaryColor),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 38.0, right: 15, left: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(ProfileScreenUser());
                            },
                            child: Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              child: Icon(Icons.person_outline, size: 30, color: primaryColor),
                            ),
                          ),
                          SizedBox(width: 7),
                          GestureDetector(
                            onTap: () {
                              LogOut.getLogoutRepository();
                            },
                            child: Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              child: Icon(Icons.logout, size: 30, color: primaryColor),
                            ),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, right: 200, left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello  ${UserDetails.userName} !",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "${_getGreeting()}",
                            style: TextStyle(fontWeight: FontWeight.w300, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50))),
                height: MediaQuery.of(context).size.height * 0.75,
                width: MediaQuery.of(context).size.width * 1,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [primaryColor, secondaryColor], // Specify your gradient colors here
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Profiles",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    if (total !=null && _profilesClaimed != null && _profilesRegistered != null && _profilesResolved != null)
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Total : $total",style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white
                                          ),
                                          ),
                                          Text(
                                            "Claimed : $_profilesClaimed",style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white
                                          ),
                                          ),
                                          Text(
                                            "Registered : $_profilesRegistered",style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white
                                          ),
                                          ),
                                          Text(
                                            "Resolved : $_profilesResolved",style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white
                                          ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Row(
                        //   children: [
                        //     // Expanded(
                        //     //   child: Container(
                        //     //     child: AdminInfoCard(
                        //     //       title: "Colleges",
                        //     //       pending: UserDetails.userCollegePend,
                        //     //       approved: UserDetails.userCollegeAprov,
                        //     //     ),
                        //     //   ),
                        //     // ),
                        //     // Expanded(
                        //     //   child: Container(
                        //     //     child: AdminInfoCard(
                        //     //       title: "Profiles",
                        //     //       claimed: UserDetails.userProfileClaim,
                        //     //       registered: UserDetails.userProfileRegister,
                        //     //       resolved: UserDetails.userProfileResolve,
                        //     //     ),
                        //     //   ),
                        //     // ),
                        //   ],
                        // ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50), topRight: Radius.circular(50))),
                          height: MediaQuery.of(context).size.height * 0.5,
                          width: MediaQuery.of(context).size.width * 1,
                          child: GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            children: [
                              _buildFunctionalityCard(
                                title: 'Our Complaints',
                                icon: Icons.comment,
                                onPressed: () {
                                  Get.to(CollegeComplaintsScreen());
                                },
                              ),
                              _buildFunctionalityCard(
                                title: 'All Complaints',
                                icon: Icons.comment,
                                onPressed: () {
                                  Get.to(CollegeAllComplaintsScreen());
                                },
                              ),
                              _buildFunctionalityCard(
                                title: 'Add Complaints',
                                icon: Icons.add_card_outlined,
                                onPressed: () {
                                  Get.to(AddComplaintScreen());
                                },
                              ),
                              _buildFunctionalityCard(
                                title: 'Schedules',
                                icon: Icons.schedule,
                                onPressed: () {
                                  Get.to(AdminScheduleScreen());
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFunctionalityCard({
    required String title,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [primaryColor, secondaryColor],
            ),
            borderRadius: BorderRadius.circular(10), // Set your desired color
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 40,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 5),
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AdminInfoCard extends StatelessWidget {
  final String title;
  final String? pending;
  final String? approved;
  final String? claimed;
  final String? registered;
  final String? resolved;
  final String? committee;

  AdminInfoCard({
    required this.title,
    this.pending,
    this.approved,
    this.claimed,
    this.registered,
    this.resolved,
    this.committee,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              if (pending != null && approved != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pending : $pending",
                    ),
                    Text(
                      "Approved : $approved",
                    ),
                  ],
                ),
              if (claimed != null && registered != null && resolved != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Claimed : $claimed",
                    ),
                    Text(
                      "Registered : $registered",
                    ),
                    Text(
                      "Resolved : $resolved",
                    ),
                  ],
                ),
              if (committee != null)
                Text(
                  "Committee : $committee",
                ),
            ],
          ),
        ),
      ),
    );
  }
}
