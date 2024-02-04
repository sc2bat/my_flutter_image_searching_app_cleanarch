import 'package:flutter/material.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/search/search_state.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/search/search_view_model.dart';
import 'package:provider/provider.dart';

import 'widget/search_image_container_widget.dart';
import 'widget/search_text_field_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    super.key,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _searchTextController;

  @override
  void initState() {
    _searchTextController = TextEditingController();

    Future.microtask(() {
      // final SearchViewModel searchViewModel = context.read();

      // _searchTextController.addListener(() {
      //   searchViewModel.getPhotos(_searchTextController.text);
      // });
    });

    super.initState();
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SearchViewModel searchViewModel = context.watch();
    final SearchState searchState = searchViewModel.getSearchState;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'image searching app',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SearchTextFieldWidget(
              searchTextController: _searchTextController,
            ),
          ),
          Expanded(
            child: searchState.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(16.0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                      ),
                      itemCount: searchState.photos.length,
                      itemBuilder: (context, index) {
                        return SearchImageContainerWidget(
                            photo: searchState.photos[index]);
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
