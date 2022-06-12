import 'package:clean_achitecture/Theme/color.dart';
import 'package:clean_achitecture/style/showdialog.dart';
import 'package:clean_achitecture/style/styleAppBar.dart';
import 'package:flutter/cupertino.dart';
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
    return CupertinoPageScaffold(
        backgroundColor: appBgColor,
        navigationBar: CupertinoNavigationBar(
          leading: Row(
            children: [
              GestureDetector(
                child: Row(
                  children: [
                    Icon(
                      CupertinoIcons.back,
                      color: CupertinoColors.activeBlue,
                      size: 25,
                    ),
                    Text(
                      "",
                      style: TextStyle(
                          color: CupertinoColors.activeBlue, fontSize: 16),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          middle: Text(
            "Phòng đã lưu",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        child: Scaffold());
  }
}
