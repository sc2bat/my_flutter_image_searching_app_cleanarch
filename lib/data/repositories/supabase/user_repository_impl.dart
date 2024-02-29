import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/constants.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/dtos/user/user_dto.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/mappers/user/user_mapper.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/user/user_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/user_repository.dart';
import 'package:my_flutter_image_searching_app_cleanarch/main.dart';

class UserRepositoryImpl implements UserRepository {
  @override
  Future<Result<UserModel>> getUserInfo(String userUuid) async {
    try {
      final data = await supabase
          .from(TB_USER_PROFILE)
          .select()
          .eq('user_uuid', userUuid)
          .single();

      UserDTO userDTO = UserDTO.fromJson(data);

      UserModel userModel = UserMapper.fromDTO(userDTO);

      return Result.success(userModel);
    } catch (e) {
      return Result.error('$e');
    }
  }
}
