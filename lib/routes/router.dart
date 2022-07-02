import 'package:clean_achitecture/features/Map/presentation/page/SearchMap.dart';
import 'package:clean_achitecture/features/MyRoom/presentation/MyRoom.dart';
import 'package:clean_achitecture/features/account/presentation/page/account.dart';
import 'package:clean_achitecture/features/favorite/presentation/page/favorite.dart';
import 'package:clean_achitecture/features/room/presentation/page/Room.dart';
import 'package:clean_achitecture/features/sigin_signup/presentation/screen/login.dart';
import 'package:clean_achitecture/features/sigin_signup/presentation/screen/signup.dart';
import 'package:clean_achitecture/features/splash/presentation/page/splash.dart';
import 'package:clean_achitecture/features/tab/presentation/screen/tab.dart';
import 'package:flutter/material.dart';

import '../features/room/presentation/page/DetailRoomPage.dart';
import '../features/room/presentation/page/MapRoom.dart';

class Routers {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'SplashPage':
        return MaterialPageRoute(builder: (context) => SplashPage());
      case 'LoginPage':
        return MaterialPageRoute(builder: (context) => SigninPage());
      case 'SignUpPage':
        return MaterialPageRoute(builder: (context) => SignUpPage());
      case 'CurvedNavigationBarWidget':
        return MaterialPageRoute(
            builder: (context) => CurvedNavigationBarWidget());
      case 'HomePage':
        return MaterialPageRoute(builder: (context) => RoomPage());
      case 'MapPage':
        return MaterialPageRoute(builder: (context) => SearchMapPage());
      case 'SavedRoomPage':
        return MaterialPageRoute(builder: (context) => FavoritePage());
      case 'ProfilePage':
        return MaterialPageRoute(builder: (context) => ProfilePage());
      case 'DetailRoomPage':
        return MaterialPageRoute(builder: (context) => DetailRoomPage());
      case 'MapRoomPage':
        return MaterialPageRoute(builder: (context) => MapRoomPage());
      case 'MyRoomPage':
        return MaterialPageRoute(builder: (context) => MyRoomPage());
      // case 'MapRoomPage':
      //   return MaterialPageRoute(builder: (context) => MapRoomPage());
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
