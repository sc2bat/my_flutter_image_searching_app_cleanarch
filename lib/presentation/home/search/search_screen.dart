import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/common/theme.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/search/search_state.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/search/search_view_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/widget/search_text_field_widget.dart';
import 'package:provider/provider.dart';

import 'widget/search_image_container_widget.dart';

class SearchScreen extends StatefulWidget {
  final String searchKeyword;
  const SearchScreen({
    super.key,
    required this.searchKeyword,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _searchTextController;
  // final _focusNode = FocusNode();

  StreamSubscription? _streamSubscription;

  @override
  void initState() {
    Future.microtask(() {
      final searchViewModel = context.read<SearchViewModel>();

      _streamSubscription =
          searchViewModel.getSearchUiEventStreamController.listen((event) {
        event.when(showSnackBar: (message) {
          final snackBar = SnackBar(
            content: Text(message),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      });

      if (widget.searchKeyword.isNotEmpty) {
        _searchTextController.text = widget.searchKeyword;
        searchViewModel.getPhotos(widget.searchKeyword);
        searchViewModel.addSearchHistories(widget.searchKeyword);
      }
    });

    _searchTextController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
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
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SearchTextFieldWidget(
              searchTextController: _searchTextController,
              searchViewModel: searchViewModel,
            ),
          ),
          searchState.isLoading
              ? const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
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
        ],
      ),
    );
  }
}
