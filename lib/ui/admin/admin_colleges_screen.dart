import 'package:faculty_app/blocs/admin/admin_college_bloc.dart';
import 'package:faculty_app/models/admin/colloge_list_response.dart';
import 'package:faculty_app/network/apis_response.dart';
import 'package:faculty_app/utils/api_helper.dart';
import 'package:faculty_app/utils/custom_loader/linear_loader.dart';
import 'package:faculty_app/widgets/common_api_loader.dart';
import 'package:faculty_app/widgets/common_api_result_empty_widget.dart';
import 'package:flutter/material.dart';

import '../../interface/load_more_listener.dart';

class AdminCollegeScreen extends StatefulWidget {
  const AdminCollegeScreen({Key? key}) : super(key: key);

  @override
  State<AdminCollegeScreen> createState() => _AdminCollegeScreenState();
}

class _AdminCollegeScreenState extends State<AdminCollegeScreen>with LoadMoreListener  {

  late AdminCollegeBloc _bloc;
  late ScrollController _itemsScrollController;
  bool isLoadingMore = false;
  List<Colleges> filteredCollegesList = [];
  @override
  void initState() {
    _bloc = AdminCollegeBloc(listener: this);
    _bloc!.getCollegeList(false);
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
    await _bloc.getCollegeList(true);
  }

  void _scrollListener() async {
    if (_itemsScrollController.offset >=
        _itemsScrollController.position.maxScrollExtent &&
        !_itemsScrollController.position.outOfRange) {
      paginate();
      //}
    }
    if (_itemsScrollController.offset <=
        _itemsScrollController.position.minScrollExtent &&
        !_itemsScrollController.position.outOfRange) {
      print("reach the top");
    }
  }
  void filterCollegeList(String query) {
    setState(() {
      filteredCollegesList = _bloc.collegeList
          .where((college) =>
      college.userName!.toLowerCase().contains(query.toLowerCase()) ||
          college.collegeName!.toLowerCase().contains(query.toLowerCase()) ||
          college.collegeEmail!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
  @override
  void dispose() {
    _itemsScrollController.dispose();
    _bloc.dispose();
    super.dispose();
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
        title: const Text(
          "Colleges",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return _bloc.getCollegeList(false);
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          controller: _itemsScrollController,
          child: Column(
            children: [
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
                    filterCollegeList(value);
                  },
                ),
              ),
              StreamBuilder<ApiResponse<dynamic>>(
                  stream: _bloc.collegeDetailsListStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      switch (snapshot.data!.status!) {
                        case Status.LOADING:
                          return CommonApiLoader();
                        case Status.COMPLETED:
                          CollegeListResponse resp = snapshot.data!.data;
                          return _bloc.collegeList.isEmpty
                              ? SizedBox(
                            height: MediaQuery.of(context).size.height - 180,
                            child: CommonApiResultsEmptyWidget(
                                ""),
                          )
                              : _buildCollegeList(filteredCollegesList.isNotEmpty
                              ? filteredCollegesList
                              : _bloc.collegeList);
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

  Widget _buildCollegeList(List<Colleges> collegeList) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: collegeList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              tileColor: Colors.grey[200],
              contentPadding: EdgeInsets.all(10),
              onTap: () {},
              leading: Icon(Icons.school_outlined, color: primaryColor),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${collegeList[index].collegeName}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "${collegeList[index].collegeEmail}",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        "${collegeList[index].collegePhone}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      Spacer(),
                      if(collegeList[index].status =="approved")
                      Text(
                        "${collegeList[index].status!.toUpperCase()}",
                        style: TextStyle(
                          color: Colors.green, // Choose your color
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      if(collegeList[index].status =="rejected")
                        Text(
                          "${collegeList[index].status!.toUpperCase()}",
                          style: TextStyle(
                            color: Colors.red, // Choose your color
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      if(collegeList[index].status =="pending")
                        Text(
                          "${collegeList[index].status!.toUpperCase()}",
                          style: TextStyle(
                            color: Colors.blue, // Choose your color
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 6),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 150,
                    child: Text(
                      "${collegeList[index].address}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          await _bloc.acceptOrRejectCollege(
                              'approved',
                              collegeList[index].id.toString());
                          await Future.delayed(Duration(seconds: 2));
                          await _bloc.getCollegeList(false);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                        ),
                        child: Text("Approve"),
                      ),
                      SizedBox(width: 15),
                      ElevatedButton(
                        onPressed: () async {
                          await _bloc.acceptOrRejectCollege(
                              'rejected',
                              collegeList[index].id.toString());
                          await Future.delayed(Duration(seconds: 2));
                          await _bloc.getCollegeList(false);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                        ),
                        child: Text("Reject"),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () async {
                          await _bloc.deleteCollege(
                              collegeList[index].id.toString());
                          await Future.delayed(Duration(seconds: 2));
                          _bloc.getCollegeList(false);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                        ),
                        icon: Icon(Icons.delete_outline,color: Colors.red,),
                      ),
                      SizedBox(width: 20),
                      // Display status dynamically
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
