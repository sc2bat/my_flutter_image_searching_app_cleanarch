import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Image Search App',
        ),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                context.push('/home/search');
              },
              child: const Text('Search'),
            ),
            ElevatedButton(
              onPressed: () {
                context.push('/home/image');
              },
              child: const Text('Image'),
            ),
            ElevatedButton(
              onPressed: () {
                context.push('/home/user');
              },
              child: const Text('User'),
            ),
          ],
        ),
      ),
    );
  }
}
