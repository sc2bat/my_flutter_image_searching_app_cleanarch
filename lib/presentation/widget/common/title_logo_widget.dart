import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/common/theme.dart';

class TitleLogoWidget extends StatelessWidget {
  const TitleLogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.go('/home'),
      child: Text(
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
    );
  }
}
