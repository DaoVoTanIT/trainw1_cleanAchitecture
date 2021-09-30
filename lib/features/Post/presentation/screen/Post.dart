import 'package:clean_achitecture/Theme/color.dart';
import 'package:clean_achitecture/features/Post/presentation/widget/UtilitiesRoom_Infor.dart';
import 'package:clean_achitecture/style/styleAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostPage extends StatefulWidget {
  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
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
  List<Step> stepList() => [
        Step(
          state: activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: activeStepIndex >= 0,
          title: Text('Vị trí'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Chọn Tỉnh/TP', style: TextStyle(fontSize: 16)),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.add_location, color: Colors.blue)),
                      Text('Vị trí hiện tại',
                          style: TextStyle(color: Colors.blue))
                    ],
                  ),
                ],
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Tỉnh/TP",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Chọn Quận/Huyện', style: TextStyle(fontSize: 16)),
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Quận/Huyện",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Phường/Xã', style: TextStyle(fontSize: 16)),
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Phường/Xã",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    Text('Số nhà, tên đường', style: TextStyle(fontSize: 16)),
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Nhập số nhà, tên đường",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ],
          ),
        ),
        Step(
            state:
                activeStepIndex <= 1 ? StepState.editing : StepState.complete,
            isActive: activeStepIndex >= 1,
            title: Text('Thông tin'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FlutterToggleTab(
                    width: 75,
                    borderRadius: 30,
                    height: 40,
                    selectedTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
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
                    child:
                        Text('Tiện ích phòng', style: TextStyle(fontSize: 16)),
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
                                color:
                                    isSelectedWifi ? Colors.blue : Colors.grey),
                            //color: isSelected? Colors.blue : Colors.grey
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
                            color: isSelectedAirFresher
                                ? Colors.blue
                                : Colors.grey,
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
                  )
                ],
              ),
            )),
        Step(
          state: StepState.editing,
          isActive: activeStepIndex >= 2,
          title: Text('Xác nhận'),
          content: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Email Address'),
              ),
            ],
          ),
        ),
      ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: StyleAppBar(
          backgroundColor: kBackgroudColor,
          elevation: 0.3,
          height: 60,
          leading: InkWell(
            onTap: () {},
            child: Container(
              margin: EdgeInsetsDirectional.only(start: 5),
              child: ShaderMask(
                  child: Icon(
                    FontAwesomeIcons.heartBroken,
                    size: 42,
                    color: Colors.redAccent,
                  ),
                  blendMode: BlendMode.srcATop,
                  shaderCallback: (bounds) {
                    return LinearGradient(
                            colors: [
                          Colors.redAccent,
                          Colors.deepPurpleAccent,
                        ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            tileMode: TileMode.repeated)
                        .createShader(bounds);
                  }),
            ),
          ),
          title: Text(
            'Đăng tin',
            style: TextStyle(fontSize: 20.0, color: Colors.blue),
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.settings),
                color: Colors.grey,
                onPressed: () {
                  Navigator.of(context).pushNamed('/notification');
                })
          ],
        ),
        body: Stepper(
          type: StepperType.horizontal,
          currentStep: activeStepIndex,
          steps: stepList(),
          onStepContinue: () {
            if (activeStepIndex < (stepList().length)) {
              activeStepIndex += 1;
            }
            setState(() {});
          },
          onStepCancel: () {
            if (activeStepIndex == 0) {
              return;
            }
            activeStepIndex -= 1;
            setState(() {});
          },
        ));
  }
}
