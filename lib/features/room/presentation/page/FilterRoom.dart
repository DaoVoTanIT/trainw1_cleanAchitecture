import 'package:clean_achitecture/Theme/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';

import '../../data/RoomAPI.dart';
import '../../model/RoomModel.dart';

class FliterScreen extends StatefulWidget {
  @override
  _FliterScreenState createState() => _FliterScreenState();
}

enum SingingCharacter { priceOption1, priceOption2, priceOption3 }

class _FliterScreenState extends State<FliterScreen> {
  //fliter ở đây
  var selectedPriceValue;
  RangeValues _currentRangeValues = const RangeValues(0, 10000000);
  RangeValues _currentRangeSizeRoomValues = const RangeValues(10, 100);

  List<RoomModel> listRoomModel = [];
  RoomAPI roomAPI = RoomAPI();
  var newList;
  // getListRoom() async {
  //   listRoomModel = await roomAPI.getListRoom();
  //   setState(() {});
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      listRoomModel =
          ModalRoute.of(context)!.settings.arguments as List<RoomModel>;
      //getListRoom();
      setState(() {});
    });
  }

  void filterOptions() {
    var techMobile = listRoomModel;
    // ignore: unused_local_variable
    if (selectedPriceValue == 1) {
      newList = techMobile
          .where((element) => element.categoryName == "Phòng trọ")
          .toList();
    }
    if (selectedPriceValue == 2) {
      newList = techMobile
          .where((element) => element.categoryName == "Căn hộ")
          .toList();
    }
    if (selectedPriceValue == 3) {
      newList = techMobile
          .where((element) =>
              element.price! > _currentRangeValues.start &&
              element.price! < _currentRangeValues.end)
          .toList();
    }
    if (selectedPriceValue == 4) {
      newList = techMobile
          .where((element) =>
              element.size! > _currentRangeSizeRoomValues.start &&
              element.size! < _currentRangeSizeRoomValues.end)
          .toList();
    }
    return newList;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      //statusBarBrightness: Brightness.dark,
    ));
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
          "Bạn muốn lọc?",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
      child: Scaffold(
          backgroundColor: appBgColor,
          body: SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Danh mục',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        RadioListTile(
                          value: 1,
                          groupValue: selectedPriceValue,
                          title: Text('Phòng trọ',
                              style: TextStyle(
                                fontSize: 17,
                              )),
                          onChanged: (val) {
                            setState(() {
                              selectedPriceValue = 1;
                            });
                          },
                          activeColor: Colors.red,
                          selected: false,
                        ),
                        RadioListTile(
                          value: 2,
                          groupValue: selectedPriceValue,
                          title: Text('Căn hộ',
                              style: TextStyle(
                                fontSize: 17,
                              )),
                          onChanged: (val) {
                            setState(() {
                              selectedPriceValue = 2;
                            });
                          },
                          activeColor: Colors.red,
                          selected: false,
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.grey.withOpacity(0.3),
                          height: 20,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text('Giá từ:',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            Text(' ${_currentRangeValues.start}',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold)),
                            Text(' đến',
                                style: TextStyle(
                                  fontSize: 17,
                                )),
                            Text(' ${_currentRangeValues.end}',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        RangeSlider(
                          values: _currentRangeValues,
                          max: 10000000,
                          divisions: 20,
                          labels: RangeLabels(
                            _currentRangeValues.start.round().toString(),
                            _currentRangeValues.end.round().toString(),
                          ),
                          onChanged: (RangeValues values) {
                            setState(() {
                              _currentRangeValues = values;
                              selectedPriceValue = 3;
                            });
                          },
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.grey.withOpacity(0.3),
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text('Kích thước: ',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            Text('${_currentRangeSizeRoomValues.start}',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold)),
                            Text(' đến',
                                style: TextStyle(
                                  fontSize: 17,
                                )),
                            Text(' ${_currentRangeSizeRoomValues.end}',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        RangeSlider(
                          values: _currentRangeSizeRoomValues,
                          max: 100,
                          min: 10,
                          divisions: 20,
                          labels: RangeLabels(
                            _currentRangeSizeRoomValues.start
                                .round()
                                .toString(),
                            _currentRangeSizeRoomValues.end.round().toString(),
                          ),
                          onChanged: (RangeValues values) {
                            setState(() {
                              _currentRangeSizeRoomValues = values;
                              selectedPriceValue = 4;
                            });
                          },
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: FlatButton(
                            onPressed: () {
                              setState(() {
                                filterOptions();
                              });
                              Navigator.of(context).pop(newList);
                            },
                            child: Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.width * 0.15,
                                child: Text('Áp dụng',
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
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
