import 'package:flutter/material.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/common/theme.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/search/search_view_model.dart';

class SearchTextFieldWidget extends StatefulWidget {
  const SearchTextFieldWidget({
    super.key,
    required this.searchViewModel,
  });

  final SearchViewModel searchViewModel;

  @override
  State<SearchTextFieldWidget> createState() => _SearchTextFieldWidgetState();
}

class _SearchTextFieldWidgetState extends State<SearchTextFieldWidget> {
  final _serachTextFieldController = TextEditingController();
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    widget.searchViewModel.getSearchHistories();
    super.initState();
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    _serachTextFieldController.dispose();
    super.dispose();
  }

  bool _textFieldValid(String searchKeyword) {
    if (searchKeyword.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('please enter search Keyword'),
        ),
      );
      return false;
    }
    return true;
  }

  void _createOverlay(BuildContext context, List<String> searchHistories) {
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => Positioned(
        top: 140.0,
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
                                            _serachTextFieldController.clear();
                                            _serachTextFieldController.text =
                                                searchHistories[reversedIndex];
                                            widget.searchViewModel
                                                .addSearchHistories(
                                                    _serachTextFieldController
                                                        .text);
                                            widget.searchViewModel.getPhotos(
                                                _serachTextFieldController
                                                    .text);
                                            _removeOverlay();
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
                                          _removeOverlay();
                                          _createOverlay(
                                              context,
                                              widget
                                                  .searchViewModel
                                                  .getSearchState
                                                  .searchHistories);
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
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16.0),
                      bottomRight: Radius.circular(16.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // toggle button save setting
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            const Text('save option'),
                            ElevatedButton(
                              onPressed: () {},
                              child: const Text('toggle'),
                            ),
                          ],
                        ),
                      ),
                      // 닫기
                      Row(
                        children: [
                          const Text('close'),
                          IconButton(
                            onPressed: () {
                              _removeOverlay();
                            },
                            icon: const Icon(
                              Icons.close_rounded,
                            ),
                          ),
                        ],
                      ),
                    ],
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

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          TextField(
            controller: _serachTextFieldController,
            onTap: () {},
            onSubmitted: (value) {
              if (_textFieldValid(value)) {
                _removeOverlay();
                widget.searchViewModel.addSearchHistories(value);
                widget.searchViewModel.getPhotos(value);
              }
            },
            decoration: InputDecoration(
              hintText: 'image search',
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
                    visible: _serachTextFieldController.text.isNotEmpty,
                    child: IconButton(
                      onPressed: _serachTextFieldController.clear,
                      icon: const Icon(
                        Icons.clear,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (_textFieldValid(_serachTextFieldController.text)) {
                        _removeOverlay();
                        widget.searchViewModel.addSearchHistories(
                            _serachTextFieldController.text);

                        widget.searchViewModel
                            .getPhotos(_serachTextFieldController.text);
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
              _createOverlay(context,
                  widget.searchViewModel.getSearchState.searchHistories);
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
