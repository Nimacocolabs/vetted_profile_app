import 'dart:async';
import 'dart:convert';

import 'package:faculty_app/blocs/auth_bloc.dart';
import 'package:faculty_app/models/common_response.dart';
import 'package:faculty_app/ui/login_signUp_Screen/login_screen.dart';
import 'package:faculty_app/utils/api_helper.dart';
import 'package:faculty_app/utils/string_formatter_and_validator.dart';
import 'package:faculty_app/widgets/app_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class PaymentScreen extends StatefulWidget {
  final String imageUrl;
  final String id;
  const PaymentScreen({Key? key,required this.imageUrl,required this.id}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen>  {
  AuthBloc? _authBloc;
  TextEditingController transactionIdController = TextEditingController();
  FormatAndValidate formatAndValidate = FormatAndValidate();
  @override
  void initState() {
    _authBloc = AuthBloc();
    super.initState();
  }
  @override
  void dispose() {
    transactionIdController.dispose();
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
        title: const Text("", style: TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10),
                if (widget.imageUrl != null)
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('${widget.imageUrl}'),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                SizedBox(height: 15,),
                Text("After Payment enter transaction id"),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: TextField(
                        scrollPhysics: BouncingScrollPhysics(),
                        controller: transactionIdController,
                        minLines: 1,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(7)),
                              borderSide: BorderSide(color: Colors.grey)),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(7)),
                              borderSide: BorderSide(color: Colors.black12)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(7)),
                              borderSide: BorderSide(color: Colors.grey)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(7)),
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(7)),
                              borderSide: BorderSide(color: primaryColor)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(7)),
                              borderSide: BorderSide(color: primaryColor)),
                          hintText: "Enter Transaction Id",
                          hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                          contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                        ),
                      )),
                ),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height:35,
                    child: ElevatedButton(
                      onPressed: () {
                         _validate();
                      },
                      style: ElevatedButton.styleFrom(primary: primaryColor),
                      child: Text("Submit"),
                    ),
                  ),
                ),
               SizedBox(height: MediaQuery.of(context).size.height *0.17,),
                Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height:35,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(LoginScreen());
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.white),
                      child: Text("skip",style: TextStyle(color: primaryColor),),
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

  _validate() async {

    var transaction_id = transactionIdController.text;

    if (formatAndValidate.validateTransactionId(transaction_id) != null) {
      return toastMessage(formatAndValidate.validateTransactionId(transaction_id));
    }
    return
      await _payment(transaction_id);
  }

  Future _payment(
      String transaction_id,
      ) async {

    AppDialogs.loading();

    Map<String, dynamic> body = {};
    body["transaction_id"] = transaction_id;

    try {
      CommonResponse response =
      await _authBloc!.addPayment(widget.id.toString(),json.encode(body));
      Get.back();
      if (response.success!) {
        Get.to(LoginScreen());
        showAlert(context);
      } else {
        toastMessage('${response.message!}');
      }
    } catch (e, s) {
      Completer().completeError(e, s);
      toastMessage('Transaction Id not correct!');
      Get.to(LoginScreen());
    }
  }

  void showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Success"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "College registered successfully",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 8),
              Text(
                "Please wait for a few hours for approval\nand check your email !",
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: primaryColor, // Background color
                onPrimary: Colors.white, // Text color
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // Button border radius
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }



}
