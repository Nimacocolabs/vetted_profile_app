import 'dart:async';
import 'package:faculty_app/interface/load_more_listener.dart';
import 'package:faculty_app/models/admin/add_committe_response.dart';
import 'package:faculty_app/models/admin/committee_list_response.dart';
import 'package:faculty_app/models/common_response.dart';
import 'package:faculty_app/network/api_error_message.dart';
import 'package:faculty_app/network/apis_response.dart';
import 'package:faculty_app/repositories/admin/admin_repository.dart';
import 'package:faculty_app/utils/api_helper.dart';



class AdminCommitteBloc {
  AdminRepository? _repository;

  AdminCommitteBloc({this.listener}) {
    if (_repository == null)
      _repository = AdminRepository();
    _committeListController =
    StreamController<ApiResponse<CommitteeListResponse>>.broadcast();
  }

  bool hasNextPage = false;
  int pageNumber = 1;
  int perPage = 10;

  LoadMoreListener? listener;

  late StreamController<ApiResponse<CommitteeListResponse>>
  _committeListController;

  StreamSink<ApiResponse<CommitteeListResponse>>?
  get committeeDetailsListSink => _committeListController.sink;

  Stream<ApiResponse<CommitteeListResponse>> get committeeDetailsListStream =>
      _committeListController.stream;

  List<Committee> committeeList = [];

  getCommitteeList(bool isPagination, {int? perPage}) async {
    if (isPagination) {
      pageNumber = pageNumber + 1;
      listener!.refresh(true);
    } else {
      committeeDetailsListSink!.add(ApiResponse.loading('Fetching Data'));
      pageNumber = 1;
    }

    try {
      CommitteeListResponse response = await _repository!.getAllCommitteList(perPage ?? 10, pageNumber);

      if (response.pages != null && response.pages!.lastPage != null) {
        // Extract the page number from the last_page URL
        int lastPage = int.tryParse(Uri.parse(response.pages!.lastPage!).queryParameters['page'] ?? '') ?? 0;

        // Check if hasNextPage
        hasNextPage = lastPage >= pageNumber;

        if (isPagination) {
          if (committeeList.length == 0) {
            committeeList = response.committee!;
          } else {
            committeeList.addAll(response.committee!);
          }
        } else {
          committeeList = response.committee ?? [];
        }

        committeeDetailsListSink!.add(ApiResponse.completed(response));
        if (isPagination) {
          listener!.refresh(false);
        }
      } else {
        // Handle the case when pages or lastPage is null
        committeeDetailsListSink!.add(ApiResponse.error("Invalid response format"));
        if (isPagination) {
          listener!.refresh(false);
        }
      }
    } catch (error, s) {
      Completer().completeError(error, s);
      if (isPagination) {
        listener!.refresh(false);
      } else {
        committeeDetailsListSink!.add(ApiResponse.error(ApiErrorMessage.getNetworkError(error)));
      }
    } finally {
      // Cleanup or additional logic if needed
    }
  }



  Future<CommitteeAddResponse> addCommittee(String body) async {
    try {
      CommitteeAddResponse response = await _repository!.addCommittee(body);
      return response;
    } catch (e, s) {
      Completer().completeError(e, s);
      throw e;
    }
  }

  Future<CommonResponse?> deleteCommittee(String committeeId) async {
    try {
      CommonResponse response = await _repository!
          .deleteCommitee(committeeId);
      toastMessage(response.message);
      return response;
    } catch (e, s) {
      Completer().completeError(e, s);
    }
    return null;
  }

  Future<CommonResponse> editCommittee(String body,id) async {
    try {
      CommonResponse response = await _repository!.editCommittee(body,id);
      return response;
    } catch (e, s) {
      Completer().completeError(e, s);
      throw e;
    }
  }


}
