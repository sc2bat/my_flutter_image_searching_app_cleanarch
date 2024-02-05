import 'package:flutter/material.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/search/search_view_model.dart';
import 'package:provider/provider.dart';

class SearchTextFieldWidget extends StatelessWidget {
  const SearchTextFieldWidget({
    super.key,
    required TextEditingController searchTextController,
  }) : _searchTextController = searchTextController;

  final TextEditingController _searchTextController;

  @override
  Widget build(BuildContext context) {
    final SearchViewModel searchViewModel = context.watch();

    return TextField(
      controller: _searchTextController,
      onSubmitted: (value) {
        searchViewModel.getPhotos(value);
      },
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            searchViewModel.getPhotos(_searchTextController.text);
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
