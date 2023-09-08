class rowdata {
  final String firstname;
  final String lastName;
  final String identityNum;
  rowdata({required this.firstname, required this.lastName, required this.identityNum});

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstname,
      'lastName': lastName,
      'identityNum': identityNum,
    };
  }

}