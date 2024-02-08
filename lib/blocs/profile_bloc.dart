



import 'dart:async';

import 'package:dio/dio.dart';
import 'package:faculty_app/models/common_response.dart';
import 'package:faculty_app/models/profile_response.dart';
import 'package:faculty_app/network/api_error_message.dart';
import 'package:faculty_app/network/apis_response.dart';
import 'package:faculty_app/repositories/profile_repository.dart';

class ProfileBloc {
  late ProfileRepository _repository;

  late StreamController<ApiResponse<ProfileResponse>> _profileController;
  StreamSink<ApiResponse<ProfileResponse>>? get profileSink =>
      _profileController.sink;
  Stream<ApiResponse<ProfileResponse>> get profileStream =>
      _profileController.stream;

  late StreamController<ApiResponse<ProfileResponse>>
  _userRecordsController;
  StreamSink<ApiResponse<ProfileResponse>>? get userRecordSink =>
      _userRecordsController.sink;
  Stream<ApiResponse<ProfileResponse>> get userRecordStream =>
      _userRecordsController.stream;

  ProfileBloc() {
    _profileController = StreamController<ApiResponse<ProfileResponse>>();
    // _userRecordsController =
    //     StreamController<ApiResponse<ProfileResponse>>();

    _repository = ProfileRepository();
  }

  //
  // Future<CommonResponse> setUserProfilePic(File profilePic) async {
  //   try {
  //     CommonResponse response = await _repository.setUserProfilePic(profilePic);
  //     return response;
  //   } catch (e, s) {
  //     Completer().completeError(e, s);
  //     throw e;
  //   }
  // }

  // Future<CommonResponse> uploadUserRecords(
  //     String reportName, File reportFile) async {
  //   try {
  //     CommonResponse response =
  //     await _repository.uploadUserRecords(reportName, reportFile);
  //     return response;
  //   } catch (e, s) {
  //     Completer().completeError(e, s);
  //     throw e;
  //   }
  // }

  // Future<CommonResponse> setUserRecords(Map body) async {
  //   try {
  //     CommonResponse response = await _repository.setUserRecords(body);
  //     return response;
  //   } catch (e, s) {
  //     Completer().completeError(e, s);
  //     throw e;
  //   }
  // }

  getUserRecords() async {
    profileSink!.add(ApiResponse.loading('Fetching profile'));
    try {
      ProfileResponse profileResponse =
      await _repository.fetchUserRecords();
      if (profileResponse.success==true) {
        profileSink!.add(ApiResponse.completed(profileResponse));
      } else {
        profileSink!.add(ApiResponse.error(
            profileResponse.message ?? "Unable to process your request"));
      }
    } catch (error) {
      profileSink!
          .add(ApiResponse.error(ApiErrorMessage.getNetworkError(error)));
    }
  }
  Future<CommonResponse> updateProfile(FormData formData) async {
    try {
      CommonResponse response =
      await _repository.updateProfile(formData);
      return response;
    } catch (e, s) {
      Completer().completeError(e, s);
      throw e;
    }
  }


  Future<CommonResponse> changePassword(String body) async {
    try {
      CommonResponse response = await _repository.changePassword(body);
      return response;
    } catch (e, s) {
      Completer().completeError(e, s);
      throw e;
    }
  }

  dispose() {
    profileSink?.close();
    _profileController.close();
  }
}