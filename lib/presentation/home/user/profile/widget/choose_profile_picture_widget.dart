import 'package:flutter/material.dart';

class ChooseProfilePictureWidget extends StatefulWidget {
  const ChooseProfilePictureWidget({super.key});

  @override
  State<ChooseProfilePictureWidget> createState() =>
      _ChooseProfilePictureWidgetState();
}

class _ChooseProfilePictureWidgetState
    extends State<ChooseProfilePictureWidget> {
  TextEditingController usernameController = TextEditingController(
      text: 'username');
  TextEditingController userBioController = TextEditingController(text: 'userbio');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button
          },
        ),
        title: Text('Edit Profile'),
      ),
      body: ListView(
        children: <Widget>[
          _buildProfileImage(),
          _buildTextField(label: 'Username', controller: usernameController),
          _buildTextField(label: 'Bio', controller: userBioController, maxLines: 3),
          _buildPhotoOptions(),
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: <Widget>[
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
              'userPicture'
            ),
          ),
          FloatingActionButton(
            mini: true,
            onPressed: () {
              // Handle edit picture
            },
            child: Icon(Icons.edit),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      {required String label, required TextEditingController controller, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildPhotoOptions() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.photo_library),
            title: Text('Choose from library'),
            onTap: () {
              // Handle choose from library
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Choose from Likes'),
            onTap: () {
              // Handle choose from library
            },
          ),
          ListTile(
            leading: Icon(Icons.mode_edit_outlined),
            title: Text('Edit avatar'),
            onTap: () {
              // Handle take photo
            },
          ),
          ListTile(
            leading: Icon(Icons.delete),
            title: Text('Remove current picture'),
            onTap: () {
              // Handle remove current picture
            },
          ),
        ],
      ),
    );
  }
}
