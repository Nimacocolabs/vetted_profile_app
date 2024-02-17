import 'package:cached_network_image/cached_network_image.dart';
import 'package:faculty_app/blocs/committee/committe_bloc.dart';
import 'package:faculty_app/interface/load_more_listener.dart';
import 'package:faculty_app/models/admin/complaints_list_reponse.dart';
import 'package:faculty_app/network/apis_response.dart';
import 'package:faculty_app/ui/admin/view_complaint_screen.dart';
import 'package:faculty_app/utils/api_helper.dart';
import 'package:faculty_app/utils/custom_loader/linear_loader.dart';
import 'package:faculty_app/widgets/common_api_loader.dart';
import 'package:faculty_app/widgets/common_api_result_empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommitteComplaintsScreen extends StatefulWidget {
  const CommitteComplaintsScreen({Key? key}) : super(key: key);

  @override
  State<CommitteComplaintsScreen> createState() => _CommitteComplaintsScreenState();
}

class _CommitteComplaintsScreenState extends State<CommitteComplaintsScreen> with LoadMoreListener{
  late CommitteBloc _bloc;
  late ScrollController _itemsScrollController;
  bool isLoadingMore = false;
  List<Profiles> filteredComplaintsList = [];
  @override
  void initState() {
    _bloc = CommitteBloc(listener: this);
    _bloc!.getClaimedComplaintsList(false);
    _itemsScrollController = ScrollController();
    _itemsScrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  refresh(bool isLoading) {
    if (mounted) {
      setState(() {
        isLoadingMore = isLoading;
      });
    }
  }

  paginate() async {
    print('paginate');
    await _bloc.getClaimedComplaintsList(true);
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
              complaint.status!.toLowerCase().contains(query.toLowerCase()))
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
        title: const Text("Complaints", style: TextStyle(color: Colors.white)),
      ),
      body: RefreshIndicator(
        color: Colors.white,
        backgroundColor: primaryColor,
        onRefresh: () {
          return _bloc.getClaimedComplaintsList(false);
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
                          ComplaintsListResponse resp = snapshot.data!.data;
                          List<Profiles> complaintList = _bloc.complaintList;
                          return (complaintList.isEmpty) ||
                              (filteredComplaintsList.isEmpty && searchController.text.isNotEmpty)
                              ? CommonApiResultsEmptyWidget("No records found")
                              :_buildComplaintList(filteredComplaintsList.isNotEmpty
                              ? filteredComplaintsList
                              : _bloc.complaintList);
                        case Status.ERROR:
                          return SizedBox(
                            height: MediaQuery.of(context).size.height - 180,
                            child: CommonApiResultsEmptyWidget(
                                "",
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

  Widget _buildComplaintList(List<Profiles> complaintsList) {
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
                Get.to(ViewComplaintScreen(details:complaintsList[index]));
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
                  Text(
                    "${complaintsList[index].name}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: 7,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 150,
                    child: Text(
                      "${complaintsList[index].email} \n${complaintsList[index].phone}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        "Status : ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        "${complaintsList[index].status}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.purple,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
