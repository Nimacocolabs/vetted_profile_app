import 'dart:io';

import 'package:dio/dio.dart';
import 'package:faculty_app/models/common_response.dart';
import 'package:faculty_app/models/profile_response.dart';
import 'package:faculty_app/network/api_provider.dart';
import 'package:faculty_app/network/apis.dart';
import 'package:faculty_app/ui/profile/profile_screen.dart';
import 'package:faculty_app/utils/api_helper.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';


class ProfileRepository {
  late ApiProvider apiClient;

  ProfileRepository() {
    apiClient = new ApiProvider();
  }


  // Future<CommonResponse> uploadUserRecords(
  //     String reportName, File reportFile) async {
  //   String fileName = reportFile.path.split('/').last;
  //   FormData formData = FormData.fromMap({
  //     "report_name": reportName,
  //     "report_file":
  //     await MultipartFile.fromFile(reportFile.path, filename: fileName),
  //   });
  //   final response = await apiProvider
  //       .getMultipartInstance()
  //       .post('${ApisUser.uploadUserTreatmentRecords}', data: formData);
  //   return CommonResponse.fromJson(response.data);
  // }

  Future<ProfileResponse> fetchUserRecords() async {
    final response = await apiClient.getJsonInstance().get(
        '${Apis.fetchProfileData}');
    return ProfileResponse.fromJson(response.data);
  }


  Future<CommonResponse> updateProfile(FormData formData) async {
    final response = await apiClient
        .getMultipartInstance()
        .post(Apis.editProfile, data: formData);
    return CommonResponse.fromJson(response.data);
  }


  Future<CommonResponse> changePassword(String body) async {
    final response = await apiClient
        .getJsonInstance()
        .post('${Apis.resetPassword}', data: body);
    return CommonResponse.fromJson(response.data);
  }
}
