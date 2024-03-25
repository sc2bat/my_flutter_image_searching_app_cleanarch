import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/user/comment/user_comment_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/common/functions.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/common/theme.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/comments/user_comments_state.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/comments/user_comments_view_model.dart';
import 'package:provider/provider.dart';

class UserCommentsScreen extends StatefulWidget {
  const UserCommentsScreen({super.key});

  @override
  @mustBeOverridden
  State<UserCommentsScreen> createState() => _UserCommentScreenState();
}

class _UserCommentScreenState extends State<UserCommentsScreen> {
  late ScrollController _scrollController;
  @override
  void initState() {
    Future.microtask(() {
      final UserCommentsViewModel userCommentsViewModel = context.read();

      if (userCommentsViewModel.session == null) context.go('/splash');

      userCommentsViewModel.init();
    });

    _scrollController = ScrollController();

    _scrollController.addListener(_scrollListener);

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final UserCommentsViewModel userCommentsViewModel = context.read();
      userCommentsViewModel.loadMoreComment(
          userCommentsViewModel.userCommentsState.userId,
          userCommentsViewModel.userCommentsState.currentItemCount);
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserCommentsViewModel userCommentsViewModel = context.watch();
    final UserCommentsState userCommentsState =
        userCommentsViewModel.userCommentsState;
    final imageSize = (MediaQuery.of(context).size.width / 4.5);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Comments',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: userCommentsState.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SizedBox(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: userCommentsState.commentList.length,
                      itemBuilder: (context, index) {
                        UserCommentModel comment =
                            userCommentsState.commentList[index];
                        return GestureDetector(
                          onTap: () => context.push('/detail', extra: {
                            'imageId': comment.imageId,
                          }),
                          child: SizedBox(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: imageSize,
                                    height: imageSize,
                                    child: Image.network(
                                      comment.previewUrl,
                                      // width: imageSize,
                                      // height: imageSize,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                      ),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Text(
                                          comment.content,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      getTimeDifference(
                                          comment.createdAt.toString()),
                                      style: TextStyle(
                                        color: weakBlack,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
