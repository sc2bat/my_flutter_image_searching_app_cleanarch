import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/common/theme.dart';

class CommentBoxWidget extends StatefulWidget {
  const CommentBoxWidget({
    super.key,
    required this.insertCommentFunction,
  });
  final Function(List<String> message) insertCommentFunction;

  @override
  State<CommentBoxWidget> createState() => _CommentBoxWidgetState();
}

class _CommentBoxWidgetState extends State<CommentBoxWidget> {
  late TextEditingController _commentTextFieldContoller;

  @override
  void initState() {
    _commentTextFieldContoller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _commentTextFieldContoller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // ModalTitleWidget(title: 'post comment'.toUpperCase()),
              SizedBox(
                height: 128.0,
                child: TextField(
                  controller: _commentTextFieldContoller,
                  maxLines: null,
                  expands: true,
                  maxLength: 140,
                  decoration: InputDecoration(
                    hintText: 'Write Comment',
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
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.pop();
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width * 0.38,
                          MediaQuery.of(context).size.height * 0.06),
                      backgroundColor: whiteColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      side: const BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      widget.insertCommentFunction(
                          _commentTextFieldContoller.text.split('\n'));
                      context.pop();
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width * 0.38,
                          MediaQuery.of(context).size.height * 0.06),
                      backgroundColor: baseColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text(
                      'Comment',
                      style: TextStyle(
                        color: whiteColor,
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
