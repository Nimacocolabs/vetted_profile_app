import 'dart:async';
import 'package:dio/dio.dart';
import 'package:faculty_app/models/common_response.dart';
import 'package:faculty_app/models/register_response.dart';
import 'package:faculty_app/models/signup_login_response.dart';
import 'package:faculty_app/network/api_provider.dart';
import 'package:faculty_app/network/apis.dart';
import 'package:faculty_app/utils/api_helper.dart';
import 'package:faculty_app/utils/shared_prefs.dart';
import 'package:faculty_app/utils/user.dart';


class AuthRepository {
  ApiProvider? apiClient;

  AuthRepository() {
    if (apiClient == null) apiClient = new ApiProvider();
  }
  Future<RegisterResponse> registerUser(String body) async {
    Response response = await apiClient!
        .getJsonInstance()
        .post(Apis.registerUser, data: body);
    return RegisterResponse.fromJson(response.data);
  }

  Future<LoginSignupResponse> login(String body) async {
    try {
      Response response = await apiClient!.getJsonInstance().post(Apis.loginUser, data: body);
      if (response.statusCode == 200) {
        return LoginSignupResponse.fromJson(response.data);
      } else {
        throw Errors.fromJson(response.data);
      }
    } catch (e, s) {
      Completer().completeError(e, s);
      throw e;
    }
  }

  getLogoutRepository() async {
    try {
      Response response =
      await apiClient!.getJsonInstance().get(Apis.logOutUser);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data!);
        toastMessage("${response.data['Message']}");
        SharedPrefs.logOut();
        return response.data;
      } else {
        toastMessage("${response.data['Message']}");
        print(
            "###########__________________LOGOUT UNSUCESSFULLY________________##############");
        throw "";
      }
    } catch (error) {
      print(error);
    }
  }

  Future<CommonResponse> forgotPassword(String body) async {
    final response = await apiClient!.getJsonInstance().post(
        '${Apis.forgotPassword}',
        data: body);
    return CommonResponse.fromJson(response.data);
  }

  Future<CommonResponse> addPayment(String id,
      String body) async {
    Response response = await apiClient!
        .getJsonInstance()
        .patch('${Apis.addPayment}$id/transaction-id', data: body);
    return CommonResponse.fromJson(response.data);
  }
}
