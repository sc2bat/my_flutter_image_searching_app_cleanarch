import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';

class UserHistoryScreen extends StatefulWidget {
  const UserHistoryScreen({super.key});

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

  bool _isSelectMode = false;
  List<bool> _selectedImageList = [];
  bool _isLongPressed = false;
  bool _isLongPressedAfter = false;
  int _selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    _selectedImageList = List.generate(_imageLinks.length, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
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
                 /* _isLongPressed = false;
                  _isLongPressedAfter = false;
                  _selectedIndex = -1;*/
                } /*
                if (selectedImageCount > 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Delete($selectedImageCount)'),
                      //duration: const Duration(seconds: 2),
                    ),
                  );
                }*/
              },
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 2.0,
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
                    context.push('/home');
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
                  alignment: Alignment.bottomRight,
                  children: [
                    Image.network(
                      _imageLinks[index],
                      fit: BoxFit.cover,
                    ),
                    if (_isSelectMode)
                      Container(
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
                    )
                  ),
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
        ]
      ),
    );
  }
}
