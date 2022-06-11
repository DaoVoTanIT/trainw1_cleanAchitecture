import 'dart:async';
import 'package:clean_achitecture/features/tab/presentation/screen/tab.dart';
import 'package:clean_achitecture/routes/route_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  LoadingPage();

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  int start = 30;
  bool showReturnHome = false;
  late Timer _timer;
  returnhome() {
    Navigator.pushNamedAndRemoveUntil(context,
        RouteName.curvedNavigationBarWidget, (Route<dynamic> route) => false);
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          setState(() {
            showReturnHome = true;
            timer.cancel();
          });
        } else {
          setState(() {
            start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  initState() {
    super.initState();
    startTimer();
  }

  Widget loadingpage() {
    return Stack(fit: StackFit.expand, children: [
      Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/images/logoLoading.png',
                      width: 70, height: 70, fit: BoxFit.cover),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Đang xử lý ...',
                      style: new TextStyle(
                          fontSize: 13.0, color: CupertinoColors.black)),
                  new Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                  ),
                  CupertinoActivityIndicator(
                    animating: true,
                    radius: 10,
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            alignment: FractionalOffset.bottomCenter,
            child: Column(
              children: [
                Text("v.1.1"),
                SizedBox(
                  height: 5,
                ),
                Image.asset('assets/images/logoLoading.png',
                    width: 180, height: 30, fit: BoxFit.fill),
              ],
            ),
          ),
        ],
      ),
    ]);
  }

  Widget returnHomePage() {
    return Stack(fit: StackFit.expand, children: [
      Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
                child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/images/logoLoading.png',
                    width: 70, height: 70, fit: BoxFit.cover),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                ),
                Text('Không có kết nối internet...',
                    style: new TextStyle(
                        fontSize: 13.0, color: CupertinoColors.black)),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                ),
                Text('Vui lòng kiểm tra lại internet',
                    style: new TextStyle(
                        fontSize: 13.0, color: CupertinoColors.black)),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 30),
                ),
                CupertinoButton.filled(
                    child: Text(
                      "Trở về Trang chủ",
                      style:
                          TextStyle(fontSize: 16, color: CupertinoColors.white),
                    ),
                    onPressed: () {
                      returnhome();
                    }),
              ],
            )),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            alignment: FractionalOffset.bottomCenter,
            child: Column(
              children: [
                Text("v.1.1"),
                SizedBox(
                  height: 5,
                ),
                // Image.asset('assets/images/logoCompany.jpg',
                //     width: 180, height: 30, fit: BoxFit.fill),
              ],
            ),
          ),
        ],
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.white,
      body: new InkWell(
        child: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Expanded(
                    flex: 2,
                    child: showReturnHome == true
                        ? returnHomePage()
                        : loadingpage()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
