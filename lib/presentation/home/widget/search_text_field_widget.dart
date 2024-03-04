import 'package:flutter/material.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/common/theme.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/search/search_view_model.dart';

class SearchTextFieldWidget extends StatefulWidget {
  const SearchTextFieldWidget({
    super.key,
    required this.searchTextController,
    required this.searchViewModel,
  });

  final TextEditingController searchTextController;
  final SearchViewModel searchViewModel;

  @override
  State<SearchTextFieldWidget> createState() => _SearchTextFieldWidgetState();
}

class _SearchTextFieldWidgetState extends State<SearchTextFieldWidget> {
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    widget.searchViewModel.getSearchHistories();
    super.initState();
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }

  void _createOverlay(BuildContext context, List<String> searchHistories) {
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => Positioned(
        top: MediaQuery.of(context).size.height * 0.154,
        left: 20.0,
        right: 20.0,
        child: Material(
          elevation: 4.0,
          borderRadius: BorderRadius.circular(16.0),
          child: Container(
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: weakBlack, width: 1.0),
                left: BorderSide(color: weakBlack, width: 1.0),
                right: BorderSide(color: weakBlack, width: 1.0),
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16.0),
                bottomRight: Radius.circular(16.0),
              ),
              color: Colors.white,
            ),
            child: Column(
              children: [
                SingleChildScrollView(
                  child: SizedBox(
                    height: searchHistories.isEmpty
                        ? 60.0
                        : searchHistories.length < 3
                            ? 24.0 + searchHistories.length * 60.0
                            : 180.0,
                    child: searchHistories.isNotEmpty
                        ? Scrollbar(
                            child: ListView.builder(
                              itemCount: searchHistories.length,
                              itemBuilder: (context, index) {
                                final reversedIndex =
                                    searchHistories.length - 1 - index;
                                return Container(
                                  height: 56.0,
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            widget.searchTextController.clear();
                                            widget.searchTextController.text =
                                                searchHistories[reversedIndex];
                                            widget.searchViewModel
                                                .addSearchHistories(widget
                                                    .searchTextController.text);
                                            widget.searchViewModel.getPhotos(
                                                widget
                                                    .searchTextController.text);
                                            removeOverlay();
                                          },
                                          child: Text(
                                            searchHistories[reversedIndex],
                                            style: const TextStyle(
                                              fontSize: 18.0,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          widget.searchViewModel
                                              .removeSearchHistories(
                                                  searchHistories[
                                                      reversedIndex]);
                                          removeOverlay();
                                          // _createOverlay(
                                          //     context,
                                          //     widget
                                          //         .searchViewModel
                                          //         .getSearchState
                                          //         .searchHistories);
                                        },
                                        icon: const Icon(
                                          Icons.clear,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        : Container(
                            height: 56.0,
                            padding: const EdgeInsets.all(16.0),
                            child: const Text(
                              'None',
                              style: TextStyle(
                                fontSize: 24.0,
                              ),
                            ),
                          ),
                  ),
                ),
                Container(
                  height: 28.0,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: weakBlack,
                        width: 0.4,
                      ),
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16.0),
                      bottomRight: Radius.circular(16.0),
                    ),
                  ),
                  child: Center(
                    child: IconButton(
                      onPressed: () {
                        removeOverlay();
                      },
                      icon: const Icon(
                        Icons.arrow_drop_up,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          TextField(
            controller: widget.searchTextController,
            onTap: () {},
            onSubmitted: (value) {
              if (widget.searchViewModel.textFieldValid(value)) {
                removeOverlay();
                widget.searchViewModel.addSearchHistories(value);
                widget.searchViewModel.getPhotos(value);
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
                    visible: widget.searchTextController.text.isNotEmpty,
                    child: IconButton(
                      onPressed: () {
                        widget.searchTextController.clear();
                        widget.searchViewModel.notifyListeners();
                      },
                      icon: const Icon(
                        Icons.clear,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (widget.searchViewModel
                          .textFieldValid(widget.searchTextController.text)) {
                        removeOverlay();
                        widget.searchViewModel.addSearchHistories(
                            widget.searchTextController.text);

                        widget.searchViewModel
                            .getPhotos(widget.searchTextController.text);
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
          GestureDetector(
            onTap: () {
              widget.searchViewModel.getSearchHistories();
              _createOverlay(
                  context, widget.searchViewModel.searchState.searchHistories);
            },
            child: const SizedBox(
              width: double.infinity,
              height: 24.0,
              child: Icon(
                Icons.arrow_drop_down,
                size: 24.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
