import 'package:clean_achitecture/Theme/color.dart';
import 'package:clean_achitecture/style/styleAppBar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostRoomPage extends StatefulWidget {
  const PostRoomPage({Key? key}) : super(key: key);

  @override
  _PostRoomPageState createState() => _PostRoomPageState();
}

class _PostRoomPageState extends State<PostRoomPage> {
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
      body: Text('post'),
    );
  }
}