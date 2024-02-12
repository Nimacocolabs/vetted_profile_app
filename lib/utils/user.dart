

class UserDetails {
  static String apiToken = '';
  static String userId = '';
  static String userName = '';
  static String userEmail = '';
  static String userMobile = '';
  static String userRole = '';


  static void set(
      String token,
      String id,
      String name,
      String email,
      String mobile,
      String role,
      ) {
    apiToken = token;
    userId = id;
    userName = name;
    userEmail = email;
    userMobile = mobile;
    userRole = role;
  }
}
