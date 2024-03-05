// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/common/theme.dart';

class CommonTextFieldWidget extends StatefulWidget {
  const CommonTextFieldWidget({
    super.key,
    required TextEditingController searchTextFieldController,
  }) : _searchTextFieldController = searchTextFieldController;

  final TextEditingController _searchTextFieldController;

  @override
  State<CommonTextFieldWidget> createState() => _CommonTextFieldWidgetState();
}

class _CommonTextFieldWidgetState extends State<CommonTextFieldWidget> {
  bool _showClearButton = false;
  @override
  void initState() {
    widget._searchTextFieldController.addListener(() {
      setState(() {
        _showClearButton = widget._searchTextFieldController.text.isNotEmpty;
      });
    });
    super.initState();
  }

  void _textFieldValid(String searchKeyword) {
    if (searchKeyword.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('please enter search Keyword'),
        ),
      );
      return;
    } else {
      context.push('/search', extra: {'searchKeyword': searchKeyword});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: widget._searchTextFieldController,
          onSubmitted: (value) {
            _textFieldValid(value);
          },
          onTap: () {},
          decoration: InputDecoration(
            hintText: 'Search image',
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
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: baseColor,
                width: 2.0,
              ),
            ),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  visible: widget._searchTextFieldController.text.isNotEmpty,
                  child: IconButton(
                    onPressed: widget._searchTextFieldController.clear,
                    icon: const Icon(
                      Icons.clear,
                    ),
                  ),
                ),
                // _showClearButton
                //     ? IconButton(
                //         onPressed: () {
                //           widget._searchTextFieldController.clear();
                //         },
                //         icon: const Icon(
                //           Icons.clear,
                //         ),
                //       )
                //     : const SizedBox(
                //         width: 24.0,
                //       ),
                IconButton(
                  onPressed: () {
                    _textFieldValid(widget._searchTextFieldController.text);
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
      ],
    );
  }
}
