import 'dart:async';
import 'package:dio/dio.dart';
import 'package:faculty_app/models/admin/add_committe_response.dart';
import 'package:faculty_app/models/admin/colloge_list_response.dart';
import 'package:faculty_app/models/admin/committee_list_response.dart';
import 'package:faculty_app/models/admin/complaints_list_reponse.dart';
import 'package:faculty_app/models/admin/schedule_details_response.dart';
import 'package:faculty_app/models/admin/scheduled_list_response.dart';
import 'package:faculty_app/models/common_response.dart';
import 'package:faculty_app/network/api_provider.dart';
import 'package:faculty_app/network/apis.dart';

String link="";
class AdminRepository {
  ApiProvider? apiClient;

  AdminRepository() {
    if (apiClient == null) apiClient = new ApiProvider();
  }

  Future<CommitteeAddResponse> addCommittee(FormData body) async {
    Response response = await apiClient!
        .getJsonInstance()
        .post(Apis.addCommittee, data: body);
    return CommitteeAddResponse.fromJson(response.data);
  }

  Future<CommonResponse> editCommittee(FormData formdata, id) async {
    Response response = await apiClient!
        .getJsonInstance()
        .post('${Apis.editCommittee}$id/update', data: formdata);
    return CommonResponse.fromJson(response.data);
  }

  Future<CommitteeListResponse> getAllCommitteList(int perPage,
      int page) async {
    final response = await apiClient!.getJsonInstance().get(
        '${Apis.fetchCommitteList}?page=$page&per_page=$perPage');
    return CommitteeListResponse.fromJson(response.data);
  }

  Future<CollegeListResponse> getcollegeList(int perPage, int page) async {
    final response = await apiClient!.getJsonInstance().get(
        '${Apis.fetchCollegeList}?page=$page&per_page=$perPage');
    return CollegeListResponse.fromJson(response.data);
  }

  Future<ComplaintsListResponse> getcomplaintList(int perPage, int page) async {
    final response = await apiClient!.getJsonInstance().get(
        '${Apis.fetchComplaintsList}?per_page=$perPage&page=${page.toInt()}');
    return ComplaintsListResponse.fromJson(response.data);
  }

  Future<ScheduledListResponse> getScheduledList(int perPage, int page) async {
    final response = await apiClient!.getJsonInstance().get(
        '${Apis.fetchSheduledList}?per_page=$perPage&page=${page.toInt()}');
    return ScheduledListResponse.fromJson(response.data);
  }

  Future<ScheduledDetailsResponse> fetchSchedulesDetails(String id) async {
    final response = await apiClient!.getJsonInstance().get(
        '${Apis.fetchSheduledData}$id/show');
    link = response.data['meeting_link'];
    print("Notificatio response--->${response.data}");
    print("Notificatio response--->${link}");
    return ScheduledDetailsResponse.fromJson(response.data);
  }


  Future<CommonResponse> acceptOrRejectCollege(String status,
      String collegeId) async {
    final response = await apiClient!
        .getJsonInstance()
        .patch('${Apis.rejectOrAccept}$collegeId/update-status', data: {
      "status": status,
    });
    return CommonResponse.fromJson(response.data);
  }

  Future<CommonResponse> deleteCollege(String collegeId) async {
    final response = await apiClient!
        .getJsonInstance()
        .delete('${Apis.deleteCollege}$collegeId/delete');
    return CommonResponse.fromJson(response.data);
  }


  Future<CommonResponse> deleteCommitee(String committeId) async {
    final response = await apiClient!
        .getJsonInstance()
        .delete('${Apis.deleteCommittee}$committeId/delete');
    return CommonResponse.fromJson(response.data);
  }

  Future<CommonResponse> deleteComplaint(String complaintId) async {
    final response = await apiClient!
        .getJsonInstance()
        .delete('${Apis.deleteComplaint}$complaintId/delete');
    return CommonResponse.fromJson(response.data);
  }

  Future<CommonResponse> deleteSchedule(String Id) async {
    final response = await apiClient!
        .getJsonInstance()
        .delete('${Apis.delectSchedule}$Id/delete');
    return CommonResponse.fromJson(response.data);
  }

  Future<CommonResponse> schedule(String id, Map<String, dynamic> body) async {
    print("=>${body}");
    Response response = await apiClient!
        .getJsonInstance()
        .post('${Apis.schedule}$id/store', data: body);
    return CommonResponse.fromJson(response.data);
  }


  Future<CommonResponse> addComments(String id,
      String body) async {
    Response response = await apiClient!
        .getJsonInstance()
        .post('${Apis.addComments}$id/store', data: body);
    return CommonResponse.fromJson(response.data);
  }
}
