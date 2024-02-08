import 'package:flutter/material.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/common/theme.dart';

class LongElevatedButtonWidget extends StatefulWidget {
  const LongElevatedButtonWidget({
    super.key,
  });

  @override
  State<LongElevatedButtonWidget> createState() =>
      _LongElevatedButtonWidgetState();
}

class _LongElevatedButtonWidgetState extends State<LongElevatedButtonWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: baseColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: const Text(
        'long button',
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: whiteColor,
        ),
      ),
    );
  }
}
