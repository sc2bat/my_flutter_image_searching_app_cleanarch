import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/user/shared/user_shared_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/shared/user_shared_state.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/shared/user_shared_view_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';
import 'package:provider/provider.dart';

class UserSharedScreen extends StatefulWidget {
  final int userId;

  const UserSharedScreen({super.key, required this.userId});

  @override
  State<UserSharedScreen> createState() => _UserSharedScreenState();
}

class _UserSharedScreenState extends State<UserSharedScreen> {
  @override
  void initState() {
    Future.microtask(() {
      final userSharedViewModel = context.read<UserSharedViewModel>();
      if (userSharedViewModel.session == null) context.go('/splash');
      userSharedViewModel.init(widget.userId);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final UserSharedViewModel userSharedViewModel = context.watch();
    final UserSharedState userSharedState = userSharedViewModel.userSharedState;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Shared',
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
              child: Text(userSharedState.isSelectMode ? 'Cancel' : 'Select'),
              onPressed: () {
                if (userSharedState.isSelectMode) {
                  userSharedViewModel.cancelImageList();
                }
                userSharedViewModel.updateIsSelectMode();
              },
            ),
          ),
        ],
      ),
      body: userSharedState.isLoading
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
                itemCount: userSharedState.userSharedList.length,
                itemBuilder: (context, index) {
                  UserSharedModel Shared =
                      userSharedState.userSharedList[index];
                  logger.info('$index번째 previewUrl: ${Shared.previewUrl}');
                  return GestureDetector(
                    onTap: () {
                      if (userSharedState.isSelectMode) {
                        userSharedViewModel.selectToDelete(Shared.shareId);
                      } else {
                        context.push('/detail', extra: {
                          'imageId': Shared.imageId,
                        });
                      }
                    },
                    onLongPress: () {
                      if (!userSharedState.isSelectMode) {
                        userSharedViewModel.updateIsSelectMode();
                        userSharedViewModel.selectToDelete(Shared.shareId);
                      }
                    },
                    child: Stack(
                      children: [
                        Image.network(
                          Shared.previewUrl,
                          fit: BoxFit.cover,
                          height: (MediaQuery.of(context).size.width >
                                  MediaQuery.of(context).size.height)
                              ? MediaQuery.of(context).size.width * 0.5
                              : MediaQuery.of(context).size.width,
                          width: (MediaQuery.of(context).size.height >
                                  MediaQuery.of(context).size.width)
                              ? MediaQuery.of(context).size.height * 0.5
                              : MediaQuery.of(context).size.height,
                        ),
                        Positioned(
                          bottom: 4.0,
                          right: 4.0,
                          child: userSharedState.isSelectMode
                              ? Container(
                                  margin: const EdgeInsets.all(4.0),
                                  child: userSharedState.selectedImageList
                                          .contains(Shared.shareId)
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
                        if (userSharedState.selectedImageList.contains(Shared.shareId))
                          Container(
                            color: Colors.white.withOpacity(0.5),
                          ),
                      ],
                    ),
                  );
                },
              ),
              if (userSharedState.selectedImageList.isNotEmpty)
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
                              'Delete(${userSharedState.selectedImageList.length})',
                              style: const TextStyle(
                                color: Colors.redAccent,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              userSharedViewModel.deleteSelectedImages();
                            })),
                  ),
                )
            ]),
    );
  }
}
