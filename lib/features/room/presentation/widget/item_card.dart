import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_achitecture/Theme/color.dart';
import 'package:clean_achitecture/common/Config.dart';
import 'package:clean_achitecture/features/room/data/SaveRoomFavoriteAPI.dart';
import 'package:clean_achitecture/features/room/model/RoomModel.dart';
import 'package:clean_achitecture/features/room/presentation/page/DetailRoomPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';

class ItemCard extends StatelessWidget {
  final RoomModel room;
  ItemCard({
    Key? key,
    required this.room,
  }) : super(key: key);
  RoomModel saveRoomFavorite = RoomModel();
  SaveFavoriteRoomAPI saveFavoriteRoomAPI = SaveFavoriteRoomAPI();
  final LocalStorage storage = new LocalStorage(keyLocalStore);

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
            vertical: 5,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                children: [
                  CachedNetworkImage(
                    imageUrl: room.imageMain.toString(),
                    imageBuilder: (context, imageProvider) => Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
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
                        // Container(
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.all(Radius.circular(5)),
                        //   ),
                        //   child: Image.asset(
                        //     "assets/images/room2.jpeg",
                        //     fit: BoxFit.cover,
                        //     height: 120,
                        //     width: 120,
                        //   ),
                        // ),
                        Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/room2.jpeg'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                  ),
                  // room.imageMain == null
                  //     ? Image.asset(
                  //         "assets/images/room2.jpeg",
                  //         fit: BoxFit.cover,
                  //         height: 120,
                  //         width: 120,
                  //       )
                  //     : Image.network(
                  //         room.imageMain.toString(),
                  //         fit: BoxFit.cover,
                  //         height: 120,
                  //         width: 120,
                  //       ),
                ],
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(room.subject == null ? "" : room.subject.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          // color: Colors.black,
                        )),
                    SizedBox(height: 10),
                    Text(room.size == null ? "" : '${room.size} m2',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        )),
                    SizedBox(height: 7),
                    Text(
                        '${NumberFormat.decimalPattern().format(room.price).toString()} /tháng',
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
                            Text(
                                room.areaName == null
                                    ? ""
                                    : room.areaName.toString(),
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
                            color: red,
                            size: 25,
                          ),
                          onTap: () async {
                            ArtDialogResponse response =
                                await ArtSweetAlert.show(
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
                              saveRoomFavorite.accountId = room.accountId;
                              saveRoomFavorite.images = room.images;
                              saveRoomFavorite.subject = room.subject;
                              saveRoomFavorite.imageMain = room.imageMain;
                              saveRoomFavorite.price = room.price;
                              saveRoomFavorite.priceString = room.priceString;
                              saveRoomFavorite.date = room.date;
                              saveRoomFavorite.streetName = room.streetName;
                              saveRoomFavorite.avatar = room.avatar;
                              saveRoomFavorite.accountName = room.accountName;
                              saveRoomFavorite.body = room.body;
                              saveRoomFavorite.categoryName = room.categoryName;
                              saveRoomFavorite.size = room.size;

                              // await saveFavoriteRoomAPI.saveFavoriteRoom(
                              //     saveRoomFavorite, room.accountId.toString());
                              ArtSweetAlert.show(
                                  context: context,
                                  artDialogArgs: ArtDialogArgs(
                                      sizeSuccessIcon: 70,
                                      type: ArtSweetAlertType.success,
                                      title: "Lưu thành công"));
                              return;
                            }
                          },
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
