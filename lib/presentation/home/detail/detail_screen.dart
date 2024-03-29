import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/constants.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/comment/comment_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/photo/photo_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/common/functions.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/common/theme.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/detail/detail_view_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/detail/widget/comment_box_widget.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/widget/common/sign_elevated_button_widget.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/widget/common/title_logo_widget.dart';
import 'package:provider/provider.dart';

import 'widget/comment_edit_delete_alert_dialog_widget.dart';
import 'widget/download_box_widget.dart';
import 'widget/info_box_widget.dart';
import 'widget/share_box_widget.dart';

class DetailScreen extends StatefulWidget {
  final int imageId;
  const DetailScreen({
    super.key,
    required this.imageId,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late TextEditingController _commentTextEditingController;
  late PhotoModel photoModel;

  StreamSubscription? _streamSubscription;

  final ScrollController _detailScreenScrollerController = ScrollController();

  @override
  void initState() {
    Future.microtask(() {
      final detailViewModel = context.read<DetailViewModel>();

      _streamSubscription =
          detailViewModel.getDetailUiEventStreamController.listen((event) {
        event.when(showToast: (message) {
          Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: weakBlack,
            textColor: whiteColor,
          );
        });
      });

      detailViewModel.init(widget.imageId);
    });

    _commentTextEditingController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    _detailScreenScrollerController.dispose();
    _commentTextEditingController.dispose();
    super.dispose();
  }

  void _scrollToPosition(num imageHeight) {
    double itemExtent = imageHeight * 1.0;
    _detailScreenScrollerController.animateTo(
      itemExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final detailViewModel = context.watch<DetailViewModel>();
    final detailState = detailViewModel.detailState;

    if (detailState.photoModel != null) {
      photoModel = detailState.photoModel!;
    } else {
      photoModel = PhotoModel(imageId: 0);
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const TitleLogoWidget(),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios), // 변경하고자 하는 아이콘
          onPressed: () {
            context.pop(detailState.likeModel);
          },
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: SignElevatedButtonWidget(),
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: detailState.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              controller: _detailScreenScrollerController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.network(
                      photoModel.webformatUrl != null
                          ? photoModel.webformatUrl!
                          : dumpLoadingImage(width: 640, height: 400),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: baseColor,
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  detailViewModel.updateLike();
                                },
                                icon: Icon(
                                  detailState.likeModel != null &&
                                          detailState.likeModel!.isLiked
                                      ? Icons.favorite
                                      : Icons.favorite_border_rounded,
                                  color: whiteColor,
                                  size: 24.0,
                                ),
                              ),
                              Text(
                                '${detailState.likeCount}',
                                style: const TextStyle(
                                  color: whiteColor,
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: baseColor,
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  double imageHeight = detailViewModel
                                      .calcImageHeightMoveToComment(
                                          MediaQuery.of(context).size.width);
                                  _scrollToPosition(imageHeight >= 240.0
                                      ? imageHeight
                                      : 240.0);
                                },
                                icon: const Icon(
                                  Icons.chat_bubble_outline_outlined,
                                  color: whiteColor,
                                  size: 24.0,
                                ),
                              ),
                              Text(
                                '${detailState.commentList.length}',
                                style: const TextStyle(
                                  color: whiteColor,
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 32.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: baseColor,
                          ),
                          child: IconButton(
                            onPressed: () {
                              // logger.info('press download button');
                              if (detailViewModel.session != null) {
                                if (detailState.photoModel != null) {
                                  showModalBottomSheet<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return DownloadBoxWidget(
                                        photoModel: detailState.photoModel!,
                                        downloadFunction: (size,
                                                downloadImageUrl) =>
                                            detailViewModel.downloadFunction(
                                                size, downloadImageUrl),
                                      );
                                    },
                                  );
                                } else {
                                  _showErrorDialog(context);
                                }
                              } else {
                                detailViewModel.normalShowToast(
                                    'Download feature requires SignIn');
                              }
                            },
                            icon: const Icon(
                              Icons.download,
                              color: whiteColor,
                              size: 32.0,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: baseColor,
                          ),
                          child: IconButton(
                            onPressed: () {
                              // logger.info('press share button');
                              if (detailViewModel.session != null) {
                                detailViewModel.recordShareHistory();
                                if (detailState.photoModel != null) {
                                  showModalBottomSheet<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      String pageUrl =
                                          detailState.photoModel?.pageUrl ??
                                              'ERROR';
                                      return ShareBoxWidget(
                                        pageUrl: pageUrl,
                                        shareFunction: (message) =>
                                            detailViewModel
                                                .normalShowToast(message),
                                      );
                                    },
                                  );
                                } else {
                                  _showErrorDialog(context);
                                }
                              } else {
                                detailViewModel.normalShowToast(
                                    'Share feature requires SignIn');
                              }
                            },
                            icon: const Icon(
                              Icons.share,
                              color: whiteColor,
                              size: 24.0,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: baseColor,
                          ),
                          child: IconButton(
                            onPressed: () {
                              // logger.info('press info button');
                              if (detailState.photoModel != null) {
                                showModalBottomSheet<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return InfoBoxWidget(
                                      photoModel: detailState.photoModel!,
                                      viewCount: detailState.viewCount,
                                      downloadCount: detailState.downloadCount,
                                      shareCount: detailState.shareCount,
                                    );
                                  },
                                );
                              } else {
                                _showErrorDialog(context);
                              }
                            },
                            icon: const Icon(
                              Icons.info_outline_rounded,
                              color: whiteColor,
                              size: 32.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.label_outline_rounded,
                          size: 24.0,
                          color: baseColor,
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: Row(
                            children: List.generate(
                              photoModel.tags!.split(',').length,
                              (index) => InkWell(
                                onTap: () => context.push(
                                  '/search',
                                  extra: {
                                    'searchKeyword':
                                        photoModel.tags!.split(',')[index],
                                  },
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(
                                    photoModel.tags!.split(',')[index] +
                                        (index + 1 !=
                                                photoModel.tags!
                                                    .split(',')
                                                    .length
                                            ? ','
                                            : ''),
                                    softWrap: true,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'Comment',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: detailViewModel.session != null
                              ? Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: CircleAvatar(
                                        radius: 25.0,
                                        backgroundImage: NetworkImage(detailState
                                                .userPicture.isNotEmpty
                                            ? detailState.userPicture
                                            : '$userProfileUrlWithFirstCharacter${detailState.userName[0].toUpperCase()}'),
                                      ),
                                    ),
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (detailState.photoModel != null) {
                                            showModalBottomSheet<void>(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return CommentBoxWidget(
                                                  insertCommentFunction:
                                                      (content) =>
                                                          detailViewModel
                                                              .insertComment(
                                                                  content),
                                                  commentTextFieldValidation:
                                                      (List<String> message) {
                                                    return detailViewModel
                                                        .commentTextFieldValidation(
                                                            message);
                                                  },
                                                );
                                              },
                                            );
                                          } else {
                                            _showErrorDialog(context);
                                          }
                                          double imageHeight = detailViewModel
                                              .calcImageHeightMoveToComment(
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width);
                                          _scrollToPosition(imageHeight >= 240.0
                                              ? imageHeight
                                              : 240.0);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: baseColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(24.0),
                                          ),
                                        ),
                                        child: const Text(
                                          'Add Comment',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: whiteColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        'The community is waiting for your news!\nSign in to write comments.'),
                                  ],
                                ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height *
                          0.1 *
                          detailState.commentList.length,
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.3,
                      ),
                      child: Scrollbar(
                        child: ListView.builder(
                          itemCount: detailState.commentList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              constraints: BoxConstraints(
                                minHeight:
                                    MediaQuery.of(context).size.height * 0.1,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        8.0, 18.0, 8.0, 8.0),
                                    child: InkWell(
                                      onTap: () => showUserInfoDialog(
                                          detailState.commentList[index]),
                                      child: CircleAvatar(
                                        radius: 25.0,
                                        backgroundImage: NetworkImage(detailState
                                                .commentList[index]
                                                .userPicture
                                                .isNotEmpty
                                            ? detailState
                                                .commentList[index].userPicture
                                            : '$userProfileUrlWithFirstCharacter${detailState.commentList[index].userName[0].toUpperCase()}'),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              constraints: const BoxConstraints(
                                                minHeight: 48.0,
                                              ),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    constraints:
                                                        const BoxConstraints(
                                                      maxHeight: 100,
                                                      maxWidth: 160,
                                                    ),
                                                    child: Text(
                                                      detailState
                                                          .commentList[index]
                                                          .userName,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                  VerticalDivider(
                                                    color: weakBlack,
                                                    thickness: 1.0,
                                                  ),
                                                  Text(
                                                    getTimeDifference(
                                                      detailState
                                                          .commentList[index]
                                                          .createdAt
                                                          .toString(),
                                                    ),
                                                    style: TextStyle(
                                                      color: weakBlack,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            detailState.commentList[index]
                                                        .userId ==
                                                    detailState.userId
                                                ? IconButton(
                                                    onPressed: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return CommentEditDeleteAlertDialogWidget(
                                                            commentInfo: detailState
                                                                    .commentList[
                                                                index],
                                                            editCommentFunction: (commentId,
                                                                    content) =>
                                                                detailViewModel
                                                                    .editComment(
                                                                        commentId,
                                                                        content),
                                                            deleteCommentFunction:
                                                                (commmentId) =>
                                                                    detailViewModel
                                                                        .deleteComment(
                                                                            commmentId),
                                                          );
                                                        },
                                                      );
                                                    },
                                                    style: const ButtonStyle(
                                                      fixedSize:
                                                          MaterialStatePropertyAll(
                                                              Size(16.0, 16.0)),
                                                    ),
                                                    icon: const Icon(
                                                      Icons.more_horiz_outlined,
                                                    ),
                                                  )
                                                : Container(),
                                          ],
                                        ),
                                        Text(
                                          '${detailState.commentList[index].content}',
                                          softWrap: true,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Trending',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  for (var recommend in detailState.recommendImageList)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: GestureDetector(
                            onTap: () {
                              context.push(
                                '/detail',
                                extra: {
                                  'imageId': recommend['image_id'],
                                },
                              );
                            },
                            child: Image.network(
                              recommend['preview_url'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
    );
  }

  Future<void> _showErrorDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text(
            'Please ask administrator',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  showUserInfoDialog(CommentModel commentList) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.6,
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: Center(
                      child: commentList.userPicture.isNotEmpty
                          ? CircleAvatar(
                              radius: 100.0,
                              backgroundImage:
                                  NetworkImage(commentList.userPicture),
                            )
                          : const CircleAvatar(
                              radius: 100.0,
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
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      commentList.userName,
                      style: const TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      commentList.userBio.isNotEmpty
                          ? commentList.userBio
                          : 'No status message.',
                      style: const TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
