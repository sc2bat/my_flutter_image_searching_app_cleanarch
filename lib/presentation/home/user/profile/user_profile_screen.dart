import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../common/theme.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final _userNameController = TextEditingController();
  final _userBioController = TextEditingController();
  final _userPictureController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initUserProfileFields();
  }

  void _initUserProfileFields() {
    setState(() {
      // TODO: 입력받아 저장한 userName을 _userNameController의 text로 설정
      _userNameController.text = '수정한 username';
      _userBioController.text = '수정한 bio';
      _userPictureController.text = '선택한 Picture';
    });
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _userBioController.dispose();
    _userPictureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            // TODO: userName 또는 userBio 값이 변경됨 & Save changes 버튼이 안 눌렸으면
            _showBackDialog();
            // TODO: context.push('/home/user');
          },
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 16.0),
              GestureDetector(
                onTap: () => _showPicturesOptionsBottomSheet(),
                child: Align(
                  alignment: Alignment.center,
                  child: _userPictureController
                          .text.isNotEmpty // userPicture 고른 상태면,
                      ? const CircleAvatar(
                          radius: 80,
                          backgroundImage: NetworkImage(
                            // TODO: 아래 '링크'를 userPicture로 받아서 대체
                            'https://cdn.pixabay.com/photo/2019/04/06/06/44/astronaut-4106766_960_720.jpg',
                          ),
                        )
                      : const CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.transparent,
                          child: FittedBox(
                            // userPicture 고르지 않은 default
                            child: Icon(
                              Icons.account_circle,
                              size: 200,
                              color: baseColor,
                            ),
                          ),
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  left: 32.0,
                  right: 32.0,
                ),
                child: TextButton(
                  onPressed: () {
                    // TODO: 하단 Widget 띄우기 Choose from Likes, Remove current picture
                    _showPicturesOptionsBottomSheet();
                  },
                  child: const Text(
                    'Edit picture',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Divider(),
              const SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  // userName
                  children: <Widget>[
                    const Text(
                      'Username',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(width: 32.0),
                    Expanded(
                      child: TextFormField(
                        maxLength: 30,
                        maxLines: null,
                        controller: _userNameController,
                        decoration: InputDecoration(
                          hintText: 'Edit username here',
                          suffixIcon: IconButton(
                            onPressed: () => _userNameController.clear(),
                            icon: const Icon(
                              Icons.cancel,
                              size: 20,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter username';
                          }
                          if (value.length > 30) {
                            return 'Username can' 't exceed 30 characters';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _userNameController.text = value!;
                        },
                        onTap: () {
                          // TODO: Dialog에서 수정. userNameScreen에서 수정하려면 context.push('/home/user/profile/username');
                          // _showEditUserNameDialog();
                        },
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 14.0),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  // userBio
                  children: <Widget>[
                    const Text(
                      'Bio',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(width: 93.0),
                    Expanded(
                      child: TextFormField(
                        maxLength: 150,
                        maxLines: null,
                        controller: _userBioController,
                        decoration: InputDecoration(
                          hintText: 'Edit bio here',
                          suffixIcon: IconButton(
                            onPressed: () => _userBioController.clear(),
                            icon: const Icon(
                              Icons.cancel,
                              size: 20,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value!.length > 150) {
                            return 'Bio cannot exceed 150 characters';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _userBioController.text = value!;
                        },
                        onTap: () {
                          // TODO: Dialog에서 수정. userBioScreen에서 수정하려면 context.push('/home/user/profile/userbio');
                          _showEditUserBioDialog;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(height: 24.0),
              ElevatedButton(
                // Save
                onPressed: _saveChanges,
                style: ElevatedButton.styleFrom(
                  backgroundColor: editColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Save changes',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditUserNameDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit username'),
          content: TextFormField(
            maxLength: 30,
            maxLines: null,
            // TODO: tb_user_profile.username
            controller: _userNameController,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  _userNameController.clear();
                },
                icon: const Icon(Icons.cancel),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter username';
              }
              if (value.length > 30) {
                return 'Username can' 't exceed 30 characters';
              }
              return null;
            },
          ),
          actions: <Widget>[
            Row(
              children: [
                ElevatedButton(
                  // Discard Changes
                  onPressed: () {
                    // TODO: 수정한 userName 저장하지 않기
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
                Container(
                  width: 32.0,
                ),
                ElevatedButton(
                  // Save
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
          title: const Text('Edit Bio'),
          content: TextFormField(
            maxLength: 150,
            maxLines: null,
            controller: _userBioController,
            decoration: InputDecoration(
              // TODO: tb_user_profile.userBio 가져와서 labelText 대체
              labelText: 'bio_example',
              suffixIcon: IconButton(
                onPressed: () {
                  _userBioController.clear();
                },
                icon: const Icon(Icons.cancel),
              ),
            ),
            validator: (value) {
              if (value!.length > 150) {
                return 'Bio cannot exceed 150 characters';
              }
              return null;
            },
          ),
          actions: <Widget>[
            Row(
              children: [
                ElevatedButton(
                  // Discard Changes
                  onPressed: () {
                    // TODO: 수정한 userBio 저장하지 않기
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
                ElevatedButton(
                  // Save
                  onPressed: () {
                    // TODO: 수정한 userBio 저장
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
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> _showBackDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Discard changes?'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('If you go back now, you will lose your changes.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Discard changes'),
              onPressed: () {
                context.push('/home/user');
              },
            ),
            TextButton(
              child: const Text('Keep editing'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _showPicturesOptionsBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(32.0),
          child: Wrap(children: [
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Choose from Likes',
              style: TextStyle(color: Colors.black87)),
              onTap: () {
                // TODO: Likes grid 보여주고 선택하는 페이지, 선택한 사진 가져와서 CircleAvatar에 띄우기
                Navigator.pop(context);
              },
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: ListTile(
                leading: const Icon(
                  Icons.delete_outline,
                  color: Colors.redAccent,
                ),
                title: const Text('Remove current picture',
                    style: TextStyle(color: Colors.redAccent)),
                onTap: () {
                  setState(() {
                  // TODO: 프로필 사진을 기본값으로. Icon(Icons.account_circle) 또는 userProfileUrlWithFirstCharacter
                    _userPictureController.text = '';
                  });
                  Navigator.pop(context);
                },
              ),
            ),
          ]),
        );
      },
    );
  }

  void _saveChanges() {
    // TODO: 수정된 userName 또는 userBio 저장
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Changes saved successfully'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
