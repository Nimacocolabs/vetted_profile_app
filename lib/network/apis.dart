class Apis {
  static String registerUser = 'api/register-college';
  static String loginUser = 'api/login';
  static String logOutUser='api/logout';
  static String forgotPassword="api/forgot-password";

  //Admin
  static String addCommittee="api/admin/committee/store";
  static String fetchCommitteList="api/admin/committee/table";
  static String fetchCollegeList="api/admin/colleges/table";
  static String fetchComplaintsList="api/admin/profiles/table";
  static String deleteComplaint="api/admin/profiles/";
  static String rejectOrAccept="api/admin/colleges/";
  static String deleteCollege="api/admin/colleges/";
  static String deleteCommittee="api/admin/committee/";
  static String editCommittee="api/admin/committee/";
  static String schedule="api/admin/profiles/hearings/";
  static String fetchSheduledList="api/profiles/hearings/table";
  static String fetchSheduledData="api/profiles/";
  static String delectSchedule="api/admin/profiles/hearings/";


  //college
  static String addComplaint="api/colleges/profiles/store";
  static String fetchCollegeComplaints="api/colleges/profiles/table";
  static String deleteComplaintCollege="api/colleges/profiles/";
  static String editComplaint="api/colleges/profiles/";

  //committee
  static String fetchClaimedList="api/committees/profiles/table";
  static String addComments="api/committees/profiles/verdicts/";

  //profile
  static String fetchProfileData="api/users/edit";
  static String editProfile="api/users/update";
  static String resetPassword="api/users/change-password";
}