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

  late TextEditingController _userNameTextFieldController =
      TextEditingController();
  bool _isLoading = false;
  String _userName = '';
  String _userEmail = '';

  @override
  void initState() {
    _userNameTextFieldController = TextEditingController();
    _getUserAccount();
    super.initState();
  }

  @override
  void dispose() {
    _userNameTextFieldController.dispose();
    super.dispose();
  }

  Future<void> _getUserAccount() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final userId = supabase.auth.currentUser!.id;
      final data = await supabase
          .from(TB_USER_PROFILE)
          .select()
          .eq('userId', userId)
          .single();
      _userName = data['user_name'] ?? 'none';
      _userEmail = data['email'] ?? '';
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
      count: 10,
    ),
    ActivityItem(
      icon: Icons.comment,
      title: 'Comments',
      count: 5,
    ),
    ActivityItem(
      icon: Icons.download,
      title: 'Downloaded',
      count: 3,
    ),
    ActivityItem(
      icon: Icons.share,
      title: 'Shared',
      count: 2,
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
        title: const Text('ImageCraft'),
        actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: baseColor,
              ),
              onPressed: () => signOut(),
              child: const Text(
                'SignOut',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: whiteColor,
                ),
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
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
                              context.push('/home/user/history');
                              break;
                            case 'Likes':
                              context.push('/home/user/likes');
                              break;
                            case 'Comments':
                              context.push('/home/user/comments');
                              break;
                            case 'Downloaded':
                              context.push('/home/user/downloaded');
                              break;
                            case 'Shared':
                              context.push('/home/user/shared');
                              break;
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
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
