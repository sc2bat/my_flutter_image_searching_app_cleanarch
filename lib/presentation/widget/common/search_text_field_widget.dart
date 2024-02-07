// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/common/theme.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';

class SearchTextFieldWidget extends StatefulWidget {
  const SearchTextFieldWidget({
    super.key,
    required TextEditingController serachTextFieldController,
  }) : _serachTextFieldController = serachTextFieldController;

  final TextEditingController _serachTextFieldController;

  @override
  State<SearchTextFieldWidget> createState() => _SearchTextFieldWidgetState();
}

class _SearchTextFieldWidgetState extends State<SearchTextFieldWidget> {
  bool _showClearButton = false;
  bool _isTextFieldFocused = false;
  List<String> searchHistories = [
    'flower',
    'apple',
    'banana',
    'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
  ];
  @override
  void initState() {
    widget._serachTextFieldController.addListener(() {
      setState(() {
        _showClearButton = widget._serachTextFieldController.text.isNotEmpty;
      });
    });
    super.initState();
  }

  void searchImage(String searchString) {}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: widget._serachTextFieldController,
          onSubmitted: (value) {
            context.push('/search', extra: {'searchString': value});
          },
          onTap: () {
            setState(() {
              _isTextFieldFocused = true;
            });
          },
          decoration: InputDecoration(
            hintText: 'image search',
            focusColor: baseColor,
            suffixIconColor: weakBlack,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: weakBlack,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: searchHistories.isNotEmpty & _isTextFieldFocused
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    )
                  : BorderRadius.circular(10),
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
                    context.push('/search', extra: {
                      'searchString': widget._serachTextFieldController.text
                    });
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
                          child: Text(
                            searchHistories[index],
                            style: const TextStyle(
                              fontSize: 18.0,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              searchHistories.removeAt(index);
                              logger.info(searchHistories);
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
