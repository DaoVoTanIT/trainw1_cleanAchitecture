import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:clean_achitecture/LocalStoreKey.dart';
import 'package:clean_achitecture/Theme/color.dart';
import 'package:clean_achitecture/common/config.dart';
import 'package:clean_achitecture/features/account/presentation/widget/custom_image.dart';
import 'package:clean_achitecture/features/favorite/data/%08favoriteAPI.dart';
import 'package:clean_achitecture/features/favorite/data/deleteRoomFavorite.dart';
import 'package:clean_achitecture/features/favorite/presentation/widget/favorite_box.dart';
import 'package:clean_achitecture/features/room/model/RoomModel.dart';
import 'package:clean_achitecture/features/room/presentation/page/DetailRoomPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _SavedRoomPageState createState() => _SavedRoomPageState();
}

class _SavedRoomPageState extends State<FavoritePage> {
  List<Asset> images = [];
  List<RoomModel> listRoomFavorite = [];
  FavoriteRoomAPI favoriteRoomAPI = FavoriteRoomAPI();
  final LocalStorage storage = new LocalStorage(keyLocalStore);
  String idUser = '';
  DeleteFavoriteRoomAPI deleteFavoriteRoomAPI = DeleteFavoriteRoomAPI();
  @override
  void initState() {
    super.initState();
    idUser = storage.getItem(LocalStoreKey.idUser);
    getFavoriteRoom(idUser);
  }

  getFavoriteRoom(String idUser) async {
    // ignore: deprecated_member_use

    listRoomFavorite = await favoriteRoomAPI.getListFavoriteRoom(idUser);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: appBgColor,
        navigationBar: CupertinoNavigationBar(
          leading: Image.asset(
            "assets/images/logo.png",
            fit: BoxFit.fill,
            color: CupertinoColors.activeBlue,
          ),
          middle: Text(
            "Phòng đã lưu",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        child: Scaffold(
            body: listRoomFavorite.isEmpty
                ? Container()
                : SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ...listRoomFavorite.map((e) => Column(
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
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 300,
                                        padding: EdgeInsets.all(10),
                                        margin:
                                            EdgeInsets.only(bottom: 5, top: 5),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  shadowColor.withOpacity(0.1),
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
                                            CustomImage(
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
                                                      '${NumberFormat.decimalPattern().format(e.price).toString()} triệu/tháng',
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
                                                      ArtDialogResponse
                                                          response =
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
                                                        await deleteFavoriteRoomAPI
                                                            .deleteFavoriteRoom(
                                                                e.id.toString())
                                                            .then((value) =>
                                                                getFavoriteRoom(
                                                                    idUser));
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
                                                                    "Lưu thành công"));
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
                  )));
  }
}
