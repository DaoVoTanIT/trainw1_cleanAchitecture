import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:clean_achitecture/LocalStoreKey.dart';
import 'package:clean_achitecture/Theme/color.dart';
import 'package:clean_achitecture/common/Config.dart';
import 'package:clean_achitecture/features/room/data/CommentAPI.dart';
import 'package:clean_achitecture/features/room/data/RoomAPI.dart';
import 'package:clean_achitecture/features/room/data/SaveRoomFavoriteAPI.dart';
import 'package:clean_achitecture/features/room/model/CommentModel.dart';
import 'package:clean_achitecture/features/room/model/RoomModel.dart';

import 'package:clean_achitecture/features/room/presentation/page/MapRoom.dart';
import 'package:clean_achitecture/features/room/presentation/widget/item_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import '../../../../routes/route_name.dart';
import '../widget/marqueeWidget.dart';

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
  String idUser = "";
  String name = "";
  List<RoomModel> listRoom = [];
  List<RoomModel> listRecomment = [];

  final commentController = TextEditingController();

  final LocalStorage storage = new LocalStorage(keyLocalStore);
  CommentRoomAPI commentRoomAPI = CommentRoomAPI();
  CommentModel commentModel = CommentModel();
  List<CommentModel> listComment = [];
  RoomAPI roomAPI = RoomAPI();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      roomDetail =
          ((ModalRoute.of(context)!.settings.arguments)! as RoomModel?)!;
      setState(() {});
    });
    getListComment();
    getListRoom();
    idUser = storage.getItem(LocalStoreKey.idUser);
    name = storage.getItem(LocalStoreKey.name);
  }

  getListRoom() async {
    listRoom = await roomAPI.getListRoom();
    setState(() {
      listRoom = listRoom
          .where((element) =>
              element.areaName == roomDetail.areaName &&
              element.price! <= roomDetail.price!.toInt() + 1000000 &&
              element.price! >= roomDetail.price!.toInt() - 1000000)
          .toList();
    });
  }

  getListComment() async {
    listComment = (await commentRoomAPI.getListComment())!;
    listComment = listComment
        .where((element) => element.idroom == roomDetail.id)
        .toList();
  }

  createToDo() async {
    var date = DateTime.now();
    commentModel.idroom = roomDetail.id;
    commentModel.idauthor = idUser;
    commentModel.name = name;
    commentModel.datetime = date.toString();
    var newToDo = await commentRoomAPI.createCommentRoom(commentModel);
    setState(() {
      //listToDo = [...listToDo, newToDo];
      listComment.insert(listComment.length, newToDo);
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
                      "Trang ch???",
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
            "Chi ti???t",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        child: Scaffold(
            backgroundColor: appBgColor,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Wrap(
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
                                            borderRadius:
                                                BorderRadius.circular(10.0),
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
                                                children: roomDetail.images!
                                                    .map((urlOfItem) {
                                                  int index = roomDetail.images!
                                                      .indexOf(urlOfItem);
                                                  return Container(
                                                    width: 10.0,
                                                    height: 10.0,
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10.0,
                                                            horizontal: 2.0),
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color:
                                                          _currentIndex == index
                                                              ? Color.fromRGBO(
                                                                  0, 0, 0, 0.8)
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
                                          roomDetail.price != null
                                              ? '${NumberFormat.decimalPattern().format(roomDetail.price).toString()}/th??ng'
                                              : '',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                          )),
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
                                        borderRadius:
                                            BorderRadius.circular(18.0),
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
                                          'L??u',
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
                                        // Navigator.pushNamed(
                                        //   context,
                                        //   RouteName.mapRoomPage,
                                        //   arguments: {
                                        //     'longtitude': roomDetail.longitude,
                                        //     'latitude': roomDetail.latitude
                                        //   },
                                        // );
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
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  roomDetail.phoneNumber != null
                                      ? UrlLauncher.launch(
                                          'tel:+${roomDetail.phoneNumber.toString()}')
                                      : UrlLauncher.launch(
                                          'tel:+${0373216417}');
                                },
                                child: Icon(
                                  CupertinoIcons.phone_solid,
                                  color: CupertinoColors.systemGrey,
                                  size: 25,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              TextButton(
                                onPressed: () {
                                  roomDetail.phoneNumber != null
                                      ? UrlLauncher.launch(
                                          'tel:+${roomDetail.phoneNumber.toString()}')
                                      : UrlLauncher.launch(
                                          'tel:+${0373216417}');
                                },
                                child: Text(
                                  roomDetail.phoneNumber == null
                                      ? '0373216417'
                                      : roomDetail.phoneNumber.toString(),
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
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
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
                            roomDetail.body == null
                                ? ''
                                : roomDetail.body.toString(),
                            style: TextStyle(
                                color: CupertinoColors.black, fontSize: 15),
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
                                'Di???n t??ch: ' + roomDetail.size.toString() ==
                                        null
                                    ? ''
                                    : roomDetail.size.toString() + ' m2',
                                style: TextStyle(
                                    color: CupertinoColors.black, fontSize: 15),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Row(
                        children: [
                          Text(
                            "${listComment.length} B??nh lu???n",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    showCupertinoModalPopup<void>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          CupertinoActionSheet(
                                        title: const Text('S???p x???p gi?? ph??ng'),
                                        // message: const Text('Message'),
                                        actions: <CupertinoActionSheetAction>[
                                          CupertinoActionSheetAction(
                                            isDefaultAction: true,
                                            onPressed: () {
                                              listComment.sort((a, b) => b
                                                  .datetime!
                                                  .compareTo(a.datetime!));
                                              setState(() {});
                                              Navigator.pop(context);
                                            },
                                            child: Text('B??nh lu???n c??'),
                                          ),
                                          CupertinoActionSheetAction(
                                            isDefaultAction: true,
                                            onPressed: () {
                                              listComment.sort((a, b) => a
                                                  .datetime!
                                                  .compareTo(b.datetime!));
                                              setState(() {});
                                              Navigator.pop(context);
                                            },
                                            child: Text('B??nh lu???n m???i nh???t'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    Icons.sort,
                                    size: 30,
                                    color: CupertinoColors.activeBlue,
                                  )),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "S???p x???p theo",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 10, bottom: 10),
                      height: 80,
                      width: double.infinity,
                      // color: CupertinoColors.g,
                      child: CupertinoTextField(
                        controller: commentController,
                        placeholder: "Vi???t b??nh lu???n...",
                        textInputAction: TextInputAction.send,
                        onChanged: (value) {
                          commentModel.content = value;
                        },
                        suffix: GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              CupertinoIcons.paperplane_fill,
                              color: CupertinoColors.activeBlue,
                              size: 25,
                            ),
                          ),
                          onTap: () async {
                            if (commentController.text.isEmpty) {
                              //check empty text
                              return null;
                            } else {
                              await createToDo();
                              commentController.clear();
                            }
                          },
                        ),
                        decoration: BoxDecoration(
                            //color: CupertinoColors.lightBackgroundGray,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                                color: CupertinoColors.systemGrey3, width: 1)),
                        onEditingComplete: () async {
                          if (commentController.text.isEmpty) {
                            //check empty text
                            return null;
                          } else {
                            await createToDo();
                            commentController.clear();
                          }
                        },
                      ),
                    ),
                    listComment.length == 0
                        ? Container()
                        : ListView.builder(
                            reverse: true, //reverse ListView
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: listComment.length,
                            itemBuilder: (BuildContext context, int index) {
                              // return Text(listComment[i].content.toString());
                              return ListTile(
                                leading: listComment[index].avatar != null
                                    ? CircleAvatar(
                                        child: Text(listComment[index]
                                            .avatar
                                            .toString()),
                                        backgroundColor: CupertinoColors.white,
                                      )
                                    : CircleAvatar(
                                        child: Icon(CupertinoIcons.person),
                                        backgroundColor: CupertinoColors.white,
                                      ),
                                title: listComment[index].name == null
                                    ? Text("")
                                    : Text(
                                        listComment[index].name.toString(),
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: CupertinoColors.black,
                                            fontWeight: FontWeight.w700),
                                      ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      listComment[index].content.toString(),
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: CupertinoColors.black,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Text(
                                        listComment[index]
                                            .datetime!
                                            .substring(0, 16)
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: CupertinoColors.systemRed,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 15, 0),
                          child: Text(
                            'Tin ????ng t????ng t???',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF012169)),
                          ),
                        ),
                      ],
                    ),
                    Container(
                        padding: const EdgeInsets.only(bottom: 10),
                        height: 230,
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            // childAspectRatio: 0.50,
                            // mainAxisSpacing: 0,
                            // crossAxisSpacing: 0,
                          ),
                          scrollDirection: Axis.horizontal,
                          //  padding: EdgeInsets.zero,
                          itemCount: listRoom.length,
                          itemBuilder: (context, i) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const DetailRoomPage(),
                                    settings: RouteSettings(
                                      arguments: listRoom[i],
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: listRoom[i].imageMain.toString(),
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      height: 150,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    progressIndicatorBuilder: (context, url,
                                            downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                      height: 150,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/pt1.jpeg"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 150,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          listRoom[i].subject.toString(),
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              height: 1.5),
                                        ),
                                        Text(
                                          listRoom[i].areaName.toString(),
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              height: 1.5),
                                        ),
                                        Text(
                                            '${NumberFormat.decimalPattern().format(listRoom[i].price).toString()} /th??ng',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  CupertinoColors.systemYellow,
                                            )),
                                        // Text("${title[index]['time']} Hour drive")
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ))
                  ],
                ),
              ),
            )));
  }

  alert() async {
    ArtDialogResponse response = await ArtSweetAlert.show(
        barrierDismissible: false,
        context: context,
        artDialogArgs: ArtDialogArgs(
            denyButtonText: "Hu???",
            title: "B???n c?? mu???n l??u ph??ng?",
            confirmButtonText: "L??u",
            type: ArtSweetAlertType.warning));
    if (response == null) {
      return;
    }

    if (response.isTapConfirmButton) {
      saveRoomFavorite.accountId = idUser;
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

      await saveFavoriteRoomAPI.saveFavoriteRoom(saveRoomFavorite, idUser);
      ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
              sizeSuccessIcon: 70,
              type: ArtSweetAlertType.success,
              title: "L??u th??nh c??ng"));
      return;
    }
  }
}
