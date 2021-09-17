import 'package:flutter/material.dart';

class SearchMap extends StatefulWidget {
  const SearchMap({Key? key}) : super(key: key);

  @override
  _SearchMapState createState() => _SearchMapState();
}

class _SearchMapState extends State<SearchMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tim kiem vs map'),
      ),
      body: Center(
        child: Text('Map'),
      ),
    );
  }
}
