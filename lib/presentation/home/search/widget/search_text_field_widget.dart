import 'package:flutter/material.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/common/theme.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/search/search_view_model.dart';

class SearchTextFieldWidget extends StatefulWidget {
  const SearchTextFieldWidget({
    super.key,
    required TextEditingController searchTextFieldController,
    required this.searchViewModel,
  }) : _serachTextFieldController = searchTextFieldController;

  final TextEditingController _serachTextFieldController;
  final SearchViewModel searchViewModel;

  @override
  State<SearchTextFieldWidget> createState() => _SearchTextFieldWidgetState();
}

class _SearchTextFieldWidgetState extends State<SearchTextFieldWidget> {
  bool _showClearButton = false;
  bool _isTextFieldFocused = false;
  List<String> searchHistories = [];

  Future<void> _getSearchHistories() async {
    searchHistories = await widget.searchViewModel.getSearchHistories();
  }

  Future<void> _addSearchHistories(String keyword) async {
    await widget.searchViewModel.addSearchHistories(keyword);
    _getSearchHistories();
  }

  Future<void> _removeSearchHistories(String keyword) async {
    await widget.searchViewModel.removeSearchHistories(keyword);
    _getSearchHistories();
  }

  @override
  void initState() {
    widget._serachTextFieldController.addListener(() {
      setState(() {
        _showClearButton = widget._serachTextFieldController.text.isNotEmpty;
      });
    });
    _getSearchHistories();

    super.initState();
  }

  bool _textFieldValid(String searchKeyword) {
    if (searchKeyword.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('please enter search Keyword'),
        ),
      );
      return false;
    } else {}
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: widget._serachTextFieldController,
          onTap: () {
            setState(() {
              _isTextFieldFocused = true;
            });
          },
          onSubmitted: (value) {
            if (_textFieldValid(value)) {
              _addSearchHistories(value);
              setState(() {});
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
                _showClearButton
                    ? IconButton(
                        onPressed: () {
                          widget._serachTextFieldController.clear();
                        },
                        icon: const Icon(
                          Icons.clear,
                        ),
                      )
                    : const SizedBox(
                        width: 24.0,
                      ),
                IconButton(
                  onPressed: () {
                    if (_textFieldValid(
                        widget._serachTextFieldController.text)) {
                      _addSearchHistories(
                          widget._serachTextFieldController.text);
                      setState(() {});
                      widget.searchViewModel
                          .getPhotos(widget._serachTextFieldController.text);
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
        _isTextFieldFocused
            ? Column(
                children: List.generate(
                  searchHistories.length,
                  (index) => Container(
                    height: 56.0,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: const Border(
                        left: BorderSide(
                          color: baseColor,
                          width: 2.0,
                        ),
                        right: BorderSide(
                          color: baseColor,
                          width: 2.0,
                        ),
                        bottom: BorderSide(
                          color: baseColor,
                          width: 2.0,
                        ),
                      ),
                      borderRadius: searchHistories.length == index + 1
                          ? const BorderRadius.only(
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0),
                            )
                          : null,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              widget._serachTextFieldController.clear();
                              widget._serachTextFieldController.text =
                                  searchHistories[index];
                              widget.searchViewModel.getPhotos(
                                  widget._serachTextFieldController.text);
                            },
                            child: Text(
                              searchHistories[index],
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
                            _removeSearchHistories(searchHistories[index]);
                            setState(() {
                              searchHistories.removeAt(index);
                            });
                          },
                          icon: const Icon(
                            Icons.clear,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
