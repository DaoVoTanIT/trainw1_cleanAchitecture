import 'package:clean_achitecture/features/Map/presentation/page/SearchMap.dart';
import 'package:clean_achitecture/features/Post/presentation/screen/Post.dart';
import 'package:clean_achitecture/features/account/presentation/page/account.dart';
import 'package:clean_achitecture/features/favorite/presentation/page/favorite.dart';
import 'package:clean_achitecture/features/room/presentation/page/Room.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class CurvedNavigationBarWidget extends StatefulWidget {
  const CurvedNavigationBarWidget({Key? key}) : super(key: key);

  @override
  _CurvedNavigationBarWidgetState createState() =>
      _CurvedNavigationBarWidgetState();
}

class _CurvedNavigationBarWidgetState extends State {
  GlobalKey _navKey = GlobalKey();

  var pagesAll = [
    RoomPage(),
    SearchMapPage(),
    PostPage(),
    FavoritePage(),
    ProfilePage()
  ];

  var myindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        height: 50,
        key: _navKey,
        items: [
          Icon((myindex == 0) ? Icons.home_outlined : Icons.home),
          Icon((myindex == 1) ? Icons.map : Icons.map_outlined),
          Icon((myindex == 2) ? Icons.add : Icons.add),
          Icon((myindex == 3) ? Icons.favorite_border : Icons.favorite),
          Icon((myindex == 4) ? Icons.people : Icons.people_alt)
        ],
        buttonBackgroundColor: Colors.white,
        onTap: (index) {
          setState(() {
            myindex = index;
          });
        },
        animationCurve: Curves.fastLinearToSlowEaseIn,
        color: Colors.blue,
      ),
      body: pagesAll[myindex],
    );
  }
}
