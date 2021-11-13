import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UtilitiesRoom extends StatefulWidget {
  const UtilitiesRoom({Key? key}) : super(key: key);

  @override
  _UtilitiesRoomState createState() => _UtilitiesRoomState();
}

class _UtilitiesRoomState extends State<UtilitiesRoom> {
  bool isSelectedWifi = false;
  bool isSelectedWC = false;
  bool isSelectedMB = false;
  bool isSelectedClock = false;
  bool isSelectedAirFresher = false;
  bool isSelectedCook = false;
  bool isSelectedFridge = false;
  bool isSelectedWM = false;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
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
      ]),
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
          )
        ],
      )
    ]);
  }
}
