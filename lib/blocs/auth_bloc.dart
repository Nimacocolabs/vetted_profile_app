import 'dart:async';
import 'package:faculty_app/models/common_response.dart';
import 'package:faculty_app/models/signup_response.dart';
import 'package:faculty_app/repositories/auth_repository.dart';


class AuthBloc {
  AuthRepository? _authRepository;

  AuthBloc() {
    if (_authRepository == null) _authRepository = AuthRepository();
  }

  Future<CommonResponse> userRegistration(String body) async {
    try {
      CommonResponse response = await _authRepository!.registerUser(body);
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
//
// Future<ForgotPassVerifyOtpResponse> resetPasswordVerifyOtp(String otp) async {
//   try {
//     AppDialogs.loading();
//     ForgotPassVerifyOtpResponse response =
//     await _authRepository!.resetPasswordVerifyOtp(otp);
//     Get.back();
//     return response;
//   } catch (e, s) {
//     Get.back();
//     Completer().completeError(e, s);
//     throw e;
//   }
// }
//
// Future<ForgotPassUpdatePassResponse> resetPasswordUpdatePassword(
//     int accountId, String passwordResetToken, String password) async {
//   try {
//     return await _authRepository!
//         .resetPasswordUpdatePassword(accountId, passwordResetToken, password);
//   } catch (e, s) {
//     Completer().completeError(e, s);
//     throw e;
//   }
// }
}
