import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/photo/photo_model.dart';
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
  // 터치했던 이미지들을 가져와야 함
  final List<String> _imageLinks = [
    'https://cdn.pixabay.com/photo/2015/12/26/11/08/kaseplatte-1108564_1280.jpg',
    'https://cdn.pixabay.com/photo/2018/09/23/09/40/girl-3697030_1280.jpg',
    'https://cdn.pixabay.com/photo/2021/04/24/09/51/checklist-6203690_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/11/19/12/34/apple-1839046_1280.jpg',
    'https://cdn.pixabay.com/photo/2015/12/26/11/08/kaseplatte-1108564_1280.jpg',
    'https://cdn.pixabay.com/photo/2018/09/23/09/40/girl-3697030_1280.jpg',
    'https://cdn.pixabay.com/photo/2021/04/24/09/51/checklist-6203690_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/11/19/12/34/apple-1839046_1280.jpg',
  ];

  late PhotoModel photo;

  bool _isSelectMode = false;
  List<bool> _selectedImageList = [];
  bool _isLongPressed = false;
  bool _isLongPressedAfter = false;
  int _selectedIndex = -1;

  @override
  void initState() {
    Future.microtask(() {
      final userHistoryViewModel = context.read<UserHistoryViewModel>();
      userHistoryViewModel.init(widget.userId);
    });


    super.initState();
    _selectedImageList = List.generate(_imageLinks.length, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    final UserHistoryViewModel userHistoryViewModel = context.watch();
    final UserHistoryState userHistoryState = userHistoryViewModel.userHistoryState;
    logger.info('userHistoryList ${userHistoryState.userHistoryList}');

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
                      List.generate(_imageLinks.length, (_) => false);
                }
              },
            ),
          ),
        ],
      ),
      body: Stack(children: [
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 2.0,
            mainAxisSpacing: 2.0,
          ),
          itemCount: _imageLinks.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                if (_isSelectMode) {
                  setState(() {
                    _selectedImageList[index] = !_selectedImageList[index];
                  });
                } else {
                  context.push('/detail', extra: {
                    'imageId': photo.imageId,
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
                  _isLongPressed = true;
                  _selectedImageList =
                      List.generate(_imageLinks.length, (_) => false);
                  _selectedImageList[index] = true;
                  _selectedIndex = index;
                });
              },
              child: Stack(
                children: [
                  Image.network(
                    _imageLinks[index],
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.width*0.5,
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
                    top: BorderSide(color: Colors.grey.shade300, width: 1.0),
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
