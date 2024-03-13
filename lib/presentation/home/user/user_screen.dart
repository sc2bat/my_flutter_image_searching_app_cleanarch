import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/repositories/supabase/user_repository_impl.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/use_cases/user/user_use_case.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/user_view_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/widget/common/title_logo_widget.dart';

import '../../common/theme.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late UserViewModel _userViewModel;

  @override
  void initState() {
    _userViewModel = UserViewModel(UserUseCase(UserRepositoryImpl()));
    _userViewModel.addListener(_updateUserInfo);
    _userViewModel.getUserAccount(context);

    super.initState();
  }

  @override
  void dispose() {
    _userViewModel.removeListener(_updateUserInfo);
    super.dispose();
  }

  final List<ActivityItem> _activityItems = [
    ActivityItem(
      icon: Icons.history,
      title: 'History',
    ),
    ActivityItem(
      icon: Icons.favorite,
      title: 'Likes',
    ),
    ActivityItem(
      icon: Icons.comment,
      title: 'Comments',
    ),
    ActivityItem(
      icon: Icons.download,
      title: 'Downloads',
    ),
    ActivityItem(
      icon: Icons.share,
      title: 'Shared',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const TitleLogoWidget(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              ListTile(
                onTap: () => context.push('/home/user/profile',
                    extra: {'user_uuid': _userViewModel.userUuid}),
                leading: CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage(
                      _userViewModel.userPicture),
                ),
                title: Text(
                  _userViewModel.userName,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                subtitle: Text(_userViewModel.userEmail),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'My Activity',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16.0),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: _activityItems.length,
                        itemBuilder: (context, index) {
                          final activityItem = _activityItems[index];
                          return ListTile(
                            leading: Icon(activityItem.icon),
                            title: Text(activityItem.title),
                            trailing: activityItem.count != null
                                ? Text(activityItem.count.toString())
                                : const Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              switch (activityItem.title) {
                                case 'History':
                                  context.push('/home/user/history', extra: {
                                    'userId': _userViewModel.userId,
                                  });
                                  break;
                                case 'Likes':
                                  context.push('/home/user/likes', extra: {
                                    'userId': _userViewModel.userId,
                                  });
                                  break;
                                case 'Comments':
                                  context.push('/home/user/comments');
                                  break;
                                case 'Downloads':
                                  context.push('/home/user/downloads');
                                  break;
                                case 'Shared':
                                  context.push('/home/user/shared', extra: {
                                    'userId': _userViewModel.userId,
                                  });
                                  break;
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: TextButton(
                  onPressed: () => _userViewModel.signOut(context),
                  child: Text(
                    'Sign Out',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          decoration: TextDecoration.underline,
                        ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            ],
          ),
        ],
      ),
    );
  }

  void _updateUserInfo() {
    setState(() {
      // _userName = _userViewModel.userName;
      // _userEmail = _userViewModel.userEmail;
    });
  }
}

class ActivityItem {
  final IconData icon;
  final String title;
  final int? count;

  ActivityItem({
    required this.icon,
    required this.title,
    this.count,
  });
}
