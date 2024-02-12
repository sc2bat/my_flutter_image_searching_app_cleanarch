import 'package:flutter/material.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/common/theme.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/search/search_view_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';

class SearchTextFieldWidget extends StatefulWidget {
  const SearchTextFieldWidget({
    super.key,
    required this.searchViewModel,
  });

  final SearchViewModel searchViewModel;
  // final TextEditingController _serachTextFieldController;
  // final FocusNode _focusNode;

  @override
  State<SearchTextFieldWidget> createState() => _SearchTextFieldWidgetState();
}

class _SearchTextFieldWidgetState extends State<SearchTextFieldWidget> {
  // final bool _isTextFieldFocused = false;
  List<String> searchHistories = [];
  final _serachTextFieldController = TextEditingController();
  final _focusNode = FocusNode();
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    widget.searchViewModel.getSearchHistories();
    searchHistories = widget.searchViewModel.getSearchState.searchHistories;
    _focusNode.addListener(_onFocusChange);
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _overlayEntry?.remove();
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

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      _createOverlay(context);
    } else {
      _removeOverlay();
    }
  }

  void _createOverlay(BuildContext context) {
    logger.info(searchHistories);
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => Positioned(
        top: 160.0,
        left: 20.0,
        right: 20.0,
        child: Material(
          elevation: 4.0,
          child: Container(
            padding: const EdgeInsets.all(10.0),
            color: Colors.white,
            child: Column(
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
                            _serachTextFieldController.clear();
                            _serachTextFieldController.text =
                                searchHistories[index];
                            widget.searchViewModel
                                .getPhotos(_serachTextFieldController.text);
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
                          // _removeSearchHistories(searchHistories[index]);
                          // setState(() {
                          //   searchHistories.removeAt(index);
                          // });
                        },
                        icon: const Icon(
                          Icons.clear,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // : Container(),
            // const Text(
            //   'Overlay is visible when TextField is focused',
            //   style: TextStyle(fontSize: 16.0),
            // ),
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
    return TextField(
      controller: _serachTextFieldController,
      focusNode: _focusNode,
      onTap: () {},
      onSubmitted: (value) {
        if (_textFieldValid(value)) {
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
                onPressed: () {
                  _serachTextFieldController.clear();
                  logger.info(
                      '_serachTextFieldController.text.isNotEmpty ${_serachTextFieldController.text.isNotEmpty}');
                },
                icon: const Icon(
                  Icons.clear,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                if (_textFieldValid(_serachTextFieldController.text)) {
                  widget.searchViewModel
                      .addSearchHistories(_serachTextFieldController.text);

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
    );
    //  Column(
    //   children: [
    //     TextField(
    //       controller: widget._serachTextFieldController,
    //       onTap: () {
    //         setState(() {
    //           _isTextFieldFocused = true;
    //         });
    //       },
    //       onSubmitted: (value) {
    //         if (_textFieldValid(value)) {
    //           _addSearchHistories(value);
    //           setState(() {});
    //           widget.searchViewModel.getPhotos(value);
    //         }
    //       },
    //       decoration: InputDecoration(
    //         hintText: 'image search',
    //         focusColor: baseColor,
    //         suffixIconColor: weakBlack,
    //         enabledBorder: OutlineInputBorder(
    //           borderRadius: BorderRadius.circular(10.0),
    //           borderSide: BorderSide(
    //             color: weakBlack,
    //             width: 1.0,
    //           ),
    //         ),
    //         focusedBorder: OutlineInputBorder(
    //           borderRadius: BorderRadius.circular(10.0),
    //           borderSide: const BorderSide(
    //             color: baseColor,
    //             width: 2.0,
    //           ),
    //         ),
    //         suffixIcon: Row(
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             _showClearButton
    //                 ? IconButton(
    //                     onPressed: () {
    //                       widget._serachTextFieldController.clear();
    //                     },
    //                     icon: const Icon(
    //                       Icons.clear,
    //                     ),
    //                   )
    //                 : const SizedBox(
    //                     width: 24.0,
    //                   ),
    //             IconButton(
    //               onPressed: () {
    //                 if (_textFieldValid(
    //                     widget._serachTextFieldController.text)) {
    //                   _addSearchHistories(
    //                       widget._serachTextFieldController.text);
    //                   setState(() {});
    //                   widget.searchViewModel
    //                       .getPhotos(widget._serachTextFieldController.text);
    //                 }
    //               },
    //               icon: const Icon(
    //                 Icons.search,
    //               ),
    //             ),
    //             const SizedBox(
    //               width: 16.0,
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //     _isTextFieldFocused
    //         ? Column(
    //             children: List.generate(
    //               searchHistories.length,
    //               (index) => Container(
    //                 height: 56.0,
    //                 padding: const EdgeInsets.all(8.0),
    //                 decoration: BoxDecoration(
    //                   border: const Border(
    //                     left: BorderSide(
    //                       color: baseColor,
    //                       width: 2.0,
    //                     ),
    //                     right: BorderSide(
    //                       color: baseColor,
    //                       width: 2.0,
    //                     ),
    //                     bottom: BorderSide(
    //                       color: baseColor,
    //                       width: 2.0,
    //                     ),
    //                   ),
    //                   borderRadius: searchHistories.length == index + 1
    //                       ? const BorderRadius.only(
    //                           bottomLeft: Radius.circular(10.0),
    //                           bottomRight: Radius.circular(10.0),
    //                         )
    //                       : null,
    //                 ),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Expanded(
    //                       child: GestureDetector(
    //                         onTap: () {
    //                           widget._serachTextFieldController.clear();
    //                           widget._serachTextFieldController.text =
    //                               searchHistories[index];
    //                           widget.searchViewModel.getPhotos(
    //                               widget._serachTextFieldController.text);
    //                         },
    //                         child: Text(
    //                           searchHistories[index],
    //                           style: const TextStyle(
    //                             fontSize: 18.0,
    //                           ),
    //                           overflow: TextOverflow.ellipsis,
    //                           maxLines: 1,
    //                         ),
    //                       ),
    //                     ),
    //                     IconButton(
    //                       onPressed: () {
    //                         _removeSearchHistories(searchHistories[index]);
    //                         setState(() {
    //                           searchHistories.removeAt(index);
    //                         });
    //                       },
    //                       icon: const Icon(
    //                         Icons.clear,
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           )
    //         : Container(),
    //   ],
    // );
  }
}
