import 'package:clean_achitecture/features/room/model/RoomModel.dart';
import 'package:clean_achitecture/features/room/presentation/page/DetailRoomPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final RoomModel room;
  const ItemCard({
    Key? key,
    required this.room,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          // Navigator.pushNamed(context, RouteName.detailRoomPage,
          //     arguments: {room.toJson()});
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DetailRoomPage(),
              settings: RouteSettings(
                arguments: room,
              ),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 1,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                children: [
                  Image.network(
                    room.imageMain.toString(),
                    fit: BoxFit.cover,
                    height: 120,
                    width: 120,
                  ),
                ],
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(room.subject.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          // color: Colors.black,
                        )),
                    SizedBox(height: 10),
                    Text('${room.size} m2',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        )),
                    SizedBox(height: 7),
                    Text(room.priceString.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        )),
                    SizedBox(height: 7),
                    Row(
                      children: [
                        Row(
                          children: [
                            Icon(
                              CupertinoIcons.placemark,
                              size: 20,
                              color: Colors.grey,
                            ),
                            Text(room.areaName.toString(),
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                ))
                          ],
                        ),
                        Spacer(),
                        GestureDetector(
                          child: Icon(
                            CupertinoIcons.heart,
                            color: CupertinoColors.systemRed,
                            size: 25,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
