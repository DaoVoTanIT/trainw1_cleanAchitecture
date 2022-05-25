import 'package:clean_achitecture/Theme/color.dart';
import 'package:clean_achitecture/features/room/data/datasource/RoomAPI.dart';
import 'package:clean_achitecture/features/room/data/model/RoomModel.dart';
import 'package:clean_achitecture/features/room/presentation/widget/item_card.dart';
import 'package:clean_achitecture/routes/route_name.dart';
import 'package:clean_achitecture/style/styleAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RoomPage extends StatefulWidget {
  @override
  _RoomPageState createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  int selectedPosition = 0;
  List<RoomModel> listRoom = [];
  RoomAPI roomAPI = RoomAPI();
  TextEditingController searchTextController = new TextEditingController();
  List<RoomModel> listRoomSearch = [];

  final items = [
    'Quận 1',
    'Quận 2',
    'Quận 3',
    'Quận 4',
    'Quận 5',
    'Quận 6',
    'Quận 7',
    'Quận 8',
    'Quận 9',
    'Quận 10',
    'Quận 11',
    'Quận 12',
  ];
  getListRoom() async {
    listRoom = await roomAPI.getListRoom();
    setState(() {});
  }

  onSearch(String search) {
    setState(() {
      listRoomSearch = listRoom
          .where((element) => element.areaName!.toLowerCase().contains(search))
          .toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getListRoom();
    setState(() {
      listRoomSearch = listRoom;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: CupertinoColors.systemGrey,
        navigationBar: CupertinoNavigationBar(
          leading: Row(
            children: [
              GestureDetector(
                child: Row(
                  children: [
                    Icon(
                      CupertinoIcons.back,
                      color: CupertinoColors.activeBlue,
                      size: 25,
                    ),
                    Text(
                      "Danh mục",
                      style: TextStyle(
                          color: CupertinoColors.activeBlue, fontSize: 16),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          middle: Text(
            "Chi tiết",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        child: Scaffold(
            body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Row(
                  children: [
                    Icon(
                      CupertinoIcons.placemark,
                      size: 25,
                      color: Colors.black,
                    ),
                    Text('Khu vực: ',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        )),
                    Spacer(),
                    Container(
                      width: 200,
                      child: CupertinoTextField(
                        keyboardType: TextInputType.text,
                        maxLength: 10,
                        onChanged: (value) {
                          onSearch(value);
                        },
                        textInputAction: TextInputAction.send,
                      ),
                    )
                    // Align(
                    //     alignment: Alignment.bottomCenter,
                    //     child: Container(
                    //         padding: EdgeInsets.all(10.0),
                    //         height: 60,
                    //         width: double.infinity,
                    //         color: Colors.white,

                    //         child: CupertinoTextField(
                    //           controller: searchTextController,
                    //           placeholder: "task",
                    //           textInputAction: TextInputAction.send,
                    //           suffix: GestureDetector(
                    //             onTap: () async {},
                    //           ),
                    //         )))
                  ],
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: listRoom.length,
                        scrollDirection: Axis.vertical,
                        addRepaintBoundaries: false,
                        physics: PageScrollPhysics(),
                        itemBuilder: (context, index) => ItemCard(
                              room: listRoom[index],
                            )))
              ])),
        )));
  }
}
