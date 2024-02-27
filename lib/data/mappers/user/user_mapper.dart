import 'package:my_flutter_image_searching_app_cleanarch/data/dtos/user/user_dto.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/user/user_model.dart';

class UserMapper {
  static UserModel fromDTO(UserDTO userDTO) {
    return UserModel(
      userId: userDTO.userId,
      userUuid: userDTO.userUuid,
      userName: userDTO.userName,
    );
  }
}
