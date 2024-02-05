class Apis {
  static String registerUser = 'api/register-college';
  static String loginUser = 'api/login';
  static String logOutUser='api/logout';

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

  //college
  static String addComplaint="api/colleges/profiles/store";
  static String fetchCollegeComplaints="api/colleges/profiles/table";
}