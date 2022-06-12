import 'package:clean_achitecture/Theme/color.dart';
import 'package:clean_achitecture/features/room/data/RoomAPI.dart';
import 'package:clean_achitecture/features/room/model/RoomModel.dart';
import 'package:clean_achitecture/features/room/presentation/page/FilterRoom.dart';

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
  List<RoomModel> listRoomFilter = [];

  RoomAPI roomAPI = RoomAPI();
  TextEditingController searchTextController = new TextEditingController();
  List<RoomModel> listRoomSearch = [];
  String? buldingChoose;
  final items = [
    'Tất cả',
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

  filterByArea() {
    listRoomFilter = listRoom
        .where((element) => element.areaName!
            .toUpperCase()
            .contains(buldingChoose!.toUpperCase()))
        .toList();
    setState(() {
      // ignore: unrelated_type_equality_checks
      if (listRoomFilter != 0) {
        listRoom = listRoomFilter;
      }
    });
  }

  Future _refreshData() async {
    await Future.delayed(Duration(seconds: 3));
    listRoom.clear();
    getListRoom();

    setState(() {});
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
        backgroundColor: appBgColor,
        navigationBar: CupertinoNavigationBar(
          leading: Row(
            children: [
              GestureDetector(
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/logo.png",
                      fit: BoxFit.fill,
                      color: CupertinoColors.activeBlue,
                    )
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
          trailing: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FliterScreen(),
                    settings: RouteSettings(
                      arguments: listRoom,
                    ),
                  ),
                ).then((value) => {
                      if (value != null)
                        {
                          setState(() {
                            listRoom = value;
                          })
                        }
                      else
                        {getListRoom()}
                    });
              },
              child: Icon(
                Icons.filter_alt_outlined,
                size: 26,
                color: CupertinoColors.activeBlue,
              )),
        ),
        child: Scaffold(
            backgroundColor: appBgColor,
            body: RefreshIndicator(
              onRefresh: _refreshData,
              backgroundColor: Colors.blue,
              color: Colors.white,
              displacement: 200,
              strokeWidth: 5,
              child: SafeArea(
                child: SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Column(children: [
                    Stack(children: [
                      Container(
                        height: MediaQuery.of(context).size.width * 0.5,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/room2.jpeg'),
                            fit: BoxFit.cover,
                          ),
                          shape: BoxShape.rectangle,
                        ),
                      ),
                      Positioned(
                        bottom: 55.0,
                        right: -20.0,
                        left: -40.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0.0, 4.0),
                                    color: Color(0xffe8f2ff),
                                    blurRadius: 24.0,
                                  ),
                                ],
                              ),
                              child: FormField<String>(
                                builder: (FormFieldState<String> state) {
                                  return InputDecorator(
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          12, 13, 20, 20),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        onTap: () {},
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: CupertinoColors.black,
                                          fontFamily: "verdana_regular",
                                        ),
                                        hint: const Text(
                                          "Bạn muốn tìm phòng trọ?",
                                          style: TextStyle(
                                            color: CupertinoColors.systemGrey,
                                            fontSize: 16,
                                            fontFamily: "verdana_regular",
                                          ),
                                        ),
                                        value: buldingChoose,
                                        isExpanded: true,
                                        isDense: true,
                                        onChanged: (newValue) {
                                          // Future.delayed(Duration.zero, () {
                                          //   getListRoom();
                                          // });
                                          setState(() {
                                            buldingChoose = newValue;
                                          });
                                        },
                                        items: items
                                            .map<DropdownMenuItem<String>>(
                                                (valueItem) {
                                          return DropdownMenuItem(
                                            value: valueItem,
                                            child: Row(
                                              children: [
                                                Text(valueItem),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: Color(0xFFE85B00),
                                  shape: BoxShape.circle),
                              child: IconButton(
                                onPressed: () {
                                  if (buldingChoose != null) {
                                    filterByArea();
                                  }
                                },
                                icon: Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ]),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, left: 10, right: 10),
                      child: listRoom.length == 0
                          ? Container()
                          : ListView.builder(
                              itemCount: listRoom.length,
                              //scrollDirection: Axis.vertical,
                              addRepaintBoundaries: false,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => ItemCard(
                                    room: listRoom[index],
                                  )),
                    )
                  ]),
                ),
              ),
            )));
  }
}
