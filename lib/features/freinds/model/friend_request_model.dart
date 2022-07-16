class FreindsRequestModel {
  String username;
  String status;

  FreindsRequestModel({
    this.username,
    this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'status': status,
    };
  }

  factory FreindsRequestModel.fromMap(Map<String, dynamic> map) {
    return FreindsRequestModel(
      username: map['username'] ?? 'username',
      status: map['status'] ?? 'status',
    );
  }
}
