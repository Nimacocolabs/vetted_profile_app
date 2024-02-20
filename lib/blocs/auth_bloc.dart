import 'dart:async';
import 'package:faculty_app/models/common_response.dart';
import 'package:faculty_app/models/register_response.dart';
import 'package:faculty_app/models/signup_login_response.dart';
import 'package:faculty_app/repositories/auth_repository.dart';


class AuthBloc {
  AuthRepository? _authRepository;

  AuthBloc() {
    if (_authRepository == null) _authRepository = AuthRepository();
  }

  Future<RegisterResponse> userRegistration(String body) async {
    try {
      RegisterResponse response = await _authRepository!.registerUser(body);
      return response;
    } catch (e, s) {
      Completer().completeError(e, s);
      throw e;
    }
  }

  Future<LoginSignupResponse> login(String body) async {
    try {
      return await _authRepository!.login(body);
    } catch (e, s) {
      Completer().completeError(e, s);
      throw e;
    }
  }

  Future<CommonResponse> forgotPassword(String body) async {
    try {
      return await _authRepository!.forgotPassword(body);
    } catch (e, s) {
      Completer().completeError(e, s);
      throw e;
    }
  }


  Future<CommonResponse> addPayment( String id,
      String body,
      ) async {
    try {
      CommonResponse response = await _authRepository!.addPayment(id,body);
      return response;
    } catch (e, s) {
      Completer().completeError(e, s);
      throw e;
    }
  }

}
