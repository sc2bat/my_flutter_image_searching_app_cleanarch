import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserNameScreen extends StatefulWidget {
  final String currentUserName;
  const UserNameScreen({super.key, required this.currentUserName});

  @override
  _UserNameScreenState createState() => _UserNameScreenState();
}

class _UserNameScreenState extends State<UserNameScreen> {
  final _userNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _userNameController.text = widget.currentUserName;
  }

  @override
  void dispose() {
    _userNameController.dispose();
    super.dispose();
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Discard changes?'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('If you go back now, you will lose your changes.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Discard changes'),
              onPressed: () {
                context.push('/home/user/profile');
              },
            ),
            TextButton(
              child: const Text('Keep editing'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              _showMyDialog();
            },
          ),
          title: const Text('Username'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // TODO: 저장
                context.push('/home/user/profile');
              },
              child: const Text(
                'Save',
                style: TextStyle(
                  color: Colors.blueAccent,
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _userNameController,
                decoration: InputDecoration(
                  // TODO: 기존 username
                  labelText: 'sampleName',
                  suffixIcon: IconButton(
                    onPressed: () => _userNameController.clear(),
                    icon: const Icon(Icons.clear),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}
