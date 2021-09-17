import 'package:clean_achitecture/features/Map/presentation/page/SearchMap.dart';
import 'package:clean_achitecture/features/account/presentation/page/account.dart';
import 'package:clean_achitecture/features/room/presentation/page/Room.dart';
import 'package:clean_achitecture/features/saveRoom/presentation/page/savedRoom.dart';
import 'package:clean_achitecture/features/sigin_signup/presentation/screen/login.dart';
import 'package:clean_achitecture/features/sigin_signup/presentation/screen/signup.dart';
import 'package:clean_achitecture/splash/presentation/page/splash.dart';
import 'package:flutter/material.dart';

class Routers {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'SplashPage':
        return MaterialPageRoute(builder: (context) => SplashPage());
      case 'LoginPage':
        return MaterialPageRoute(builder: (context) => SigninPage());
      case 'SignUpPage':
        return MaterialPageRoute(builder: (context) => SignUpPage());
      case 'HomePage':
        return MaterialPageRoute(builder: (context) => Room());
      case 'MapPage':
        return MaterialPageRoute(builder: (context) => SearchMap());
      case 'SavedRoomPage':
        return MaterialPageRoute(builder: (context) => SavedRoom());
      case 'ProfilePage':
        return MaterialPageRoute(builder: (context) => ProfilePage());
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
