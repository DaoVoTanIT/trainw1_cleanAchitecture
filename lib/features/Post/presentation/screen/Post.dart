import 'package:clean_achitecture/Theme/color.dart';
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
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Email Address'),
                  ),
                ],
              ),
            )),
        Step(
          state: StepState.complete,
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
        //type: StepperType.horizontal,
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
      ),
    );
  }
}
