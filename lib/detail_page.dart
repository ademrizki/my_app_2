import 'dart:io';

import 'package:flutter/material.dart';

class DetailWidget extends StatelessWidget {
  const DetailWidget({Key? key, this.imagePath, this.nama, this.tgl})
      : super(key: key);

  final String? imagePath;
  final String? nama;
  final String? tgl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, nama);
              },
              child: const Text('submit'),
            ),
          ],
        ),
      ),
    );
  }
}
