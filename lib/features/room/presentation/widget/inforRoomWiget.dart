import 'package:flutter/material.dart';

import 'package:clean_achitecture/features/account/presentation/model/inforRoom.dart';

// ignore: must_be_immutable
class InforRoomWiget extends StatelessWidget {
  InforRoom inforRoom;
  InforRoomWiget({
    Key? key,
    required this.inforRoom,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Image.network(inforRoom.imageUrl),
      ],
    ));
  }
}
