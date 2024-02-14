import 'dart:async';
import 'package:faculty_app/interface/load_more_listener.dart';
import 'package:faculty_app/models/admin/schedule_details_response.dart';
import 'package:faculty_app/models/common_response.dart';
import 'package:faculty_app/network/api_error_message.dart';
import 'package:faculty_app/network/apis_response.dart';
import 'package:faculty_app/repositories/admin/admin_repository.dart';
import 'package:faculty_app/utils/api_helper.dart';

import '../../models/admin/scheduled_list_response.dart';

class AdminScheduleBloc {
  AdminRepository? _repository;

  AdminScheduleBloc({this.listener}) {
    if (_repository == null)
      _repository = AdminRepository();
    _complaintsListController =
    StreamController<ApiResponse<ScheduledListResponse>>.broadcast();
    _complaintsdeatilsController =
    StreamController<ApiResponse<ScheduledDetailsResponse>>.broadcast();
  }

  bool hasNextPage = false;
  int pageNumber = 1;
  int perPage = 10;

  LoadMoreListener? listener;

  late StreamController<ApiResponse<ScheduledListResponse>>
  _complaintsListController;

  StreamSink<ApiResponse<ScheduledListResponse>>?
  get complaintDetailsListSink => _complaintsListController.sink;

  Stream<ApiResponse<ScheduledListResponse>> get complaintDetailsListStream =>
      _complaintsListController.stream;

  //
  late StreamController<ApiResponse<ScheduledDetailsResponse>>
  _complaintsdeatilsController;

  StreamSink<ApiResponse<ScheduledDetailsResponse>>?
  get complaintDetailsSink => _complaintsdeatilsController.sink;

  Stream<ApiResponse<ScheduledDetailsResponse>> get complaintDetailsStream =>
      _complaintsdeatilsController.stream;

  List<Hearings> complaintList = [];

  getSheduledsList(bool isPagination, {int? perPage}) async {

    print("pagination${isPagination}");
    if (isPagination) {
      pageNumber = pageNumber + 1;
      listener!.refresh(true);

    } else {
      complaintDetailsListSink!.add(ApiResponse.loading('Fetching Data'));
      pageNumber = 1;


    }
    try {
      ScheduledListResponse response =
      await _repository!.getScheduledList(10, pageNumber);
      hasNextPage =
      response.pages!.lastPage! >= pageNumber ? true : false;
      if (isPagination) {
        if (complaintList.length == 0) {
          complaintList = response.hearings!;
        } else {
          complaintList.addAll(response.hearings!);
        }
      } else {
        complaintList = response.hearings! ?? [];
      }
      complaintDetailsListSink!.add(ApiResponse.completed(response));
      if (isPagination) {
        listener!.refresh(false);
      }
    } catch (error, s) {
      Completer().completeError(error, s);
      if (isPagination) {
        listener!.refresh(false);
      } else {
        complaintDetailsListSink!
            .add(ApiResponse.error(ApiErrorMessage.getNetworkError(error)));
      }
    } finally {}
  }


  getSheduledDetails(String id) async {
    complaintDetailsListSink!.add(ApiResponse.loading('Fetching profile'));
    try {
      ScheduledDetailsResponse response =
      await _repository!.fetchSchedulesDetails(id);
      if (response.success==true) {
        complaintDetailsSink!.add(ApiResponse.completed(response));
      } else {
        complaintDetailsSink!.add(ApiResponse.error(
            response.message ?? "Unable to process your request"));
      }
    } catch (error) {
      complaintDetailsListSink!
          .add(ApiResponse.error(ApiErrorMessage.getNetworkError(error)));
    }
  }



  Future<CommonResponse?> deleteSchedule(String Id) async {
    try {
      CommonResponse response = await _repository!
          .deleteSchedule(Id);
      toastMessage(response.message);
      return response;
    } catch (e, s) {
      Completer().completeError(e, s);
    }
    return null;
  }

  Future<CommonResponse> addComments( String id,
      String body,
      ) async {
    try {
      CommonResponse response = await _repository!.addComments(id,body);
      return response;
    } catch (e, s) {
      Completer().completeError(e, s);
      throw e;
    }
  }



}