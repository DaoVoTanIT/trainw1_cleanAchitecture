import 'package:flutter/material.dart';

class SavedRoom extends StatefulWidget {
  const SavedRoom({Key? key}) : super(key: key);

  @override
  _SavedRoomState createState() => _SavedRoomState();
}

class _SavedRoomState extends State<SavedRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Phong da luu'),
        ),
        body: Center(
          child: Text('Phong da luu'),
        ));
  }
}
