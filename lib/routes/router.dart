import 'package:clean_achitecture/features/Home/presentation/page/HomeScreen.dart';
import 'package:clean_achitecture/features/sigin_signup/presentation/screen/login.dart';
import 'package:flutter/material.dart';

class Routers {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'LoginPage':
        return MaterialPageRoute(builder: (context) => LoginPage());
      case 'HomePage':
        return MaterialPageRoute(builder: (context) => HomePage());
      default:
        {
          return MaterialPageRoute(builder: (_) {
            return Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}')));
          });
        }
    }
  }
}
