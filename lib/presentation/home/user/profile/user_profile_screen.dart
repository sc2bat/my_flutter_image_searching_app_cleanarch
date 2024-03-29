import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/user/user_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/main.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/profile/user_profile_view_model.dart';
import 'package:provider/provider.dart';

import '../../../common/theme.dart';

class UserProfileScreen extends StatefulWidget {
  final String userUuid;

  const UserProfileScreen({super.key, required this.userUuid});

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final String _currentUserName = '사용자 이름 입력';
  final String _currentUserBio = '상태 메세지 입력';

  late TextEditingController _userNameTextController;
  late TextEditingController _userBioTextController;

  StreamSubscription? _streamSubscription;

  @override
  void initState() {
    _userNameTextController = TextEditingController();
    _userBioTextController = TextEditingController();

    Future.microtask(() {
      final viewModel = context.read<UserProfileViewModel>();

      viewModel.init(widget.userUuid);

      _streamSubscription =
          viewModel.userProfileUiEventStreamController.listen((event) {
        event.when(showSnackBar: (message) {
          final snackBar = SnackBar(
            content: Text(message),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    _userNameTextController.dispose();
    _userBioTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserProfileViewModel viewModel =
        context.watch<UserProfileViewModel>();
    final state = viewModel.userProfileState;
    _userNameTextController.text = state.userName;
    _userBioTextController.text = state.userBio;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () async {
            if (_isUserDataChanged(state.userName, state.userBio)) {
              await _showBackDialog();
            } else {
              context.pop(state.userPicture);
            }
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
        actions: [
          ElevatedButton(
            onPressed: () async {
              await supabase.auth.signOut();
              if (mounted) {
                context.go('/splash');
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: baseColor,
            ),
            child: const Text(
              'Withdraw',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: whiteColor,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 16.0),
            GestureDetector(
              onTap: () => _showPicturesOptionsBottomSheet(
                UserModel(
                    userId: 0,
                    userUuid: state.userUuid,
                    userName: state.userName,
                    userPicture: state.userPicture,
                    userBio: state.userBio),
                (userPicture) => viewModel.modifyPicture(userPicture),
                () => viewModel.updateUserInfo(),
              ),
              child: Align(
                alignment: Alignment.center,
                child: state.userPicture.isNotEmpty
                    ? CircleAvatar(
                        radius: 80,
                        backgroundImage: NetworkImage(state.userPicture),
                      )
                    : const CircleAvatar(
                        radius: 80,
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
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                left: 32.0,
                right: 32.0,
              ),
              child: TextButton(
                onPressed: () {
                  _showPicturesOptionsBottomSheet(
                    UserModel(
                        userId: 0,
                        userUuid: state.userUuid,
                        userName: state.userName,
                        userPicture: state.userPicture,
                        userBio: state.userBio),
                    (userPicture) => viewModel.modifyPicture(userPicture),
                    () => viewModel.updateUserInfo(),
                  );
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
                      controller: _userNameTextController,
                      // onChanged: viewModel.modifyUserName,
                      maxLength: 30,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: _currentUserName,
                        suffixIcon: IconButton(
                          onPressed: _userNameTextController.clear,
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
                          return 'Username can\'t exceed 30 characters';
                        }
                        return null;
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
                      controller: _userBioTextController,
                      // onChanged: viewModel.modifyUserBio,
                      maxLength: 150,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: _currentUserBio,
                        suffixIcon: IconButton(
                          onPressed: _userBioTextController.clear,
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
                    ),
                  ),
                ],
              ),
            ),
            Container(height: 24.0),
            ElevatedButton(
              // Save
              onPressed: () {
                if (_isUserDataChanged(state.userName, state.userBio)) {
                  viewModel.modifyUserName(_userNameTextController.text);
                  viewModel.modifyUserBio(_userBioTextController.text);
                  viewModel.updateUserInfo();
                } else {
                  viewModel.showSnackBar('No changes were detected.');
                }
              },
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
    );
  }

  Future<void> _showBackDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Discard changes?'),
          content:
              const Text('If you go back now, you will lose your changes.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Discard changes'),
              onPressed: () {
                context.pop();
                context.pop();
              },
            ),
            TextButton(
              child: const Text('Keep editing'),
              onPressed: () {
                context.pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showPicturesOptionsBottomSheet(
      UserModel userModel,
      Function(String userPicture) updatePictureState,
      Function() updateUserInfo) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(32.0),
          child: Wrap(children: [
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Choose profile picture',
                  style: TextStyle(color: Colors.black87)),
              onTap: () async {
                final result = await context.push(
                  '/home/user/profile/choose',
                  extra: {
                    'user_model': userModel,
                  },
                );

                if (result is String) {
                  updatePictureState(result);
                }

                if (mounted) {
                  context.pop();
                }
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
                onTap: () async {
                  updatePictureState('');
                  updateUserInfo();
                  if (mounted) {
                    context.pop();
                  }
                },
              ),
            ),
          ]),
        );
      },
    );
  }

  bool _isUserDataChanged(String userName, String userBio) {
    final newUserName = _userNameTextController.text;
    final newUserBio = _userBioTextController.text;

    return newUserName != userName || newUserBio != userBio;
  }
}
