import 'package:cached_network_image/cached_network_image.dart';
import 'package:faculty_app/blocs/admin/admin_complaints_bloc.dart';
import 'package:faculty_app/blocs/admin/admin_scheduled_bloc.dart';
import 'package:faculty_app/interface/load_more_listener.dart';
import 'package:faculty_app/models/admin/complaints_list_reponse.dart';
import 'package:faculty_app/models/admin/scheduled_list_response.dart';
import 'package:faculty_app/network/apis_response.dart';
import 'package:faculty_app/ui/admin/view_shedules_screen.dart';
import 'package:faculty_app/utils/api_helper.dart';
import 'package:faculty_app/utils/custom_loader/linear_loader.dart';
import 'package:faculty_app/utils/user.dart';
import 'package:faculty_app/widgets/common_api_loader.dart';
import 'package:faculty_app/widgets/common_api_result_empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminScheduleScreen extends StatefulWidget {
  const AdminScheduleScreen({Key? key}) : super(key: key);

  @override
  State<AdminScheduleScreen> createState() => _AdminScheduleScreenState();
}

class _AdminScheduleScreenState extends State<AdminScheduleScreen> with LoadMoreListener {
  late AdminScheduleBloc _bloc;
  late ScrollController _itemsScrollController;
  bool isLoadingMore = false;
  List<Hearings> filteredComplaintsList = [];
  @override
  void initState() {
    _bloc = AdminScheduleBloc(listener: this);
    _bloc!.getSheduledsList(false);
    _itemsScrollController = ScrollController();
    _itemsScrollController.addListener(_scrollListener);
    super.initState();
  }
  refresh(bool isLoading) {
    if (mounted) {
      setState(() {
        isLoadingMore = isLoading;
      });
    }
  }

  paginate() async {
    print('paginate');
    await _bloc.getSheduledsList(true);
  }

  void _scrollListener() async {
    if (_itemsScrollController.offset >=
        _itemsScrollController.position.maxScrollExtent &&
        !_itemsScrollController.position.outOfRange) {
      print("reach the bottom");
      paginate();
      //}
    }
    if (_itemsScrollController.offset <=
        _itemsScrollController.position.minScrollExtent &&
        !_itemsScrollController.position.outOfRange) {
      print("reach the top");
    }
  }
  void filterComplaintList(String query) {
    setState(() {
      filteredComplaintsList = _bloc.complaintList
          .where((complaint) =>
      complaint.name!.toLowerCase().contains(query.toLowerCase()) ||
          complaint.email!.toLowerCase().contains(query.toLowerCase()) ||
          complaint.phone!.toLowerCase().contains(query.toLowerCase()) ||
          complaint.complaint!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  TextEditingController searchController = TextEditingController();
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
        title: const Text("Schedules", style: TextStyle(color: Colors.white)),
      ),
      body: RefreshIndicator(
        color: Colors.white,
        backgroundColor: primaryColor,
        onRefresh: () {
          return _bloc.getSheduledsList(false);
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          controller: _itemsScrollController,
          child: Column(
            children: [
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: Icon(Icons.search,color: primaryColor,),
                    contentPadding: EdgeInsets.symmetric(vertical: 3, horizontal: 4),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: primaryColor), // Set active border color
                    ),
                  ),
                  style: TextStyle( // Set style for entered text
                    color: primaryColor, // Change the text color
                    fontSize: 16.0, // Adjust the font size
                  ),
                  onChanged: (value) {
                    filterComplaintList(value);
                  },
                ),
              ),
              StreamBuilder<ApiResponse<dynamic>>(
                  stream: _bloc.complaintDetailsListStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      switch (snapshot.data!.status!) {
                        case Status.LOADING:
                          return CommonApiLoader();
                        case Status.COMPLETED:
                          ScheduledListResponse resp = snapshot.data!.data;

                          List<Hearings> complaintsList = _bloc.complaintList;
                          return (complaintsList.isEmpty) ||
                              (filteredComplaintsList.isEmpty && searchController.text.isNotEmpty)
                            ? CommonApiResultsEmptyWidget("No records found")
                              : _buildComplaintList(filteredComplaintsList.isNotEmpty
                              ? filteredComplaintsList
                              : _bloc.complaintList);
                        case Status.ERROR:
                          return SizedBox(
                            height: MediaQuery.of(context).size.height - 180,
                            child: CommonApiResultsEmptyWidget(
                                "${snapshot.data!.message!}",
                                textColorReceived: Colors.black),
                          );
                      }
                    }
                    return SizedBox(
                        height: MediaQuery.of(context).size.height - 180, child: CommonApiLoader());
                  }),
              if (isLoadingMore) LinearLoader(),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildComplaintList(List<Hearings> complaintsList) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: complaintsList.length, // Replace with the actual number of complaints
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              tileColor: Colors.grey[200],
              contentPadding: EdgeInsets.all(10),
              onTap: () {
                Get.to(ViewScheduleScreen(details:complaintsList[index]));
              },
              leading: Container(
                height: 60,
                width: 60,
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl:
                    '${complaintsList[index].image}',
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/dp.png'),
                        // height: 60,
                        // width: 60,
                      ),
                    ),
                  ),
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 7,),
                  // Text(
                  //   "College Name : ${complaintsList[index].collegeName}",
                  //   style: TextStyle(
                  //     fontWeight: FontWeight.bold,
                  //     fontSize: 14,
                  //     color: Colors.black,
                  //   ),
                  // ),
                  Text(
                    "${complaintsList[index].name}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4,),
                  Text(
                    "${complaintsList[index].email}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4,),
                  Text(
                    "${complaintsList[index].phone}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Complaint : ${complaintsList[index].complaint}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: primaryColor,
                    ),
                  ),
                  UserDetails.userRole == "admin"
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () async {
                          _showDeleteConfirmationDialog(context,complaintsList[index].id.toString());
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                        ),
                        child: Text("Delete"),
                      ),
                    ],
                  )
                      : SizedBox(),
                  // UserDetails.userRole == "committee"
                  //     ? Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     SizedBox(width: 10),
                  //     ElevatedButton(
                  //       onPressed: ()  {
                  //         Get.to(ViewScheduleScreen(details:complaintsList[index]));
                  //       },
                  //       style: ElevatedButton.styleFrom(
                  //         primary: primaryColor,
                  //       ),
                  //       child: Text("view"),
                  //     ),
                  //   ],
                  // )
                  //     : SizedBox(),

                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context,String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Confirmation'),
          content: Text('Are you sure you want to delete?'),
          actions: <Widget>[
            TextButton(
              onPressed: () async{
                await _bloc.deleteSchedule(id);
                await Future.delayed(Duration(seconds: 2));
                _bloc.getSheduledsList(false);
                Navigator.of(context).pop();
              },
              child: Text('Delete',style: TextStyle(color: Colors.red),),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel',style: TextStyle(color: primaryColor),),
            ),
          ],
        );
      },
    );
  }
}
