import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_image_searching_app_cleanarch/main.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../domain/use_cases/user/user_use_case.dart';

class UserViewModel extends ChangeNotifier {
  final UserUseCase _userUseCase;

  bool _isLoading = false;
  String _userName = '';
  String _userUuid = '';
  String _userEmail = '';
  String _userPicture = '';
  int _userId = 0;

  bool get isLoading => _isLoading;
  String get userName => _userName;
  String get userUuid => _userUuid;
  String get userEmail => _userEmail;
  int get userId => _userId;
  String get userPicture => _userPicture;

  UserViewModel(this._userUseCase);

  Future<void> getUserAccount(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      final Session? session = supabase.auth.currentSession;
      final user = session?.user;
      final userUuid = user?.id;

      if (userUuid != null) {
        _userUuid = userUuid;

        final userModel = await _userUseCase.getUserInfo(_userUuid);
        _userName = userModel.userName;
        _userId = userModel.userId;
        _userPicture = userModel.userPicture;
      }
      _userEmail = user?.email ?? '';
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('getUserAccount error'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut(BuildContext context) async {
    await supabase.auth.signOut();
    logger.info('user_screen_logout');
    notifyListeners();
    context.push('/home');
  }

  void updateUserPicture(String userPicture) {
    _userPicture = userPicture;
    notifyListeners();
  }
}
