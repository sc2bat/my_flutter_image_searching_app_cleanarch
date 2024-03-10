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

  @override
  Future<Result<void>> updateUserName(String userId, String newUserName) async {
    try {
      await supabase
          .from(TB_USER_PROFILE)
          .update({'user_name': newUserName})
          .eq('user_id', userId)
          .single();
      return const Result.success(null);
    } catch (e) {
      return Result.error('$e');
    }
  }

  @override
  Future<Result<void>> updateUserBio(String userId, String newUserBio) async {
    try {
      await supabase
          .from(TB_USER_PROFILE)
          .update({'user_bio': newUserBio})
          .eq('user_id', userId)
          .single();
      return const Result.success(null);
    } catch (e) {
      return Result.error('$e');
    }
  }
  @override
  Future<Result<void>> updateUserPicture(String userId, String newUserPicture) async {
    try {
      await supabase
          .from(TB_USER_PROFILE)
          .update({'user_picture': newUserPicture})
          .eq('user_id', userId)
          .single();
      return const Result.success(null);
    } catch (e) {
      return Result.error('$e');
    }
  }
}