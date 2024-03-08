import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_image_searching_app_cleanarch/main.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../data/data_sources/constants.dart';
import '../../common/theme.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  bool isSigned = false;

 // late TextEditingController _userNameTextFieldController = TextEditingController();
  bool _isLoading = false;
  String _userName = '';
  String _userEmail = '';
  int _userId = 0;

  @override
  void initState() {
  //  _userNameTextFieldController = TextEditingController();
    _getUserAccount();
    super.initState();
  }

  @override
  void dispose() {
  //  _userNameTextFieldController.dispose();
    super.dispose();
  }

  Future<void> _getUserAccount() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final Session? session = supabase.auth.currentSession;
      final user = session?.user;
      final userUuid = user?.id;
      if (userUuid != null) {
        final data = await supabase
            .from(TB_USER_PROFILE)
            .select()
            .eq('user_uuid', userUuid)
            .single();
        _userName = data['user_name'] ?? 'none';
        _userId = data['user_id'] ?? 0;
      }
      _userEmail = user?.email ?? '';
    } on PostgrestException catch (error) {
      SnackBar(
        content: Text(error.message),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    } catch (error) {
      SnackBar(
        content: const Text('getUserAccount error'),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
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

  Future<void> signOut() async {
    await supabase.auth.signOut();
    logger.info('user_screen_logout');
    setState(() {
      isSigned = false;
      context.push('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ImageCraft',
          style: TextStyle(
            color: baseColor,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                offset: const Offset(2.0, 2.0),
                blurRadius: 4.0,
                color: Colors.grey.withOpacity(0.5),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              ListTile(
                onTap: () => context.push('/home/user/profile'),
                leading: const Icon(
                  Icons.account_circle,
                  size: 48.0,
                  color: baseColor,
                ),
                title: Text(
                  _userName,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                subtitle: Text(_userEmail),
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
                                  context.push('/home/user/history',
                                  extra: {'userId': _userId,});
                                  break;
                                case 'Likes':
                                  context.push('/home/user/likes',
                                  extra: {'userId': _userId,});
                                  break;
                                case 'Comments':
                                  context.push('/home/user/comments');
                                  break;
                                case 'Downloads':
                                  context.push('/home/user/downloads');
                                  break;
                                case 'Shared':
                                  context.push('/home/user/shared',
                                  extra: {'userId': _userId,});
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
                  onPressed: () => signOut(),
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
