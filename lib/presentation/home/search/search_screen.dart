import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/like/like_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/common/theme.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/search/search_state.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/search/search_view_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/widget/common/sign_elevated_button_widget.dart';
import 'package:provider/provider.dart';

import '../../widget/common/title_logo_widget.dart';
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
    final SearchState searchState = searchViewModel.searchState;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const TitleLogoWidget(),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: SignElevatedButtonWidget(),
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: _searchTextController,
              onTap: () {},
              onSubmitted: (value) {
                if (searchViewModel.textFieldValid(value)) {
                  searchViewModel.getPhotos(value);
                }
              },
              decoration: InputDecoration(
                hintText: 'Search image',
                focusColor: baseColor,
                suffixIconColor: weakBlack,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: weakBlack,
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: baseColor,
                    width: 2.0,
                  ),
                ),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Visibility(
                      visible: _searchTextController.text.isNotEmpty,
                      child: IconButton(
                        onPressed: () {
                          _searchTextController.clear();
                        },
                        icon: const Icon(
                          Icons.clear,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (searchViewModel
                            .textFieldValid(_searchTextController.text)) {
                          searchViewModel
                              .addSearchHistories(_searchTextController.text);

                          searchViewModel.getPhotos(_searchTextController.text);
                        }
                      },
                      icon: const Icon(
                        Icons.search,
                      ),
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                  ],
                ),
              ),
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
                      LikeModel? likeModel =
                          searchViewModel.getLikeModelByImageId(
                              searchState.photos[index].imageId);
                      return SearchImageContainerWidget(
                        photo: searchState.photos[index],
                        likeModel: likeModel,
                        likeUpdateFunction: (likeModel) =>
                            searchViewModel.updateLike(likeModel),
                        // tapLike : ()=>searchViewModel.tapLike
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
