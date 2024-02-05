

class UserDetails {
  static String apiToken = '';
  static String userId = '';
  static String userName = '';
  static String userEmail = '';
  static String userMobile = '';
  static String userRole = '';
  static String userProfileClaim="";
  static String userProfileRegister="";
  static String userProfileResolve="";


  static void set(
      String token,
      String id,
      String name,
      String email,
      String mobile,
      String role,
      String ProfileClaim,
      String ProfileRegister,
      String ProfileResolve,
      ) {
    apiToken = token;
    userId = id;
    userName = name;
    userEmail = email;
    userMobile = mobile;
    userRole = role;
    userProfileClaim = ProfileClaim;
    userProfileRegister = ProfileRegister;
    userProfileResolve =ProfileResolve;
  }
}
