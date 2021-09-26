import 'package:clean_achitecture/features/room/domain/model/inforRoom.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final Room room;
  final Function() press;
  const ItemCard({
    Key? key,
    required this.room,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GestureDetector(
            onTap: press,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              // verticalDirection: VerticalDirection.down,
              children: <Widget>[
                Image.asset(
                  room.imageUrl,
                  fit: BoxFit.cover,
                  height: 100,
                  width: 100,
                ),
                new Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.add_location_outlined, color: Colors.blue),
                          new Text(room.address),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.home, color: Colors.blue),
                          new Text('DT ${room.area} m2'),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            )));
  }
}
