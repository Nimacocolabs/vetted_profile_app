import 'dart:io';
import 'package:dio/dio.dart';
import 'package:faculty_app/models/admin/complaints_list_reponse.dart';
import 'package:faculty_app/models/college/update_complaint_response.dart';
import 'package:faculty_app/models/common_response.dart';
import 'package:faculty_app/network/api_provider.dart';
import 'package:faculty_app/network/apis.dart';


class CommitteRepository {
  ApiProvider? apiClient;

  CommitteRepository() {
    if (apiClient == null) apiClient = new ApiProvider();
  }

  Future<ComplaintsListResponse> getCalimedComplaintList(
      int perPage, int page) async {
    final response = await apiClient!.getJsonInstance().get(
        '${Apis.fetchClaimedList}?page=$page&per_page=$perPage');
    return ComplaintsListResponse.fromJson(response.data);
  }



}