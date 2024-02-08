import 'package:cached_network_image/cached_network_image.dart';
import 'package:faculty_app/blocs/profile_bloc.dart';
import 'package:faculty_app/models/profile_response.dart';
import 'package:faculty_app/network/apis_response.dart';
import 'package:faculty_app/ui/profile/edit_profile.dart';
import 'package:faculty_app/ui/profile/reset_password_screen.dart';
import 'package:faculty_app/utils/api_helper.dart';
import 'package:faculty_app/widgets/common_api_loader.dart';
import 'package:faculty_app/widgets/common_api_result_empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreenUser extends StatefulWidget {
  const ProfileScreenUser({Key? key}) : super(key: key);

  @override
  State<ProfileScreenUser> createState() => _ProfileScreenUserState();
}

class _ProfileScreenUserState extends State<ProfileScreenUser>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  late ProfileBloc _profileBloc;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _profileBloc = ProfileBloc();
    _profileBloc.getUserRecords();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: RefreshIndicator(
        color: Colors.white,
        backgroundColor: primaryColor,
        onRefresh: () {
          return _profileBloc.getUserRecords();
        },
        child: StreamBuilder<ApiResponse<dynamic>>(
            stream: _profileBloc.profileStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data!.status!) {
                  case Status.LOADING:
                    return CommonApiLoader();
                  case Status.COMPLETED:
                    ProfileResponse resp = snapshot.data!.data;
                    return Column(
                      children: [ SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                        InkWell(
                          onTap: (){
                            Get.to(ResetPasswordScreen());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.lock,color: primaryColor,),
                              Text("Reset Password"),
                              SizedBox(width: 10,),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        _buildUserProfile(resp)
                      ],
                    );
                  case Status.ERROR:
                    return CommonApiResultsEmptyWidget(
                        "${snapshot.data!.message!}",
                        textColorReceived: Colors.black);
                }
              }
              return Container(
                height: screenHeight - 180,
                child: Center(
                  child: CommonApiLoader(),
                ),
              );
            }),
      ),
    );
  }

  _buildUserProfile(ProfileResponse response) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width * 0.9,
      alignment: FractionalOffset.center,
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
          border: Border.all(
            color: primaryColor, // Set your desired border color
            width: 2.0, // Set your desired border width
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 4,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 130,
            width: screenWidth,
            child: Stack(children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: 120,
                  height: 120,
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(60),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: '${response.user!.imageUrl}',
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => GestureDetector(
                        onTap: () async {
                          await _showpicker();
                        },
                        child: CircleAvatar(
                          radius: 46.0,
                          backgroundImage: AssetImage('assets/images/dp.png'),
                          backgroundColor: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 35,
          ),
          Center(
            child: Text(
              response.user!.name!,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.email),
              SizedBox(
                width: 10,
              ),
              Center(
                child: Text(
                  response.user!.email!,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.phone),
              SizedBox(
                width: 10,
              ),
              Center(
                child: Text(
                  response.user!.phone!,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          // response.user!.phone != null
          //     ? Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Icon(Icons.phone),
          //           SizedBox(
          //             width: 10,
          //           ),
          //           Center(
          //             child: Text(
          //               response.user!.phone2!,
          //               style: TextStyle(
          //                 fontWeight: FontWeight.w500,
          //                 fontSize: 13,
          //               ),
          //             ),
          //           ),
          //         ],
          //       )
          //     : Text(""),
          Center(
              child: TextButton(
                  onPressed: () {
                    Get.to(EditProfile(UserName:response.user!.name!, UserEmail: response.user!.email!, UserPhone:response.user!.phone!,UserPhone2:response.user!.phone2!, UserPic: response.user!.imageUrl!,));
                  },
                  child: Text(
                    "Edit",
                    style: TextStyle(color: primaryColor, fontSize: 16),
                  )))
        ],
      ),
    );
  }

  _imagefromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
    // await _updateProfilePic(_image!);
  }

  _imagefromComera() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = photo;
    });
    // await _updateProfilePic(_image!);
  }

  // Future _updateProfilePic(XFile image) async {
  //   AppDialogs.loading();
  //
  //   try {
  //     CommonResponse response = await _profileBloc.setUserProfilePic(image as File);
  //     Get.back();
  //     Get.back();
  //
  //     if (response.success!) {
  //       toastMessage('${response.message!}');
  //       await _profileBloc.getUserProfile();
  //     } else {
  //       toastMessage('${response.message!}');
  //     }
  //   } catch (e, s) {
  //     Completer().completeError(e, s);
  //     Get.back();
  //     toastMessage('Something went wrong. Please try again');
  //   }
  // }

  _showpicker() {
    showModalBottomSheet(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        backgroundColor: Colors.white,
        context: context,
        builder: (context) {
          return Container(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      SizedBox(width: screenWidth * 0.1),
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: primaryColor,
                        child: IconButton(
                          onPressed: () {
                            _imagefromComera();
                          },
                          icon: Icon(Icons.camera_alt_rounded,
                              color: Colors.white),
                          iconSize: 30,
                        ),
                      ),
                      Text("Camera"),
                    ],
                  ),
                  SizedBox(width: screenWidth * 0.08),
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: primaryColor,
                        child: IconButton(
                          onPressed: () {
                            _imagefromGallery();
                          },
                          icon: Icon(Icons.photo),
                          color: Colors.white,
                          iconSize: 30,
                        ),
                      ),
                      Text("Gallery"),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
