import 'package:cached_network_image/cached_network_image.dart';
import 'package:faculty_app/ui/committe/update_invite_screen.dart';
import 'package:faculty_app/utils/api_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CommitteeInvitesScreen extends StatefulWidget {
  const CommitteeInvitesScreen({Key? key}) : super(key: key);

  @override
  State<CommitteeInvitesScreen> createState() => _CommitteeInvitesScreenState();
}

class _CommitteeInvitesScreenState extends State<CommitteeInvitesScreen> {
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
        title: const Text("Invites", style: TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                    // filterComplaintList(value);
                  },
                ),
              ),
              _buildInvitesList()
            ],
          ),
        ),

      ),
    );
  }
  Widget _buildInvitesList() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 5, // Replace with the actual number of colleges
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              tileColor: Colors.grey[200],
              contentPadding: EdgeInsets.all(10),
              onTap: () {
                // Get.to(ViewComplaintScreen(details:complaintsList[index]));
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
                    '',
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
                  Text(
                    "Complaint : complaintsList[index].complaint",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: 4,),
                  Text(
                    "complaintsList[index].email",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4,),
                  Text(
                    "complaintsList[index].phone",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Get.to(UpdateInviteScreen());
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          side: BorderSide(color: primaryColor), // Change the color to the desired border color
                        ),
                        child: Text("View",style: TextStyle(color: primaryColor),),
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
