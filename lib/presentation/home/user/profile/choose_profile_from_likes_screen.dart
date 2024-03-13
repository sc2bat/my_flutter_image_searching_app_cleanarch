import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/repositories/supabase/user_repository_impl.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/user/likes/user_likes_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/user/user_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/common/theme.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/likes/user_likes_state.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/likes/user_likes_view_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';
import 'package:provider/provider.dart';

class ChooseProfileFromLikesScreen extends StatefulWidget {
  final String userUuid;
  final int userId;

  const ChooseProfileFromLikesScreen(
      {super.key, required this.userId, required this.userUuid});

  @override
  State<ChooseProfileFromLikesScreen> createState() =>
      _ChooseProfileFromLikesScreenState();
}

class _ChooseProfileFromLikesScreenState
    extends State<ChooseProfileFromLikesScreen> {
  UserModel? userModel;
  String selectedUserPicture = '';

  @override
  void initState() {
    Future.microtask(() {
      final userLikesViewModel = context.read<UserLikesViewModel>();
      if (userLikesViewModel.session == null) context.go('/splash');
      userLikesViewModel.init(widget.userId);
    });
    super.initState();
  }

  Future<void> updateUserPicture(
  ) async {
    try {
      await UserRepositoryImpl()
          .updateUserField(widget.userUuid, 'user_picture', selectedUserPicture);
    } catch (e) {
      logger.info('updateUserPicture 에러: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserLikesViewModel userLikesViewModel = context.watch();
    final UserLikesState userLikesState = userLikesViewModel.userLikesState;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => context.pop(), // Go back to previous screen
        ),
        centerTitle: true,
        title: const Text(
          'Favorites',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              updateUserPicture;
              context.pop;
            },
            child: const Text(
              'Done',
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            // TODO: 선택한 사진. 선택하지 않았을 때는 Likes 최근 이미지
            child: selectedUserPicture.isNotEmpty // userPicture 고른 상태면,
                ? CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage(userLikesState.userLikesList[0].previewUrl),
                  )
                : const CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.transparent,
                    child: FittedBox(
                      child: Icon(
                        Icons.account_circle,
                        size: 200,
                        color: baseColor,
                      ),
                    ),
                  ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 2.0,
                  mainAxisSpacing: 2.0,
                ),
                itemCount: userLikesState.userLikesList.length,
                itemBuilder: (context, index) {
                  UserLikesModel likes = userLikesState.userLikesList[index];
                  logger.info('$index번째 previewUrl: ${likes.previewUrl}');
                  return GestureDetector(
                    onTap: () {
                      selectedUserPicture = likes.previewUrl;
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
