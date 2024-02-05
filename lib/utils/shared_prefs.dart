import 'package:faculty_app/models/signup_response.dart';
import 'package:faculty_app/ui/screens/login_signUp_Screen/login_screen.dart';
import 'package:faculty_app/utils/user.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late SharedPreferences _preferences;

  static String spToken = 'spToken';
  static String spUserId = 'spUserId';
  static String spEmail = 'spEmail';
  static String spName = 'spName';
  static String spMobile = 'spMobile';
  static String spRole = 'spRole';
  static String spProfileClaimed = 'spProfileClaimed';
  static String spProfileRegistered = "spProfileRegistered";
  static String spProfileResolved = "spProfileResolved";


  static init() async {
    _preferences = await SharedPreferences.getInstance();

    UserDetails.set(
      getString(spToken),
      getString(spUserId),
      getString(spName),
      getString(spEmail),
      getString(spMobile),
      getString(spRole),
      getString(spProfileClaimed),
      getString(spProfileRegistered),
      getString(spProfileResolved),
    );
  }

  static String getString(String key) {
    return _preferences.getString(key) ?? '';
  }

  static Future<bool> setString(String key, String value) async {
    return await _preferences.setString(key, value);
  }

  static Future<bool> logIn(LoginSignupResponse response) async {
    if (response.user == null) return false;

    String token = response.token ?? UserDetails.apiToken;
    User user = response.user!;
    Details details = response.details!;

    await setString(spToken, '$token');
    await setString(spUserId, '${user.id ?? ''}');
    await setString(spEmail, '${user.email ?? ''}');
    await setString(spName, '${user.name ?? ''}');
    await setString(spMobile, '${user.phone ?? ''}');
    await setString(spRole, '${user.role ?? ''}');
    await setString(spProfileClaimed, '${details.profiles!.claimed ?? ''}');
    await setString(spProfileRegistered, '${details.profiles!.registered ?? ''}');
    await setString(spProfileResolved, '${details.profiles!.resolved ?? ''}');

    UserDetails.set(
      token,
      '${user.id ?? ''}',
      '${user.name ?? ''}',
      '${user.email ?? ''}',
      '${user.phone ?? ''}',
      '${user.role ?? ''}',
      '${details.profiles!.claimed ?? ''}',
      '${details.profiles!.registered ?? ''}',
      '${details.profiles!.resolved ?? ''}',
    );
    return true;
  }

  static Future<bool> logOut() async {
    await _preferences.clear();
    UserDetails.set('', '', '', '', '', '', '', '', '',);
    Get.offAll(() => LoginScreen());
    return true;
  }

  static Future<bool> setBool(String key, bool value) async {
    return await _preferences.setBool(key, value);
  }

  static bool getBool(String key) {
    return _preferences.getBool(key) ?? false;
  }
}
