class UserModel {
  final String userCode;
  final String displayName;
  final String email;
  final String employeeCode;
  final String companyCode;

  UserModel({
    required this.userCode,
    required this.displayName,
    required this.email,
    required this.employeeCode,
    required this.companyCode,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userCode: json['User_Code'] ?? '',
      displayName: json['User_Display_Name'] ?? '',
      email: json['Email'] ?? '',
      employeeCode: json['User_Employee_Code'] ?? '',
      companyCode: json['Company_Code'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'User_Code': userCode,
      'User_Display_Name': displayName,
      'Email': email,
      'User_Employee_Code': employeeCode,
      'Company_Code': companyCode,
    };
  }
}
