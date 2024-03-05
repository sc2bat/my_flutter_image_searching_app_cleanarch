class UserAccountModel {
  final int userId;
  final String userUuid;
  final String userName;
  final String email;
  final String createdAt;
  final bool isDeleted;
  final bool isVerified;
  UserAccountModel({
    required this.userId,
    required this.userUuid,
    required this.userName,
    required this.email,
    required this.createdAt,
    required this.isDeleted,
    required this.isVerified,
  });
}
