import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:faculty_app/blocs/profile_bloc.dart';
import 'package:faculty_app/models/common_response.dart';
import 'package:faculty_app/ui/profile/profile_screen.dart';
import 'package:faculty_app/utils/api_helper.dart';
import 'package:faculty_app/widgets/app_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:image_picker/image_picker.dart';


var image ;
class EditProfile extends StatefulWidget {
  const EditProfile({Key? key, required this.UserName, required this.UserEmail, required this.UserPhone,required this.UserPhone2,required this.UserPic}) : super(key: key);
  final String UserName;
  final String UserEmail;
  final String UserPhone;
  final String UserPhone2;
  final String UserPic;
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController NameController = TextEditingController();
  TextEditingController BioController  = TextEditingController();
  TextEditingController Mobilenumbercontroller  = TextEditingController();
  TextEditingController Mobile2numbercontroller  = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  // ProfileRepository getedit = ProfileRepository();
   ProfileBloc _bloc =ProfileBloc();
  @override


  void initState() {
    super.initState();
    NameController.text = widget.UserName;
    Mobilenumbercontroller.text=widget.UserPhone;
    Mobile2numbercontroller.text=widget.UserPhone2;
    EmailController.text=widget.UserEmail;
    setState(() {});
  }
  File? image;
  late  File imageTemp;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

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
          "Edit Profile",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40,),
              Center(
                child: InkWell(
                  onTap:
                  pickImage,
                  child: Container(
                    height: 130,
                    width: 150,
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
                            child: image == null ?
                            CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: '${widget.UserPic}',
                              placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) => CircleAvatar(
                                radius: 46.0,
                                backgroundImage:
                                AssetImage('assets/images/dp.png'),
                                backgroundColor: Colors.grey,
                              ),
                            ):
                            Center(
                                child:  CircleAvatar(
                                  radius: 60.0,
                                  backgroundColor: Colors.white,
                                  backgroundImage: image == null ? null
                                      :FileImage(File(image!.path)),
                                  child: image==null ?
                                  Image.asset(
                                      'assets/images/profile.png') :
                                  Text("") ,
                                )
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 20,
                        child: InkWell(
                          onTap: () {
                            pickImage();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.black,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 20,top: 30),
                child: Text("Name",style: TextStyle(color: primaryColor,fontSize: 15,),),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 15,top: 5),
                child: TextFormField(
                  cursorHeight: 20,
                  controller: NameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: primaryColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: primaryColor),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,top: 30),
                child: Text("Email",style: TextStyle(color: primaryColor,fontSize: 15,),),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 15,top: 5),
                child: TextFormField(
                  cursorHeight: 20,
                  controller: EmailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: primaryColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: primaryColor),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,top: 30),
                child: Text("Contact Number",style: TextStyle(color: primaryColor,fontSize: 15,),),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 15,top: 5),
                child: TextFormField(
                  cursorHeight: 20,
                  controller: Mobilenumbercontroller,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: primaryColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: primaryColor),
                    ),
                  ),
                ),
              ),Padding(
                padding: const EdgeInsets.only(left: 20,top: 30),
                child: Text("Alternate Contatc Number ",style: TextStyle(color: primaryColor,fontSize: 15,),),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 15,top: 5),
                child: TextFormField(
                  cursorHeight: 20,
                  controller: Mobile2numbercontroller,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: primaryColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: primaryColor),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      _updateFunction();
                    },
                    style: ElevatedButton.styleFrom(primary: primaryColor),
                    child: Text("Update"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateFunction() async {
    AppDialogs.loading();
    var formData = FormData();
    if (image != null) {
      String fileName = imageTemp?.path?.split('/')?.last ?? "";
      MultipartFile imageFile = await MultipartFile.fromFile(imageTemp.path, filename: fileName);
      formData.files.add(MapEntry(
        "image",
          imageFile,
      ));
    }
    formData.fields..add(MapEntry("name", NameController.text.isEmpty? widget.UserName:NameController.text));
    formData.fields..add(MapEntry("email", EmailController.text.isEmpty?widget.UserEmail:EmailController.text));
    formData.fields..add(MapEntry("phone", Mobilenumbercontroller.text.isEmpty?widget.UserPhone:Mobilenumbercontroller.text));
    formData.fields..add(MapEntry("phone2", Mobile2numbercontroller.text.isEmpty?widget.UserPhone2:Mobile2numbercontroller.text));

    _bloc.updateProfile(formData).then((value) {
      Get.back();
      CommonResponse response = value;
      if (response.success!) {
        Fluttertoast.showToast(msg: "${response.message}");
        Get.offAll(() => ProfileScreenUser());
      } else {
        Fluttertoast.showToast(
            msg: "${response.message}");
      }
    }).catchError((err) {
      Get.back();
      toastMessage('${err}');
    });
  }

}
