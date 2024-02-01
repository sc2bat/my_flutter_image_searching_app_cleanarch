import 'package:flutter/material.dart';
import 'package:my_flutter_image_searching_app_cleanarch/logger/simple_logger.dart';

class SearchTextFieldWidget extends StatelessWidget {
  const SearchTextFieldWidget({
    super.key,
    required TextEditingController searchTextController,
  }) : _searchTextController = searchTextController;

  final TextEditingController _searchTextController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchTextController,
      onSubmitted: (value) {
        logger.info(value);
      },
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            logger.info(_searchTextController.text);
          },
          icon: const Icon(
            Icons.search_rounded,
            color: Colors.grey,
          ),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              10.0,
            ),
          ),
        ),
      ),
    );
  }
}
