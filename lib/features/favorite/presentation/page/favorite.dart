import 'package:clean_achitecture/Theme/color.dart';
import 'package:clean_achitecture/style/showdialog.dart';
import 'package:clean_achitecture/style/styleAppBar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _SavedRoomPageState createState() => _SavedRoomPageState();
}

class _SavedRoomPageState extends State<FavoritePage> {
  List<Asset> images = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> pickImages() async {
    // ignore: deprecated_member_use
    List<Asset> resultList = [];

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: images,
        materialOptions: MaterialOptions(
          actionBarTitle: "Chọn ảnh",
        ),
      );
    } on Exception catch (e) {
      print(e);
    }

    setState(() {
      images = resultList;
    });
  }

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
                  FontAwesomeIcons.save,
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
          'Phòng đã lưu',
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
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
