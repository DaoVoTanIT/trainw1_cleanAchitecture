import 'package:clean_achitecture/Theme/color.dart';
import 'package:clean_achitecture/features/room/data/repositories/data.dart';
import 'package:clean_achitecture/features/room/presentation/widget/item_card.dart';
import 'package:clean_achitecture/routes/route_name.dart';
import 'package:clean_achitecture/style/styleAppBar.dart';
import 'package:custom_grid_view/custom_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RoomPage extends StatefulWidget {
  @override
  _RoomPageState createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  int selectedPosition = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyleAppBar(
        backgroundColor: kBackgroudColor,
        elevation: 0.0,
        height: 60,
        leading: InkWell(
          onTap: () {},
          child: Container(
            margin: EdgeInsetsDirectional.only(start: 5),
            child: ShaderMask(
                child: Icon(
                  FontAwesomeIcons.infoCircle,
                  size: 30,
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
          'Phòng mới đăng',
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: GridView.builder(
                  itemCount: inforRoom.length,
                  scrollDirection: Axis.vertical,
                  addRepaintBoundaries: false,
                  physics: PageScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 15,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) => ItemCard(
                        room: inforRoom[index],
                        press: () {},
                      )),
            ),
          ],
        ),
      ),
    );

    // _buildBodyRoom() {
    //   return GridView.count(
    //     crossAxisCount: inforRoom.length,
    //     children: List.generate(100, (index) {
    //       return ItemCard(
    //         function: () {},
    //         room: inforRoom[index],
    //       );
    //     }),
    //   );

    // return CustomGridView(
    //   rows: 2,
    //   rowSpace: 0,
    //   children: [
    //     // Container(
    //     //   color: Colors.red,
    //     // ),
    //     // Container(
    //     //   color: Colors.blue,
    //     // ),
    //     // Container(
    //     //   color: Colors.blue,
    //     // ),
    //     // Container(
    //     //   color: Colors.red,
    //     // ),
    //     // Container(
    //     //   color: Colors.red,
    //     // ),
    //     // Container(
    //     //   color: Colors.blue,
    //     // ),
    //     // Container(
    //     //   color: Colors.blue,
    //     // ),
    //     // Container(
    //     //   color: Colors.red,
    //     // ),
    //     // Container(
    //     //   color: Colors.red,
    //     // ),
    //     // Container(
    //     //   color: Colors.blue,
    //     // ),
    //     // Container(
    //     //   color: Colors.blue,
    //     // ),
    //     // Container(
    //     //   color: Colors.red,
    //     // ),
    //     ItemCard(function: (){}, room: null,)
    //   ],
    // );
  }
}
