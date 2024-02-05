import 'package:flutter/material.dart';
import 'package:faculty_app/models/admin/complaints_list_reponse.dart';
import 'package:faculty_app/utils/api_helper.dart';

class ViewComplaintScreen extends StatefulWidget {
  final Profiles details;

  const ViewComplaintScreen({Key? key, required this.details}) : super(key: key);

  @override
  _ViewComplaintScreenState createState() => _ViewComplaintScreenState();
}

class _ViewComplaintScreenState extends State<ViewComplaintScreen> with TickerProviderStateMixin {
  TabController? _tabController;
  static const List<Tab> _tabs = [
    Tab(
      icon: Text("Job Details"),
    ),
    Tab(
      icon: Text("Personal Details"),
    ),
    Tab(
      icon: Text("Complaint Details"),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this); // 4 is the number of tabs
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
        title: const Text("View", style: TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
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
                SizedBox(height: 15,),
                Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.05,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: TabBar(
                    controller: _tabController,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: primaryColor,
                    indicatorColor:primaryColor,
                    tabs: _tabs,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height + 300,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width - 2,
                    child: TabBarView(
                      controller: _tabController,
                      children: <Widget>[
                        _buildJobDetailsTab(),
                        _buildPersonalDetailsTab(),
                        _buildComplaintDetailsTab(),
                      ],
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

  Widget _buildJobDetailsTab() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailsTile("Job Title", widget.details.subject),
          DetailsTile("Department", widget.details.department),
          DetailsTile("Name", widget.details.collegeName),
          DetailsTile("Phone", widget.details.collegePhone),
          DetailsTile("Email", widget.details.collegeEmail),
          DetailsTile("Address", widget.details.collegeAddress),
        ],
      ),
    );
  }

  Widget _buildPersonalDetailsTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          DetailsTile("Claim", widget.details.claim ?? ""),
        ],
      ),
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
          Text(label, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
          SizedBox(width: 10,),
          Text(":",style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 10,),
          Text(value ?? 'N/A',style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15))
        ],

      ),
    );
  }
}
