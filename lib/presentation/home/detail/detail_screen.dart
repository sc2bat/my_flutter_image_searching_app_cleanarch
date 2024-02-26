import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/constants.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/comment/comment_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/photo/photo_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/main.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/common/functions.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/common/theme.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/detail/detail_view_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/widget/common/sign_elevated_button_widget.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';
import 'package:provider/provider.dart';

import 'widget/download_box_widget.dart';

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

  final session = supabase.auth.currentSession;

  final ScrollController _detailScreenScrollerController = ScrollController();

  int userId = 1;
  @override
  void initState() {
    Future.microtask(() {
      // if (session != null) {
      //   userId = int.parse(session!.user.id);
      //   logger.info(userId);
      // }
      final detailViewModel = context.read<DetailViewModel>();
      detailViewModel.init(
        userId, // userId
        widget.imageId,
      );
    });

    _commentTextEditingController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _detailScreenScrollerController.dispose();
    _commentTextEditingController.dispose();
    super.dispose();
  }

  void _scrollToPosition(num imageHeight) {
    double itemExtent = imageHeight * 1.0;
    // logger.info(imageHeight);
    _detailScreenScrollerController.animateTo(
      itemExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  // Widget showDialog(){
  //   return showModalBottomSheet<void>(
  //           context: context,
  //           builder: (BuildContext context) {
  //             return SizedBox(
  //               height: 200,
  //               child: Center(
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: <Widget>[
  //                     const Text('Modal BottomSheet'),
  //                     ElevatedButton(
  //                       child: const Text('Close BottomSheet'),
  //                       onPressed: () => Navigator.pop(context),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             );
  //           },
  //         );
  // }

  @override
  Widget build(BuildContext context) {
    final detailViewModel = context.watch<DetailViewModel>();
    final detailState = detailViewModel.detailState;

    List<String> possibleContents = [
      'Great photo!',
      'Nice shot!',
      'Beautiful!',
      'Amazing!',
      'Wonderful!',
    ];

    List<CommentModel> commentList = List.generate(
        possibleContents.length,
        (index) => CommentModel(
              commentId: index * Random().nextInt(100),
              userId: index,
              imageId: index,
              content: possibleContents[index],
              createdAt: DateTime(2024, 01, Random().nextInt(31) + 1,
                  Random().nextInt(24), 30, Random().nextInt(60)),
            ));

    if (detailState.photoModel != null) {
      photoModel = detailState.photoModel!;
    } else {
      photoModel = PhotoModel(imageId: 1);
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'ImageCraft',
          style: TextStyle(
            color: baseColor,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                offset: const Offset(2.0, 2.0),
                blurRadius: 4.0,
                color: Colors.grey.withOpacity(0.5),
              ),
            ],
          ),
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
                  Container(
                    constraints: const BoxConstraints(
                      minHeight: 240.0,
                    ),
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
                                  logger.info('press favorite button');
                                },
                                icon: Icon(
                                  detailState.likeModel != null &&
                                          detailState.likeModel!.isDeleted
                                      ? Icons.favorite
                                      : Icons.favorite_border_rounded,
                                  color: whiteColor,
                                  size: 24.0,
                                ),
                              ),
                              const Text(
                                '300',
                                style: TextStyle(
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
                                  logger.info('press comment button');
                                  if (detailState.photoModel != null &&
                                      detailState.photoModel!.webformatWidth !=
                                          null &&
                                      detailState.photoModel!.webformatHeight !=
                                          null) {
                                    double imageHeight = MediaQuery.of(context)
                                            .size
                                            .width *
                                        detailState
                                            .photoModel!.webformatHeight! /
                                        detailState.photoModel!.webformatWidth!
                                      ..round();
                                    _scrollToPosition(imageHeight >= 240.0
                                        ? imageHeight
                                        : 240.0);
                                  }
                                },
                                icon: const Icon(
                                  Icons.chat_bubble_outline_outlined,
                                  color: whiteColor,
                                  size: 24.0,
                                ),
                              ),
                              Text(
                                '${commentList.length}',
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
                              logger.info('press download button');
                              if (detailState.photoModel != null) {
                                showModalBottomSheet<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return DownloadBoxWidget(
                                        photoModel: detailState.photoModel!);
                                  },
                                );
                              } else {
                                _showErrorDialog(context);
                              }
                            },
                            icon: const Icon(
                              Icons.image_outlined,
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
                              logger.info('press share button');
                              if (detailState.photoModel != null) {
                                showModalBottomSheet<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SizedBox(
                                      height: 200,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            const Text('Modal BottomSheet'),
                                            ElevatedButton(
                                              child: const Text(
                                                  'Close BottomSheet'),
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else {
                                _showErrorDialog(context);
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
                              logger.info('press info button');
                              if (detailState.photoModel != null) {
                                showModalBottomSheet<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return DownloadBoxWidget(
                                        photoModel: detailState.photoModel!);
                                  },
                                );
                              } else {
                                _showErrorDialog(context);
                              }
                            },
                            icon: const Icon(
                              Icons.info_outline_rounded,
                              color: whiteColor,
                              size: 24.0,
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
                          child: Text(
                            '${photoModel.tags}',
                            softWrap: true,
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
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50.0),
                                  child: Image.network(
                                    sampleUserProfileUrl,
                                    width: 48.0,
                                    height: 48.0,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: baseColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24.0),
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
                          commentList.length,
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.3,
                      ),
                      child: Scrollbar(
                        child: ListView.builder(
                          itemCount: commentList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              constraints: BoxConstraints(
                                minHeight:
                                    MediaQuery.of(context).size.height * 0.1,
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50.0),
                                      child: Image.network(
                                        sampleUserProfileUrl,
                                        width: 48.0,
                                        height: 48.0,
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
                                              child: Row(
                                                children: [
                                                  Container(
                                                    constraints:
                                                        const BoxConstraints(
                                                      maxHeight: 100,
                                                      maxWidth: 160,
                                                    ),
                                                    child: Text(
                                                      '${'username' * commentList[index].userId}${commentList[index].userId}',
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
                                                      commentList[index]
                                                          .createdAt
                                                          .toString(),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            commentList[index].userId == userId
                                                ? IconButton(
                                                    onPressed: () {},
                                                    icon: const Icon(
                                                      Icons.more_horiz_outlined,
                                                    ),
                                                  )
                                                : Container(),
                                          ],
                                        ),
                                        Text(
                                          '${commentList[index].content}',
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
                      'Recommand Image',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  for (var recommand in detailState.recommandImageList)
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
                                  'imageId': recommand['image_id'],
                                },
                              );
                            },
                            child: Image.network(
                              recommand['preview_url'],
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
}
