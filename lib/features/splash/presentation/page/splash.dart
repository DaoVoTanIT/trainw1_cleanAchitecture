import 'package:clean_achitecture/LocalStoreKey.dart';
import 'package:clean_achitecture/common/Config.dart';
import 'package:clean_achitecture/features/sigin_signup/presentation/screen/login.dart';
import 'package:clean_achitecture/features/tab/presentation/screen/tab.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:splashscreen/splashscreen.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final LocalStorage storage = new LocalStorage(keyLocalStore);
  String token = '';
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () async {
      token = storage.getItem(LocalStoreKey.tokenUser);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 5,
      navigateAfterSeconds: token == null || token == ""
          ? SigninPage()
          : CurvedNavigationBarWidget(),
      title: new Text(
        'Chào mừng bạn đến với ứng dụng tìm phòng trọ',
        style: new TextStyle(fontWeight: FontWeight.w700, fontSize: 15.0),
      ),
      photoSize: 60.0,
      image: new Image.asset("assets/images/logo.png"),
      backgroundColor: Colors.white,
      loaderColor: Colors.blue,
    );
  }
}
