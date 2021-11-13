import 'package:clean_achitecture/features/Post/presentation/item_page/information_Post/presentation/widget/postImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostInformation extends StatefulWidget {
  const PostInformation({Key? key}) : super(key: key);

  @override
  _PostInformationState createState() => _PostInformationState();
}

class _PostInformationState extends State<PostInformation> {
  bool isSelectedWifi = false;
  bool isSelectedWC = false;
  bool isSelectedMB = false;
  bool isSelectedClock = false;
  bool isSelectedAirFresher = false;
  bool isSelectedCook = false;
  bool isSelectedFridge = false;
  bool isSelectedWM = false;
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FlutterToggleTab(
            width: 75,
            borderRadius: 30,
            height: 40,
            selectedTextStyle: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
            unSelectedTextStyle: TextStyle(
                color: Colors.black87,
                fontSize: 14,
                fontWeight: FontWeight.w500),
            labels: ["Phòng", "Căn hộ", "Nguyên căn"],
            selectedLabelIndex: (index) {
              setState(() {
                counter = index;
              });
              print("Selected Index $index");
            },
            selectedIndex: counter,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Gía phòng(VND)', style: TextStyle(fontSize: 16)),
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
                    decoration: InputDecoration(
                        hintText: "3.000.000",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                )),
                SizedBox(width: 10),
                Flexible(
                    child: Container(
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "20",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Tiện ích phòng', style: TextStyle(fontSize: 16)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isSelectedWifi = !isSelectedWifi;
                      });
                    },
                    icon: Icon(FontAwesomeIcons.wifi,
                        color: isSelectedWifi ? Colors.blue : Colors.grey),
                  ),
                  Text('Wifi')
                ],
              ),
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isSelectedWC = !isSelectedWC;
                      });
                    },
                    icon: Icon(FontAwesomeIcons.toilet),
                    color: isSelectedWC ? Colors.blue : Colors.grey,
                  ),
                  Text('WC riêng')
                ],
              ),
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isSelectedMB = !isSelectedMB;
                      });
                    },
                    icon: Icon(FontAwesomeIcons.motorcycle),
                    color: isSelectedMB ? Colors.blue : Colors.grey,
                  ),
                  Text('Giữ xe')
                ],
              ),
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isSelectedClock = !isSelectedClock;
                      });
                    },
                    icon: Icon(Icons.access_alarm),
                    color: isSelectedClock ? Colors.blue : Colors.grey,
                  ),
                  Text(
                    'Tự do',
                  )
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isSelectedAirFresher = !isSelectedAirFresher;
                      });
                    },
                    icon: Icon(FontAwesomeIcons.fan),
                    color: isSelectedAirFresher ? Colors.blue : Colors.grey,
                  ),
                  Text('Điều hoà')
                ],
              ),
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isSelectedCook = !isSelectedCook;
                      });
                    },
                    icon: Icon(FontAwesomeIcons.conciergeBell),
                    color: isSelectedCook ? Colors.blue : Colors.grey,
                  ),
                  Text('Bếp')
                ],
              ),
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isSelectedFridge = !isSelectedFridge;
                      });
                    },
                    icon: Icon(FontAwesomeIcons.windowMaximize),
                    color: isSelectedFridge ? Colors.blue : Colors.grey,
                  ),
                  Text('Tủ lạnh')
                ],
              ),
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isSelectedWM = !isSelectedWM;
                      });
                    },
                    icon: Icon(FontAwesomeIcons.algolia),
                    color: isSelectedWM ? Colors.blue : Colors.grey,
                  ),
                  Text(
                    'Máy giặc',
                  )
                ],
              ),
            ],
          ),
          PostImage()
        ],
      ),
    );
  }
}
