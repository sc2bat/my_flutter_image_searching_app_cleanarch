import 'package:flutter/material.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/common/theme.dart';

class MainLogoTextWidget extends StatelessWidget {
  const MainLogoTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 40.0,
      ),
      child: Center(
        child: Text(
          'ImageCraft',
          style: TextStyle(
            color: baseColor,
            fontSize: 64.0,
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
    );
  }
}
