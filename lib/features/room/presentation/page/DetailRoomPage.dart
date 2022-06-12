import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:clean_achitecture/Theme/color.dart';
import 'package:clean_achitecture/features/room/data/SaveRoomFavoriteAPI.dart';
import 'package:clean_achitecture/features/room/model/RoomModel.dart';

import 'package:clean_achitecture/features/room/presentation/page/MapRoom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../routes/route_name.dart';

class DetailRoomPage extends StatefulWidget {
  const DetailRoomPage({Key? key}) : super(key: key);

  @override
  _DetailRoomPageState createState() => _DetailRoomPageState();
}

class _DetailRoomPageState extends State<DetailRoomPage> {
  RoomModel saveRoomFavorite = RoomModel();
  String? body;
  SaveFavoriteRoomAPI saveFavoriteRoomAPI = SaveFavoriteRoomAPI();
  late RoomModel roomDetail;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      roomDetail =
          ((ModalRoute.of(context)!.settings.arguments)! as RoomModel?)!;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // final roomDetail =
    //     ((ModalRoute.of(context)!.settings.arguments)! as RoomModel?)!;
    int _currentIndex = 0;
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
            backgroundColor: appBgColor,
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          autoPlay: true,
                          onPageChanged: (index, reason) {
                            setState(
                              () {
                                _currentIndex = index;
                              },
                            );
                          },
                        ),
                        items: roomDetail.images!
                            .map(
                              (item) => Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Card(
                                  elevation: 6.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Stack(
                                    children: <Widget>[
                                      Image.network(
                                        item,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: 1000,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children:
                                            roomDetail.images!.map((urlOfItem) {
                                          int index = roomDetail.images!
                                              .indexOf(urlOfItem);
                                          return Container(
                                            width: 10.0,
                                            height: 10.0,
                                            margin: EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 2.0),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: _currentIndex == index
                                                  ? Color.fromRGBO(0, 0, 0, 0.8)
                                                  : Color.fromRGBO(
                                                      0, 0, 0, 0.3),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                      // Center(
                                      //   child: Text(
                                      //     '${titles[_currentIndex]}',
                                      //     style: TextStyle(
                                      //       fontSize: 24.0,
                                      //       fontWeight: FontWeight.bold,
                                      //       backgroundColor: Colors.black45,
                                      //       color: Colors.white,
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        roomDetail.subject.toString(),
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                roomDetail.price == null
                                    ? ''
                                    : roomDetail.price.toString(),
                                style: TextStyle(
                                    fontSize: 15,
                                    color: CupertinoColors.systemRed),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                roomDetail.date == null
                                    ? ''
                                    : roomDetail.date.toString(),
                                style: TextStyle(
                                    fontSize: 15,
                                    color: CupertinoColors.systemGrey),
                              ),
                            ],
                          ),
                          Spacer(),
                          OutlinedButton(
                            // style: outlineButtonStyle,

                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              side: BorderSide(
                                width: 1.0,
                                color: CupertinoColors.systemRed,
                                style: BorderStyle.solid,
                              ),
                            ),
                            onPressed: () {},
                            child: Row(
                              children: [
                                Text(
                                  'Lưu',
                                  style: TextStyle(
                                    color: CupertinoColors.systemRed,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    alert();
                                  },
                                  child: Icon(
                                    CupertinoIcons.heart,
                                    color: CupertinoColors.systemRed,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          CupertinoIcons.placemark,
                          color: CupertinoColors.systemGrey,
                          size: 25,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MapRoomPage(),
                                    settings: RouteSettings(
                                      arguments: {
                                        'longtitude': roomDetail.longitude,
                                        'latitude': roomDetail.latitude
                                      },
                                    ),
                                  ),
                                );
                                // Navigator.pushNamed(context, RouteName.mapRoomPage,
                                //     arguments: {
                                //       'longtitude': roomDetail.longitude,
                                //       'latitude': roomDetail.latitude
                                //     });
                              },
                              child: Text(
                                roomDetail.streetName == null
                                    ? ''
                                    : roomDetail.streetName.toString(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Divider(
                    thickness: 1.5,
                    color: CupertinoColors.systemGrey4,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                              radius: 25.0,
                              backgroundColor: Color(0xffFDCF09),
                              child: CircleAvatar(
                                radius: 100,
                                backgroundImage: NetworkImage(
                                    roomDetail.avatar.toString(),
                                    scale: 50.0),
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            roomDetail.accountName == null
                                ? ''
                                : roomDetail.accountName.toString(),
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1.5,
                    color: CupertinoColors.systemGrey4,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    roomDetail.body == null ? '' : roomDetail.body.toString(),
                    style:
                        TextStyle(color: CupertinoColors.black, fontSize: 15),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.square_grid_2x2,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Diện tích: ' + roomDetail.size.toString() == null
                            ? ''
                            : roomDetail.size.toString() + ' m2',
                        style: TextStyle(
                            color: CupertinoColors.black, fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }

  alert() async {
    ArtDialogResponse response = await ArtSweetAlert.show(
        barrierDismissible: false,
        context: context,
        artDialogArgs: ArtDialogArgs(
            denyButtonText: "Huỷ",
            title: "Bạn có muốn lưu phòng?",
            confirmButtonText: "Lưu",
            type: ArtSweetAlertType.warning));
    if (response == null) {
      return;
    }

    if (response.isTapConfirmButton) {
      saveRoomFavorite.accountId = roomDetail.accountId;
      saveRoomFavorite.images = roomDetail.images;
      saveRoomFavorite.subject = roomDetail.subject;
      saveRoomFavorite.price = roomDetail.price;
      saveRoomFavorite.priceString = roomDetail.priceString;
      saveRoomFavorite.date = roomDetail.date;
      saveRoomFavorite.streetName = roomDetail.streetName;
      saveRoomFavorite.avatar = roomDetail.avatar;
      saveRoomFavorite.accountName = roomDetail.accountName;
      saveRoomFavorite.body = roomDetail.body;
      saveRoomFavorite.categoryName = roomDetail.categoryName;
      saveRoomFavorite.imageMain = roomDetail.imageMain;
      saveRoomFavorite.size = roomDetail.size;
      saveRoomFavorite.statusRoom = 1;
      saveRoomFavorite.id = roomDetail.id;

      await saveFavoriteRoomAPI.saveFavoriteRoom(saveRoomFavorite);
      ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
              sizeSuccessIcon: 70,
              type: ArtSweetAlertType.success,
              title: "Lưu thành công"));
      return;
    }
  }
}
