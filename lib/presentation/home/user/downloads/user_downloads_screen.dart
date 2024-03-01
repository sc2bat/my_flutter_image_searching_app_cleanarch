import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/user/download/user_download_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/common/functions.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/common/theme.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/downloads/user_downloads_state.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/downloads/user_downloads_view_model.dart';
import 'package:provider/provider.dart';

class UserDownloadsScreen extends StatefulWidget {
  const UserDownloadsScreen({super.key});

  @override
  @mustBeOverridden
  State<UserDownloadsScreen> createState() => _UserDownloadscreenState();
}

class _UserDownloadscreenState extends State<UserDownloadsScreen> {
  late ScrollController _scrollController;
  @override
  void initState() {
    Future.microtask(() {
      final UserDownloadsViewModel userDownloadsViewModel = context.read();

      if (userDownloadsViewModel.session == null) context.go('/splash');

      userDownloadsViewModel.init();
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
      final UserDownloadsViewModel userDownloadsViewModel = context.read();
      userDownloadsViewModel.getUserDownloadList(
          userDownloadsViewModel.userDownloadsState.userId,
          userDownloadsViewModel.userDownloadsState.currentItemCount);
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserDownloadsViewModel userDownloadsViewModel = context.watch();
    final UserDownloadsState userDownloadsState =
        userDownloadsViewModel.userDownloadsState;
    final imageSize = (MediaQuery.of(context).size.width / 4.5);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Downloads',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: userDownloadsState.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: userDownloadsState.downloadList.length,
                      itemBuilder: (context, index) {
                        UserDownloadModel item =
                            userDownloadsState.downloadList[index];
                        return Dismissible(
                          key: Key(item.downloadId.toString()),
                          onDismissed: (direction) {
                            userDownloadsViewModel.dismiss(
                              indexList: [index],
                              downloadIdList: [item.downloadId],
                            );
                          },
                          background: Container(
                            color: deleteColor,
                            alignment: Alignment.centerRight,
                            child: const Padding(
                              padding: EdgeInsets.only(right: 16.0),
                              child: Icon(
                                Icons.delete,
                                size: 48.0,
                                color: whiteColor,
                              ),
                            ),
                          ),
                          child: Container(
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () => context.push('/detail', extra: {
                                    'imageId': item.imageId,
                                  }),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: imageSize,
                                      height: imageSize,
                                      child: Image.network(
                                        item.previewUrl,
                                        fit: BoxFit.cover,
                                      ),
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
                                                0.6,
                                      ),
                                      child: Text(
                                        'fileName : ${item.fileName.split('/').last}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Container(
                                      constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.label_outline_rounded,
                                            size: 24.0,
                                            color: baseColor,
                                          ),
                                          Container(
                                            constraints: BoxConstraints(
                                              maxWidth: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.6,
                                            ),
                                            child: Text(
                                              'tags : ${item.tags}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      getTimeDifference(
                                          item.donwloadedAt.toString()),
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
