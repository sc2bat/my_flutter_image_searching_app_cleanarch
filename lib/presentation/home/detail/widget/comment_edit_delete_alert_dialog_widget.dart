import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/constants.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/comment/comment_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/common/theme.dart';

class CommentEditDeleteAlertDialogWidget extends StatefulWidget {
  const CommentEditDeleteAlertDialogWidget({
    super.key,
    required this.commentInfo,
    required this.editCommentFunction,
    required this.deleteCommentFunction,
  });

  final CommentModel commentInfo;
  final Function(int commmentId, List<String> content) editCommentFunction;
  final Function(int commmentId) deleteCommentFunction;

  @override
  State<CommentEditDeleteAlertDialogWidget> createState() =>
      _CommentEditDeleteAlertDialogWidgetState();
}

class _CommentEditDeleteAlertDialogWidgetState
    extends State<CommentEditDeleteAlertDialogWidget> {
  late TextEditingController _commentEditingController;

  @override
  void initState() {
    _commentEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _commentEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _commentEditingController.text = widget.commentInfo.content ?? '';
    return AlertDialog(
      title: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: Image.network(
              '$userProfileUrlWithFirstCharacter${widget.commentInfo.userName[0].toUpperCase()}',
              width: 48.0,
              height: 48.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
            child: Text(widget.commentInfo.userName),
          ),
        ],
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.25,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 128.0,
              child: TextField(
                controller: _commentEditingController,
                maxLines: null,
                expands: true,
                maxLength: 140,
                // readOnly: true,
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
                    widget.editCommentFunction(
                      widget.commentInfo.commentId,
                      _commentEditingController.text.split('\n'),
                    );
                    context.pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: editColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'Edit',
                    style: TextStyle(
                      color: whiteColor,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.deleteCommentFunction(widget.commentInfo.commentId);
                    context.pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: deleteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'Delete',
                    style: TextStyle(
                      color: whiteColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
