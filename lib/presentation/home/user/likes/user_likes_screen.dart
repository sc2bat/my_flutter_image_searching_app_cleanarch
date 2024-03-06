import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/likes/user_likes_state.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/likes/user_likes_view_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';
import 'package:provider/provider.dart';

import '../../../../domain/model/user/likes/user_likes_model.dart';

class UserLikesScreen extends StatefulWidget {
  final int userId;

  const UserLikesScreen({super.key, required this.userId});

  @override
  State<UserLikesScreen> createState() => _UserLikesScreenState();
}

class _UserLikesScreenState extends State<UserLikesScreen> {
  @override
  void initState() {
    Future.microtask(() {
      final userLikesViewModel = context.read<UserLikesViewModel>();
      if (userLikesViewModel.session == null) context.go('/splash');
      userLikesViewModel.init(widget.userId);
    });

    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    final UserLikesViewModel userLikesViewModel = context.watch();
    final UserLikesState userLikesState =
        userLikesViewModel.userLikesState;
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Likes',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextButton(
              child: Text(userLikesState.isSelectMode ? 'Cancel' : 'Select'),
              onPressed: () {
                if (userLikesState.isSelectMode) {
                  userLikesViewModel.cancelImageList();
                }
                userLikesViewModel.updateIsSelectMode();
              },
            ),
          ),
        ],
      ),
      body: userLikesState.isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : Stack(children: [
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 2.0,
            mainAxisSpacing: 2.0,
          ),
          itemCount: userLikesState.userLikesList.length,
          itemBuilder: (context, index) {
            UserLikesModel likes =
            userLikesState.userLikesList[index];
            logger.info('$index번째 previewUrl: ${likes.previewUrl}');
            return GestureDetector(
              onTap: () {
                if (userLikesState.isSelectMode) {
                  userLikesViewModel.selectToDelete(likes.likeId);
                } else {
                  context.push('/detail', extra: {
                    'imageId': likes.imageId,
                  });
                }
              },
              onLongPress: () {
                if (!userLikesState.isSelectMode) {
                  userLikesViewModel.updateIsSelectMode();
                  userLikesViewModel.selectToDelete(likes.likeId);
                }
              },
              child: Stack(
                children: [
                  Image.network(
                    likes.previewUrl,
                    fit: BoxFit.cover,
                    height: (MediaQuery.of(context).size.width > MediaQuery.of(context).size.height)
                        ? MediaQuery.of(context).size.width * 0.5
                        : MediaQuery.of(context).size.width,
                    width: (MediaQuery.of(context).size.height > MediaQuery.of(context).size.width)
                        ? MediaQuery.of(context).size.height * 0.5
                        : MediaQuery.of(context).size.height,
                  ),
                  Positioned(
                    bottom: 4.0,
                    right: 4.0,
                    child: userLikesState.isSelectMode
                        ? Container(
                      margin: const EdgeInsets.all(4.0),
                      child: userLikesState.selectedImageList
                          .contains(likes.likeId)
                          ? const Icon(
                        Icons.check_circle,
                        color: Colors.blueAccent,
                        size: 24.0,
                      )
                          : const Icon(
                        Icons.circle_outlined,
                        color: Colors.grey,
                        size: 24.0,
                      ),
                    )
                        : const SizedBox(),
                  ),
                ],
              ),
            );
          },
        ),
        if (userLikesState.selectedImageList.isNotEmpty)
          Positioned(
            bottom: 32.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              height: 50.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
                        color: Colors.grey.shade300, width: 1.0),
                  )),
              child: Center(
                  child: TextButton(
                      child: Text(
                        'Delete(${userLikesState.selectedImageList.length})',
                        style: const TextStyle(
                          color: Colors.redAccent,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        userLikesViewModel.deleteSelectedImages();
                      })),
            ),
          )
      ]),
    );
  }
}
