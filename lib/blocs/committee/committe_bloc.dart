

import 'dart:async';

import 'package:faculty_app/interface/load_more_listener.dart';
import 'package:faculty_app/models/admin/complaints_list_reponse.dart';
import 'package:faculty_app/network/api_error_message.dart';
import 'package:faculty_app/network/apis_response.dart';
import 'package:faculty_app/repositories/committee/committte_repository.dart';

class CommitteBloc {
  CommitteRepository? _repository;

  CommitteBloc({this.listener}) {
    if (_repository == null)
      _repository = CommitteRepository();
    _complaintsListController =
    StreamController<ApiResponse<ComplaintsListResponse>>.broadcast();
  }


  bool hasNextPage = false;
  int pageNumber = 1;
  int perPage = 10;

  LoadMoreListener? listener;

  late StreamController<ApiResponse<ComplaintsListResponse>>
  _complaintsListController;

  StreamSink<ApiResponse<ComplaintsListResponse>>?
  get complaintDetailsListSink => _complaintsListController.sink;

  Stream<ApiResponse<ComplaintsListResponse>> get complaintDetailsListStream =>
      _complaintsListController.stream;

  List<Profiles> complaintList = [];

  getClaimedComplaintsList(bool isPagination, {int? perPage}) async {
    if (isPagination) {
      pageNumber = pageNumber + 1;
      listener!.refresh(true);
    } else {
      complaintDetailsListSink!.add(ApiResponse.loading('Fetching Data'));
      pageNumber = 1;
    }

    try {
      ComplaintsListResponse response = await _repository!.getCalimedComplaintList(perPage ?? 10, pageNumber);

        hasNextPage =
        response.pages!.lastPage! >= pageNumber.toInt() ? true : false;

        if (isPagination) {
          if (complaintList.length == 0) {
            complaintList = response.profiles!;
          } else {
            complaintList.addAll(response.profiles!);
          }
        } else {
          complaintList = response.profiles ?? [];
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
        complaintDetailsListSink!.add(ApiResponse.error(ApiErrorMessage.getNetworkError(error)));
      }
    } finally {
      // Cleanup or additional logic if needed
    }
  }

}