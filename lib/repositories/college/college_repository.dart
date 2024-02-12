import 'dart:io';
import 'package:dio/dio.dart';
import 'package:faculty_app/models/admin/complaints_list_reponse.dart';
import 'package:faculty_app/models/college/update_complaint_response.dart';
import 'package:faculty_app/models/common_response.dart';
import 'package:faculty_app/network/api_provider.dart';
import 'package:faculty_app/network/apis.dart';
import 'package:faculty_app/ui/college/college_home_screen.dart';
import 'package:faculty_app/utils/api_helper.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';

class CollegeRepository {
  ApiProvider? apiClient;

  CollegeRepository() {
    if (apiClient == null) apiClient = new ApiProvider();
  }

  Future<ComplaintsListResponse> getCollegeComplaintList(
      int perPage, int page,String global) async {
    final response = await apiClient!.getJsonInstance().get(
        '${Apis.fetchCollegeComplaints}?page=$page&per_page=$perPage&global=$global');
    return ComplaintsListResponse.fromJson(response.data);
  }

  Future<ComplaintsListResponse> getCollegeOtherComplaintList(
      int perPage, int page,String global) async {
    final response = await apiClient!.getJsonInstance().get(
        '${Apis.fetchCollegeComplaints}?page=$page&per_page=$perPage&global=$global');
    return ComplaintsListResponse.fromJson(response.data);
  }

  Future<CommonResponse> addComplaint(
      FormData formData
      ) async {
    final  Response response = await apiClient!
        .getJsonInstance()
        .post(Apis.addComplaint, data: formData);
    return CommonResponse.fromJson(response.data);
  }

  Future<CommonResponse> deleteComplaint(
      String complaintId) async {
    final response = await apiClient!
        .getJsonInstance()
        .delete('${Apis.deleteComplaintCollege}$complaintId/delete');
    return CommonResponse.fromJson(response.data);
  }

  Future<ComplaintUpdateResponse> editComplaint(
      String id,
      FormData body
      ) async {

    final response = await apiClient!
        .getJsonInstance()
   . post('${Apis.editComplaint}$id/update', data: body);
    return ComplaintUpdateResponse.fromJson(response.data);
    }
  }

