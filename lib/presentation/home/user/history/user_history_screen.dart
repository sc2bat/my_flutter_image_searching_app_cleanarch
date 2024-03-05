import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/user/history/user_history_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/history/user_history_state.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/history/user_history_view_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';
import 'package:provider/provider.dart';

class UserHistoryScreen extends StatefulWidget {
  final int userId;

  const UserHistoryScreen({super.key, required this.userId});

  @override
  State<UserHistoryScreen> createState() => _UserHistoryScreenState();
}

class _UserHistoryScreenState extends State<UserHistoryScreen> {
  @override
  void initState() {
    Future.microtask(() {
      final userHistoryViewModel = context.read<UserHistoryViewModel>();
      if (userHistoryViewModel.session == null) context.go('/splash');
      userHistoryViewModel.init(widget.userId);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final UserHistoryViewModel userHistoryViewModel = context.watch();
    final UserHistoryState userHistoryState =
        userHistoryViewModel.userHistoryState;

//    final selectedImageCount = _selectedImageList.where((e) => e == true).length;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'History',
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
              child: Text(userHistoryState.isSelectMode ? 'Cancel' : 'Select'),
              onPressed: () {
                if (userHistoryState.isSelectMode) {
                  userHistoryViewModel.cancelImageList();
                }
                userHistoryViewModel.updateIsSelectMode();
              },
            ),
          ),
        ],
      ),
      body: userHistoryState.isLoading
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
                itemCount: userHistoryState.userHistoryList.length,
                // _imageLinks.length,
                itemBuilder: (context, index) {
                  UserHistoryModel history =
                      userHistoryState.userHistoryList[index];
                  return GestureDetector(
                    onTap: () {
                      if (userHistoryState.isSelectMode) {
                        userHistoryViewModel.selectToDelete(history.viewId);
                        logger.info('ontap viewID ${history.viewId}');
                      } else {
                        context.push('/detail', extra: {
                          'imageId': history.imageId,
                        });
                      }
                    },
                    onLongPress: () {
                      if (!userHistoryState.isSelectMode) {
                        userHistoryViewModel.updateIsSelectMode();
                        userHistoryViewModel.selectToDelete(history.viewId);
                        logger.info('ontap viewID ${history.viewId}');
                      }

                      /*setState(() {
                        _selectedImageList =
                            userHistoryViewModel.getSelectedImageList();
                        _selectedImageList[index] = true;
                      });*/
                    },
                    child: Stack(
                      children: [
                        Image.network(
                          history.previewUrl,
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.width * 0.5,
                        ),
                        Positioned(
                          bottom: 4.0,
                          right: 4.0,
                          child: userHistoryState.isSelectMode
                              ? Container(
                                  margin: const EdgeInsets.all(4.0),
                                  child: userHistoryState.selectedImageList
                                          .contains(history.viewId)
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
              if (userHistoryState.selectedImageList.length > 0)
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
                              'Delete(${userHistoryState.selectedImageList.length})',
                              style: const TextStyle(
                                color: Colors.redAccent,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              userHistoryViewModel.deleteSelectedImages();
                            })),
                  ),
                )
            ]),
    );
  }
}
