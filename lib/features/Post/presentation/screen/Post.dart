import 'package:clean_achitecture/Theme/color.dart';
import 'package:clean_achitecture/features/Post/presentation/item_page/address_Post/presentation/page/postAddress.dart';
import 'package:clean_achitecture/features/Post/presentation/item_page/information_Post/presentation/ui/addInformationRoom.dart';
import 'package:clean_achitecture/style/styleAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
          controlsBuilder: (BuildContext context, ControlsDetails controls) {
            return Row(
              children: <Widget>[
                TextButton(
                  onPressed: controls.onStepCancel,
                  child: const Text(
                    'Quay lại',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                TextButton(
                  onPressed: controls.onStepContinue,
                  child: const Text(
                    'Tiếp',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            );
          },
          steps: [
            Step(
              state:
                  activeStepIndex <= 0 ? StepState.editing : StepState.complete,
              isActive: activeStepIndex >= 0,
              title: Text('Vị trí'),
              content: PostAddress(),
            ),
            Step(
                state: activeStepIndex <= 1
                    ? StepState.editing
                    : StepState.complete,
                isActive: activeStepIndex >= 1,
                title: Text('Thông tin'),
                content: PostInformation()),
            Step(
                state: StepState.editing,
                isActive: activeStepIndex >= 2,
                title: Text('Xác nhận'),
                content: Text('hi'))
          ],
          onStepContinue: () {
            if (activeStepIndex <= 3) {
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
