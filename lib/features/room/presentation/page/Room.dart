import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_achitecture/Theme/color.dart';
import 'package:clean_achitecture/features/Post/model/distric.dart';
import 'package:clean_achitecture/features/room/data/RoomAPI.dart';
import 'package:clean_achitecture/features/room/model/RoomModel.dart';
import 'package:clean_achitecture/features/room/presentation/page/DetailRoomPage.dart';
import 'package:clean_achitecture/features/room/presentation/page/FilterRoom.dart';

import 'package:clean_achitecture/features/room/presentation/widget/item_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoomPage extends StatefulWidget {
  @override
  _RoomPageState createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage>
    with AutomaticKeepAliveClientMixin {
  int selectedPosition = 0;
  List<RoomModel> listRoom = [];
  List<RoomModel> listRoomNearMe = [];
  List<RoomModel> listRoomFilter = [];

  RoomAPI roomAPI = RoomAPI();
  TextEditingController searchTextController = new TextEditingController();
  List<RoomModel> listRoomSearch = [];
  String? buldingChoose;
  List dataD = [];

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
  Future<String> getDataDistict() async {
    final assetBundle = DefaultAssetBundle.of(context);
    final data = await assetBundle.loadString('assets/json/district.json');
    final body = json.decode(data);
    setState(() {
      dataD = body;
    });
    return body.map<District>(District.fromJson).toList();
  }

  getListRoom() async {
    listRoom = await roomAPI.getListRoom();
    setState(() {
      listRoomNearMe =
          listRoom.where((element) => element.areaName == "Quận 9").toList();
    });
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

  // Future<void> getRoomNearMe() async {
  //   listRoomNearMe =
  //       listRoom.where((element) => element.areaName == "Quận 12").toList();
  // }

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
    getDataDistict();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => throw UnimplementedError();
  @override
  Widget build(BuildContext context) {
    // return CupertinoPageScaffold(
    //     backgroundColor: appBgColor,
    //     navigationBar: CupertinoNavigationBar(
    //       leading: Row(
    //         children: [
    //           GestureDetector(
    //             child: Row(
    //               children: [
    //                 Image.asset(
    //                   "assets/images/logo.png",
    //                   fit: BoxFit.fill,
    //                   color: CupertinoColors.activeBlue,
    //                 )
    //               ],
    //             ),
    //             onTap: () {
    //               Navigator.pop(context);
    //             },
    //           ),
    //         ],
    //       ),
    //       middle: Text(
    //         "Trang chủ",
    //         style: TextStyle(
    //           fontSize: 16,
    //         ),
    //       ),
    //       trailing: GestureDetector(
    //           onTap: () {
    //             Navigator.push(
    //               context,
    //               MaterialPageRoute(
    //                 builder: (context) => FliterScreen(),
    //                 settings: RouteSettings(
    //                   arguments: listRoom,
    //                 ),
    //               ),
    //             ).then((value) => {
    //                   if (value != null)
    //                     {
    //                       setState(() {
    //                         listRoom = value;
    //                       })
    //                     }
    //                   else
    //                     {getListRoom()}
    //                 });
    //           },
    //           child: Icon(
    //             Icons.filter_alt_outlined,
    //             size: 26,
    //             color: CupertinoColors.activeBlue,
    //           )),
    //     ),
    //     );

    return CupertinoPageScaffold(
      child: CustomScrollView(
        physics: NeverScrollableScrollPhysics(),
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            backgroundColor: appBarColor,
            border: Border(
              bottom: BorderSide(
                color: CupertinoColors.white,
              ),
            ),
            leading: GestureDetector(
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    fit: BoxFit.fill,
                    color: CupertinoColors.activeBlue,
                  )
                ],
              ),
              onTap: () {},
            ),
            trailing: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
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
                      size: 30,
                      color: CupertinoColors.activeBlue,
                    )),
                SizedBox(
                  width: 7,
                ),
                GestureDetector(
                    onTap: () {
                      showCupertinoModalPopup<void>(
                        context: context,
                        builder: (BuildContext context) => CupertinoActionSheet(
                          title: const Text('Sắp xếp giá phòng'),
                          // message: const Text('Message'),
                          actions: <CupertinoActionSheetAction>[
                            CupertinoActionSheetAction(
                              isDefaultAction: true,
                              onPressed: () {
                                listRoom.sort((a, b) =>
                                    b.price!.compareTo(a.price!.toInt()));
                                setState(() {});
                                Navigator.pop(context);
                              },
                              child: Text('Tăng dần'),
                            ),
                            CupertinoActionSheetAction(
                              isDefaultAction: true,
                              onPressed: () {
                                listRoom.sort((a, b) =>
                                    a.price!.compareTo(b.price!.toInt()));
                                setState(() {});
                                Navigator.pop(context);
                              },
                              child: Text('Giảm dần'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Icon(
                      CupertinoIcons.sort_down_circle_fill,
                      size: 30,
                      color: CupertinoColors.activeBlue,
                    )),
              ],
            ),

            // middle: const Text('Contacts Group'),
            largeTitle: const Text('Trang chủ'),
          ),
          SliverFillRemaining(child: buildBody()),
        ],
      ),
    );
  }

  Widget buildBody() {
    return Scaffold(
        backgroundColor: appBgColor,
        body: RefreshIndicator(
          onRefresh: _refreshData,
          backgroundColor: CupertinoColors.white,
          color: CupertinoColors.activeBlue,
          displacement: 200,
          strokeWidth: 5,
          child: SafeArea(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
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
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(12, 13, 20, 20),
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
                                      filterByArea();
                                    },
                                    // items: items.map<DropdownMenuItem<String>>(
                                    //     (valueItem) {
                                    //   return DropdownMenuItem(
                                    //     value: valueItem,
                                    //     child: Row(
                                    //       children: [
                                    //         Text(valueItem),
                                    //       ],
                                    //     ),
                                    //   );
                                    // }).toList(),
                                    items: dataD.map((item) {
                                      return new DropdownMenuItem(
                                        child:
                                            new Text(item['name'].toString()),
                                        value: item['name'].toString(),
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
                              color: CupertinoColors.activeBlue,
                              shape: BoxShape.circle),
                          child: IconButton(
                            onPressed: () {
                              // if (buldingChoose != null) {
                              //   listRoomFilter = listRoom
                              //       .where((element) =>
                              //           element.areaName! ==
                              //           buldingChoose.toString())
                              //       .toList();
                              //   setState(() {
                              //     // ignore: unrelated_type_equality_checks
                              //     if (listRoomFilter != 0) {
                              //       listRoom = listRoomFilter;
                              //     }
                              //   });
                              // }
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
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 15, 0),
                    child: Text(
                      'Xung quanh bạn',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF012169)),
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      height: 230,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.50,
                          mainAxisSpacing: 0,
                          crossAxisSpacing: 0,
                        ),
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.zero,
                        itemCount: listRoomNearMe.length,
                        itemBuilder: (context, i) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const DetailRoomPage(),
                                  settings: RouteSettings(
                                    arguments: listRoomNearMe[i],
                                  ),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // ClipRRect(
                                //   borderRadius: BorderRadius.circular(10.0),
                                //   child: Image.network(
                                //     listRoomNearMe[i].imageMain.toString(),
                                //     height: 70,
                                //     width: 70,
                                //     fit: BoxFit.cover,
                                //   ),
                                // ),
                                CachedNetworkImage(
                                  imageUrl:
                                      listRoomNearMe[i].imageMain.toString(),
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Container(
                                    width: 150,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          listRoomNearMe[i].subject.toString(),
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              height: 1.5),
                                        ),
                                        Text(
                                          listRoomNearMe[i].wardName.toString(),
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              height: 1.5),
                                        ),
                                        // Text("${title[index]['time']} Hour drive")
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ))
                ]),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 15, 0),
                      child: Text(
                        'Dành cho bạn',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF012169)),
                      ),
                    ),
                    // GestureDetector(
                    //     child: Icon(CupertinoIcons.qrcode),
                    //     onTap: () {
                    //       Padding(
                    //           padding: const EdgeInsets.only(
                    //               top: 20.0, left: 10, right: 10),
                    //           child: listRoom.length == 0
                    //               ? Container()
                    //               : ListView.builder(
                    //                   itemCount: listRoom.length,
                    //                   //scrollDirection: Axis.vertical,
                    //                   addRepaintBoundaries: false,
                    //                   shrinkWrap: true,
                    //                   reverse: true,
                    //                   physics: NeverScrollableScrollPhysics(),
                    //                   itemBuilder: (context, index) => ItemCard(
                    //                         room: listRoom[index],
                    //                       )));
                    //     })
                  ],
                ),
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
                          reverse: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => ItemCard(
                                room: listRoom[index],
                              )),
                )
              ]),
            ),
          ),
        ));
  }
}
