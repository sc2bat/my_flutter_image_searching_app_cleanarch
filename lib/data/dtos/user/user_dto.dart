class UserDTO {
  final int userId;
  final String userUuid;
  final String userName;
  final DateTime updatedAt;
  final bool isDeleted;
  String? userPicture;
  String? userBio;

  UserDTO({
    required this.userId,
    required this.userUuid,
    required this.userName,
    required this.updatedAt,
    required this.isDeleted,
    required this.userPicture,
    required this.userBio,
  });

  factory UserDTO.fromJson(Map<String, dynamic> json) {
    return UserDTO(
      userId: json['user_id'] as int,
      userUuid: json['user_uuid'] as String,
      userName: json['user_name'] as String,
      updatedAt: DateTime.parse(json['updated_at'] as String),
      isDeleted: json['is_deleted'] as bool,
      userPicture: json['user_picture'] as String?,
      userBio: json['user_bio'] as String?,
    );
  }
}
