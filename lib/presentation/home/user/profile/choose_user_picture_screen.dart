import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/photo/photo_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/user/user_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/common/theme.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/profile/choose_user_picture_state.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/user/profile/choose_user_picture_view_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';
import 'package:provider/provider.dart';

class ChooseUserPictureScreen extends StatefulWidget {
  final UserModel userModel;

  const ChooseUserPictureScreen({super.key, required this.userModel});

  @override
  State<ChooseUserPictureScreen> createState() =>
      _ChooseUserPictureScreenState();
}

class _ChooseUserPictureScreenState extends State<ChooseUserPictureScreen> {
  @override
  void initState() {
    Future.microtask(() {
      final chooseUserPictureViewModel =
          context.read<ChooseUserPictureViewModel>();
      chooseUserPictureViewModel.init(widget.userModel.userUuid);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ChooseUserPictureViewModel chooseUserPictureViewModel =
        context.watch();
    final ChooseUserPictureState chooseUserPictureState =
        chooseUserPictureViewModel.chooseUserPictureState;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => context.pop(),
        ),
        centerTitle: true,
        title: const Text(
          'Choose profile picture',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await chooseUserPictureViewModel.saveUserPicture();
              if (mounted) {
                context.pop(chooseUserPictureState.selectedUserPicture);
              }
            },
            child: const Text(
              'Done',
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(48.0),
            child: chooseUserPictureState
                    .selectedUserPicture.isNotEmpty // userPicture 고른 상태면,
                ? CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage(
                        chooseUserPictureState.selectedUserPicture),
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
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2.0,
                mainAxisSpacing: 2.0,
              ),
              itemCount: chooseUserPictureState.photoList.length,
              itemBuilder: (context, index) {
                PhotoModel photo = chooseUserPictureState.photoList[index];
                return InkWell(
                  onTap: () {
                    if (photo.previewUrl != null) {
                      chooseUserPictureViewModel
                          .selectUserPicture(photo.previewUrl!);
                    } else {
                      logger.info('previewUrl is null');
                    }
                  },
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: CupertinoColors.systemGrey4),
                        ),
                        child: Image.network(
                          photo.previewUrl!,
                          fit: BoxFit.cover,
                          height: (MediaQuery.of(context).size.width >
                                  MediaQuery.of(context).size.height)
                              ? MediaQuery.of(context).size.width * 0.5
                              : MediaQuery.of(context).size.width,
                          width: (MediaQuery.of(context).size.height >
                                  MediaQuery.of(context).size.width)
                              ? MediaQuery.of(context).size.height * 0.5
                              : MediaQuery.of(context).size.height,
                        ),
                      ),
                      if (chooseUserPictureState.selectedUserPicture ==
                          photo.previewUrl)
                        Container(
                          color: Colors.white.withOpacity(0.5),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
