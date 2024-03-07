import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/constants.dart';
import 'package:my_flutter_image_searching_app_cleanarch/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../common/theme.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final _userNameController = TextEditingController();
  final _userBioController = TextEditingController();

  @override
  void dispose() {
    _userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( // < Edit profile
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.push('/home/user'),
        ),
        centerTitle: true,
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 60,
                // TODO: 아래 직접 입력한 링크 대신에, user가 고른 userPicture 또는 fluttermoji 받아오기
                backgroundImage: NetworkImage(
                    'https://pixabay.com/photos/astronaut-moon-space-nasa-planet-4106766/'),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () { // Edit picture
                // TODO: 하단 Widget 띄우기 Choose from Likes, Create avatar, Remove current picture
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      child: Wrap(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.favorite),
                              title: const Text('Choose from Likes'),
                              onTap: () {
                                // TODO: Likes grid 보여주고 선택하는 페이지, 선택한 사진 가져와서 CircleAvatar에 띄우기
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                                leading: const Icon(Icons.delete_outline),
                                title: const Text('Remove',
                                    style: TextStyle(color: Colors.redAccent)),
                                onTap: () {
                                  // TODO: 프로필 사진을 기본값으로. Icon(Icons.account_circle) 또는 userProfileUrlWithFirstCharacter
                                  /* Image.network(
                                  '$userProfileUrlWithFirstCharacter${detailState.commentList[index].userName[0].toUpperCase()}',
                                );*/
                                  Navigator.pop(context);
                                }
                            )
                          ]
                      ),
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: baseColor,
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(24.0),
                ),
              ),
              child: const Text(
                'Edit picture',
                style: TextStyle(
                  color: Colors.blueAccent,
                ),
              ),
            ),
            TextFormField(
              controller: _userNameController,
              labelText: 'Username',
              onTap: () {
                // TODO: Likes grid 보여주고 선택하는 페이지, 선택한 사진 가져와서 CircleAvatar에 띄우기
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Choose from Likes'),
              onTap: () {
                // TODO: Likes grid 보여주고 선택하는 페이지, 선택한 사진 가져와서 CircleAvatar에 띄우기
                Navigator.pop(context);
              },
            ),

            const Divider(),
          ],
        ),
      ),
    );
  }

  void _showEditUserNameDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Username'),
          content: TextFormField(
            controller: _userNameController,
            decoration: InputDecoration(
              // TODO: tb_user_profile.username 가져와서 labelText 대체
              labelText: 'username_example',
              suffixIcon: IconButton(
                onPressed: () {
                  _userNameController.clear();
                },
                icon: Icon(Icons.clear),
              ),
            ),
          ),
          actions: <Widget>[
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // TODO: 수정한 userName 저장
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: editColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // TODO: 수정한 userName 저장하지 않기
                    // widget.deleteCommentFunction(widget.commentInfo.commentId);
                    context.pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: deleteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'Discard Changes',
                    style: TextStyle(
                      color: whiteColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _showEditUserBioDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Bio'),
            content: TextField(
              controller: _userBio,
              decoration: const InputDecoration(hintText: 'Enter new bio'),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Save'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        }
    );
  }
}