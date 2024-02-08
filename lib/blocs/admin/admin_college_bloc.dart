import 'dart:async';
import 'package:faculty_app/interface/load_more_listener.dart';
import 'package:faculty_app/models/admin/colloge_list_response.dart';
import 'package:faculty_app/models/admin/committee_list_response.dart';
import 'package:faculty_app/models/common_response.dart';
import 'package:faculty_app/network/api_error_message.dart';
import 'package:faculty_app/network/apis_response.dart';
import 'package:faculty_app/repositories/admin/admin_repository.dart';
import 'package:faculty_app/utils/api_helper.dart';



class AdminCollegeBloc {
  AdminRepository? _repository;

  AdminCollegeBloc({this.listener}) {
    if (_repository == null)
      _repository = AdminRepository();
    _collegeListController =
    StreamController<ApiResponse<CollegeListResponse>>.broadcast();
  }

  bool hasNextPage = false;
  int pageNumber = 1;
  int perPage = 1;

  LoadMoreListener? listener;

  late StreamController<ApiResponse<CollegeListResponse>>
  _collegeListController;

  StreamSink<ApiResponse<CollegeListResponse>>?
  get collegeDetailsListSink => _collegeListController.sink;

  Stream<ApiResponse<CollegeListResponse>> get collegeDetailsListStream =>
      _collegeListController.stream;

  List<Colleges> collegeList = [];

  getCollegeList(bool isPagination, {int? perPage}) async {
    if (isPagination) {
      pageNumber = pageNumber + 1;
      listener!.refresh(true);
    } else {
      collegeDetailsListSink!.add(ApiResponse.loading('Fetching Data'));
      pageNumber = 1;
    }

    try {
      CollegeListResponse response = await _repository!.getcollegeList(perPage ?? 10, pageNumber);
      hasNextPage =
      response.pages!.lastPage! >= pageNumber.toInt() ? true : false;
        if (isPagination) {
          if (collegeList.length == 0) {
            collegeList = response.colleges!;
          } else {
            collegeList.addAll(response.colleges!);
          }
        } else {
          collegeList = response.colleges ?? [];
        }

        collegeDetailsListSink!.add(ApiResponse.completed(response));
        if (isPagination) {
          listener!.refresh(false);
        }
    } catch (error, s) {
      Completer().completeError(error, s);
      if (isPagination) {
        listener!.refresh(false);
      } else {
        collegeDetailsListSink!.add(ApiResponse.error(ApiErrorMessage.getNetworkError(error)));
      }
    } finally {
      // Cleanup or additional logic if needed
    }
  }

  Future<CommonResponse?> acceptOrRejectCollege(String status, String collegeId) async {
    try {
      CommonResponse response = await _repository!
          .acceptOrRejectCollege(status,collegeId);
      toastMessage(response.message);
      return response;
    } catch (e, s) {
      Completer().completeError(e, s);
    }
    return null;
  }

  Future<CommonResponse?> deleteCollege(String collegeId) async {
    try {
      CommonResponse response = await _repository!
          .deleteCollege(collegeId);
      toastMessage(response.message);
      return response;
    } catch (e, s) {
      Completer().completeError(e, s);
    }
    return null;
  }

  dispose() {
    collegeDetailsListSink?.close();
    _collegeListController?.close();
  }

}
