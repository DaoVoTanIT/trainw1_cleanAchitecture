import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:clean_achitecture/LocalStoreKey.dart';
import 'package:clean_achitecture/Theme/color.dart';
import 'package:clean_achitecture/common/Config.dart';
import 'package:clean_achitecture/features/MyRoom/data/DeteleMyRoomAPI.dart';
import 'package:clean_achitecture/features/MyRoom/data/GetMyRoomAPI.dart';
import 'package:clean_achitecture/features/account/presentation/widget/custom_image.dart';
import 'package:clean_achitecture/features/favorite/presentation/widget/favorite_box.dart';
import 'package:clean_achitecture/features/room/model/RoomModel.dart';
import 'package:clean_achitecture/features/room/presentation/page/DetailRoomPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';

class MyRoomPage extends StatefulWidget {
  const MyRoomPage({Key? key}) : super(key: key);

  @override
  _MyRoomPageState createState() => _MyRoomPageState();
}

class _MyRoomPageState extends State<MyRoomPage> {
  final LocalStorage storage = new LocalStorage(keyLocalStore);
  List<RoomModel> myRoomPost = [];
  MyRoomAPI myRoomAPI = MyRoomAPI();
  String idUser = '';
  DeleteMyRoomAPI deleteMyRoomAPI = DeleteMyRoomAPI();
  @override
  void initState() {
    super.initState();
    idUser = storage.getItem(LocalStoreKey.idUser);
    getMyRoomPost(idUser);
  }

  getMyRoomPost(String idUser) async {
    myRoomPost = await myRoomAPI.getMyRoom(idUser);
    setState(() {});
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
                    Icon(
                      CupertinoIcons.back,
                      color: CupertinoColors.activeBlue,
                      size: 25,
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
            "Tin đã đăng",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        child: myRoomPost.isEmpty
            ? Container()
            : Scaffold(
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ...myRoomPost.map((e) => Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const DetailRoomPage(),
                                        settings: RouteSettings(
                                          arguments: e,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 300,
                                      padding: EdgeInsets.all(10),
                                      margin:
                                          EdgeInsets.only(bottom: 5, top: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: shadowColor.withOpacity(0.1),
                                            spreadRadius: 1,
                                            blurRadius: 1,
                                            offset: Offset(1,
                                                1), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          e.imageMain == null
                                              ? Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Image.asset(
                                                    "assets/images/room2.jpeg",
                                                    width: double.infinity,
                                                    height: 190,
                                                  ),
                                                )
                                              : CustomImage(
                                                  e.imageMain.toString(),
                                                  width: double.infinity,
                                                  height: 190,
                                                  radius: 15,
                                                ),
                                          Container(
                                            width: 250,
                                            padding: EdgeInsets.fromLTRB(
                                                5, 10, 5, 0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  e.streetName.toString(),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: textColor,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    e.categoryName.toString(),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: labelColor,
                                                        fontSize: 15),
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text(
                                                    '${NumberFormat.decimalPattern().format(e.price).toString()}/tháng',
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: primary,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                              Spacer(),
                                              FavoriteBox(
                                                  size: 16,
                                                  onTap: () async {
                                                    ArtDialogResponse response =
                                                        await ArtSweetAlert.show(
                                                            barrierDismissible:
                                                                false,
                                                            context: context,
                                                            artDialogArgs: ArtDialogArgs(
                                                                denyButtonText:
                                                                    "Huỷ",
                                                                title:
                                                                    "Bạn xoá không?",
                                                                confirmButtonText:
                                                                    "Xoá",
                                                                type: ArtSweetAlertType
                                                                    .warning));
                                                    if (response == null) {
                                                      return;
                                                    }

                                                    if (response
                                                        .isTapConfirmButton) {
                                                      await deleteMyRoomAPI
                                                          .deleteMyRoom(
                                                              e.id.toString())
                                                          .then((value) => {
                                                                setState(() {
                                                                  getMyRoomPost(
                                                                      idUser);
                                                                })
                                                              });
                                                      // await deleteFavoriteRoomAPI
                                                      //     .deleteFavoriteRoom(
                                                      //         e.id.toString())
                                                      //     .then((value) =>
                                                      //         getFavoriteRoom(
                                                      //             idUser));
                                                      //await saveFavoriteRoomAPI.saveFavoriteRoom(saveRoomFavorite, idUser);
                                                      ArtSweetAlert.show(
                                                          context: context,
                                                          artDialogArgs: ArtDialogArgs(
                                                              sizeSuccessIcon:
                                                                  70,
                                                              type:
                                                                  ArtSweetAlertType
                                                                      .success,
                                                              title:
                                                                  "Bạn đã xoá phòng đã đăng"));
                                                      return;
                                                    }
                                                  })
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              ));
  }
}
