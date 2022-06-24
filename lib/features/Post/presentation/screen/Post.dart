import 'dart:convert';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:clean_achitecture/LocalStoreKey.dart';
import 'package:clean_achitecture/Theme/color.dart';
import 'package:clean_achitecture/common/Config.dart';
import 'package:clean_achitecture/features/Post/data/CreateRoom.dart';
import 'package:clean_achitecture/features/Post/model/distric.dart';
import 'package:clean_achitecture/features/Post/model/ward.dart';
import 'package:clean_achitecture/features/Post/presentation/screen/addInformationRoom.dart';
import 'package:clean_achitecture/features/room/presentation/page/Room.dart';
import 'package:clean_achitecture/features/tab/presentation/screen/tab.dart';
import 'package:clean_achitecture/style/styleAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localstorage/localstorage.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

import '../../../room/model/RoomModel.dart';

class PostPage extends StatefulWidget {
  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final _formKey = GlobalKey<FormState>();

  int activeStepIndex = 0;
  bool isSelectedWifi = false;
  bool isSelectedWC = false;
  bool isSelectedMB = false;
  bool isSelectedClock = false;
  bool isSelectedAirFresher = false;
  bool isSelectedCook = false;
  bool isSelectedFridge = false;
  bool isSelectedWM = false;
  int counter = 0;
  late String countryValue;
  late String stateValue;
  late String cityValue;
  late Ward ward;
  String? _selectionDistrict;
  String? _selectionWard;
  List dataD = [];
  List dataW = []; //edited line
  late RoomModel roomModel = RoomModel();
  TextEditingController wardController = new TextEditingController();
  TextEditingController nameStreetController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();

  TextEditingController priceController = new TextEditingController();
  TextEditingController sizeRoomController = new TextEditingController();
  TextEditingController decribleRoomController = new TextEditingController();
  TextEditingController titleRoomController = new TextEditingController();

  List<Asset> images = [];
  final LocalStorage storage = new LocalStorage(keyLocalStore);
  CreateRoomAPI createRoomAPI = CreateRoomAPI();
  Future<String> getDataDistict() async {
    final assetBundle = DefaultAssetBundle.of(context);
    final data = await assetBundle.loadString('assets/json/district.json');
    final body = json.decode(data);
    setState(() {
      dataD = body;
    });
    return body.map<District>(District.fromJson).toList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String userId = storage.getItem(LocalStoreKey.idUser);
    roomModel.accountId = userId;
    getDataDistict();
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
                    // Icon(
                    //   CupertinoIcons.back,
                    //   color: CupertinoColors.activeBlue,
                    //   size: 25,
                    // ),
                    // Text(
                    //   "Danh mục",
                    //   style: TextStyle(
                    //       color: CupertinoColors.activeBlue, fontSize: 16),
                    // ),
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          middle: Text(
            "Đăng phòng",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        child: SafeArea(
          child: Scaffold(
              body: Stepper(
            type: StepperType.horizontal,
            currentStep: activeStepIndex,
            controlsBuilder: (BuildContext context, ControlsDetails controls) {
              return Row(
                children: <Widget>[
                  TextButton(
                    onPressed: controls.onStepCancel,
                    child: const Text('Quay lại',
                        style: TextStyle(
                            fontSize: 18, color: CupertinoColors.activeBlue)),
                  ),
                  TextButton(
                    onPressed: controls.onStepContinue,
                    // () {
                    //   createRoomAPI.createPostRoom(roomModel);
                    // },
                    child: const Text(
                      'Tiếp',
                      style: TextStyle(
                          fontSize: 18,
                          color: CupertinoColors.systemRed,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              );
            },
            steps: [
              Step(
                state: activeStepIndex <= 0
                    ? StepState.editing
                    : StepState.complete,
                isActive: activeStepIndex >= 0,
                title: Text('Vị trí'),
                content: postAddress(),
              ),
              Step(
                  state: activeStepIndex <= 1
                      ? StepState.editing
                      : StepState.complete,
                  isActive: activeStepIndex >= 1,
                  title: Text('Thông tin'),
                  content: postInformationRoom()),
              Step(
                  state: StepState.editing,
                  isActive: activeStepIndex >= 2,
                  title: Text('Xác nhận'),
                  content: decribleRoom())
            ],
            onStepContinue: () {
              if (activeStepIndex <= 3) {
                activeStepIndex += 1;
              } else if (activeStepIndex > 3) {}
              setState(() {});
            },
            onStepCancel: () {
              if (activeStepIndex == 0) {
                return;
              }
              activeStepIndex -= 1;
              setState(() {});
            },
          )),
        ));
  }

  Widget postAddress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Text('Nhập thông tin địa chỉ', style: TextStyle(fontSize: 16)),
        //     Row(
        //       children: [
        //         IconButton(
        //             onPressed: () {},
        //             icon: Icon(Icons.add_location, color: Colors.blue)),
        //         Text('Vị trí hiện tại', style: TextStyle(color: Colors.blue))
        //       ],
        //     ),
        //   ],
        // ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Chọn Quận/Huyện', style: TextStyle(fontSize: 16)),
        ),
        DropdownButtonFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            filled: true,
          ),
          hint: Text('Chọn quận/huyện'),
          value: _selectionDistrict,
          onChanged: (newVal) {
            setState(() {
              _selectionDistrict = newVal as String?;
              roomModel.areaName = _selectionDistrict;
            });
          },
          items: dataD.map((item) {
            return new DropdownMenuItem(
              child: new Text(item['name'].toString()),
              value: item['name'].toString(),
            );
          }).toList(),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Phường/Xã', style: TextStyle(fontSize: 16)),
        ),
        TextFormField(
          textAlign: TextAlign.start,
          controller: wardController,
          decoration: InputDecoration(
              hintText: "Nhập phường/xã",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
          onChanged: (value) {
            //wardController.text = value;
            roomModel.wardName = wardController.text;
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Số nhà, tên đường', style: TextStyle(fontSize: 16)),
        ),
        TextFormField(
          textAlign: TextAlign.start,
          controller: nameStreetController,
          decoration: InputDecoration(
              hintText: "Nhập số nhà, tên đường",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
          onChanged: (text) {
            //nameStreetController.text = value;
            roomModel.streetName = nameStreetController.text +
                " " +
                wardController.text +
                " " +
                _selectionDistrict.toString();
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Số điện thoại', style: TextStyle(fontSize: 16)),
        ),
        TextFormField(
          textAlign: TextAlign.start,
          controller: phoneController,
          decoration: InputDecoration(
              hintText: "Nhập SDT",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
          onChanged: (value) {
            //wardController.text = value;
            roomModel.phoneNumber = phoneController.text;
          },
        ),
      ],
    );
  }

  Widget postInformationRoom() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FlutterToggleTab(
            width: 85,
            borderRadius: 30,
            height: 40,
            selectedTextStyle: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
            unSelectedTextStyle: TextStyle(
                color: Colors.black87,
                fontSize: 14,
                fontWeight: FontWeight.w500),
            labels: ["Phòng trọ", "Căn hộ", "Nguyên căn"],
            selectedLabelIndex: (index) {
              setState(() {
                counter = index;
              });
              if (index == 0) {
                roomModel.categoryName = "Phòng trọ";
              } else if (index == 1) {
                roomModel.categoryName = "Căn hộ";
              } else {
                roomModel.categoryName = "Nguyên căn";
              }
              print("Selected Index $index");
            },
            selectedIndex: counter,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Giá phòng(VND)', style: TextStyle(fontSize: 16)),
                Text('Diện tích(m2)', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: <Widget>[
                Flexible(
                    child: Container(
                  child: TextFormField(
                    controller: priceController,
                    decoration: InputDecoration(
                        hintText: "3.000.000",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onChanged: (value) {
                      roomModel.price = int.parse(priceController.text);
                    },
                  ),
                )),
                SizedBox(width: 10),
                Flexible(
                    child: Container(
                  child: TextFormField(
                    controller: sizeRoomController,
                    decoration: InputDecoration(
                        hintText: "20",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onChanged: (value) {
                      roomModel.size = int.parse(sizeRoomController.text);
                    },
                  ),
                ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Tiện ích phòng', style: TextStyle(fontSize: 16)),
          ),
          //UtilitiesRoom(),
          //PostImage()
          Column(
            children: <Widget>[
              ElevatedButton(
                child: Text("Chọn 6 ảnh"),
                onPressed: pickImages,
              ),
              GridView.count(
                crossAxisCount: 2,
                controller: new ScrollController(keepScrollOffset: false),
                shrinkWrap: true,
                //scrollDirection: Axis.vertical,
                children: List.generate(images.length, (index) {
                  Asset asset = images[index];
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Stack(children: [
                      AssetThumb(
                        asset: asset,
                        width: 300,
                        height: 300,
                      ),
                      Positioned(
                          right: -10,
                          top: 5,
                          child: Container(
                            child: MaterialButton(
                              onPressed: () {
                                images.removeAt(index);
                                setState(() {});
                              },
                              color: Colors.blue,
                              textColor: Colors.white,
                              child: Icon(
                                Icons.close,
                                size: 20,
                              ),
                              padding: EdgeInsets.all(10),
                              shape: CircleBorder(),
                              //shape: CircleBorder(),
                            ),
                          ))
                    ]),
                  );
                }),
              )
            ],
          )
        ],
      ),
    );
  }

  Future<void> pickImages() async {
    List<Asset> resultList = [];
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: images,
        materialOptions: MaterialOptions(
          actionBarTitle: "Chọn ảnh",
        ),
      );
    } on Exception catch (e) {
      print(e);
    }

    setState(() {
      images = resultList;
      // roomModel.imageMain = images[0];
      // roomModel.images = images.cast<String>();
    });
  }

  Widget decribleRoom() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            controller: titleRoomController,
            minLines: 2,
            maxLines: 5,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
                hintText: 'Nhập tiêu đề',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                )),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: decribleRoomController,
            minLines: 2,
            maxLines: 5,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
                hintText: 'Nhập mô tả chi tiết',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                )),
          ),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: FlatButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  var date = DateTime.now();
                  roomModel.date = date.toString();
                  roomModel.statusRoom = 0;
                  await createRoomAPI.createPostRoom(roomModel).then((value) {
                    ArtSweetAlert.show(
                        context: context,
                        artDialogArgs: ArtDialogArgs(
                            sizeSuccessIcon: 70,
                            type: ArtSweetAlertType.success,
                            title:
                                "Đăng kí tài thành công. Bạn có thể đăng nhập!"));
                    return;
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CurvedNavigationBarWidget(),
                        settings: RouteSettings(
                          arguments: roomModel,
                        ),
                      ));
                }
              },
              child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width * 0.15,
                  child: Text('Đăng bài',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25)),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200),
                      gradient: LinearGradient(colors: <Color>[
                        CupertinoColors.activeBlue,
                        CupertinoColors.activeGreen,
                      ]))),
              textColor: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
