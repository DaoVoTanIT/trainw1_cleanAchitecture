import 'package:clean_achitecture/Theme/color.dart';
import 'package:clean_achitecture/features/account/presentation/model/inforRoom.dart';
import 'package:clean_achitecture/features/room/data/repositories/data.dart';
import 'package:clean_achitecture/features/room/presentation/widget/inforRoomWiget.dart';
import 'package:clean_achitecture/features/room/presentation/widget/tabItem.dart';
import 'package:clean_achitecture/routes/route_name.dart';
import 'package:flutter/material.dart';

class Room extends StatefulWidget {
  @override
  _RoomState createState() => _RoomState();
}

final tabs = ['Nhà trọ', 'Bản đồ', 'Yêu thích', 'Tài khoản'];

class _RoomState extends State<Room> {
  int selectedPosition = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text('Tìm Phòng'),
        // ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: kPrimaryColorVariant,
          onPressed: () {},
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: _buildBottomTab(),
        body: _buildBodyRoom());
  }

  _buildBodyRoom() {
    // return GridView.count(
    //   crossAxisCount: 1,
    //   children: List.generate(50, (index) {
    //     return Container(
    //       child: Card(
    //           //color: Colors.,
    //           ),
    //     );
    //   }),
    //);

    return GridView(
      physics:
          BouncingScrollPhysics(), // if you want IOS bouncing effect, otherwise remove this line

      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2), //change the number as you want
    );
  }

  _buildBottomTab() {
    return BottomAppBar(
      color: kblueColor,
      shape: CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TabItem(
            text: tabs[0],
            icon: Icons.home,
            isSelected: selectedPosition == 0,
            onTap: () {
              // setState(() {
              //   selectedPosition = RouteName.homePage as int;
              // });
              Navigator.pushNamed(context, RouteName.homePage);
            },
          ),
          TabItem(
            text: tabs[1],
            icon: Icons.map_rounded,
            isSelected: selectedPosition == 1,
            onTap: () {
              // setState(() {
              //   selectedPosition = 1;
              // });
              Navigator.pushNamed(context, RouteName.searchMapPage);
            },
          ),
          SizedBox(
            width: 48,
          ),
          TabItem(
            text: tabs[2],
            icon: Icons.favorite,
            isSelected: selectedPosition == 2,
            onTap: () {
              // setState(() {
              //   //selectedPosition = 2;
              // });
              Navigator.pushNamed(context, RouteName.savedRoomPage);
            },
          ),
          TabItem(
            text: tabs[3],
            icon: Icons.person,
            isSelected: selectedPosition == 3,
            onTap: () {
              // setState(() {
              //   selectedPosition = 3;
              // });
              Navigator.pushNamed(context, RouteName.profilePage);
            },
          ),
        ],
      ),
    );
  }
}
