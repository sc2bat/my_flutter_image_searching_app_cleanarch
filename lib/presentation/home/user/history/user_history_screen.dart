import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/photo/photo_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/user/history/user_history_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/history/user_history_state.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/history/user_history_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../utils/simple_logger.dart';

class UserHistoryScreen extends StatefulWidget {
  final int userId;
  const UserHistoryScreen({super.key, required this.userId});

  @override
  State<UserHistoryScreen> createState() => _UserHistoryScreenState();
}

class _UserHistoryScreenState extends State<UserHistoryScreen> {

  late PhotoModel photo;

  bool _isSelectMode = false;
  List<bool> _selectedImageList = [];

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

    final selectedImageCount =
        _selectedImageList.where((e) => e == true).length;
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
              child: Text(_isSelectMode ? 'Cancel' : 'Select'),
              onPressed: () {
                setState(() {
                  _isSelectMode = !_isSelectMode;
                });
                if (!_isSelectMode) {
                  _selectedImageList =
                      List.generate(userHistoryState.userHistoryList.length, (_) => false);
                  logger.info('_imageLinks 대신 userHistoryState.userHistoryList.length 에러');
                }
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
                  UserHistoryModel history = userHistoryState.userHistoryList[index];
                  return GestureDetector(
                    onTap: () {
                      if (_isSelectMode) {
                        setState(() {
                          _selectedImageList[index] =
                              !_selectedImageList[index];
                        });
                      } else {
                        context.push('/detail', extra: {
                          'imageId': history.imageId,
                        });
                      }
                    },
                    onLongPress: () {
                      if (!_isSelectMode) {
                        setState(() {
                          _isSelectMode = true;
                        });
                      }
                      setState(() {
                        _selectedImageList =
                            List.generate(userHistoryState.userHistoryList.length, (_) => false);
                        _selectedImageList[index] = true;
                      });
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
                          child: _isSelectMode
                              ? Container(
                                  margin: const EdgeInsets.all(4.0),
                                  child: _selectedImageList[index]
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
              if (selectedImageCount > 0)
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
                      child: Text(
                        'Delete($selectedImageCount)',
                        style: const TextStyle(
                          color: Colors.redAccent,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
            ]),
    );
  }
}
