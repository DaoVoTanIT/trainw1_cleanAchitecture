import 'package:clean_achitecture/style/showdialog.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

class PostImage extends StatefulWidget {
  const PostImage({Key? key}) : super(key: key);

  @override
  _SavedRoomPageState createState() => _SavedRoomPageState();
}

class _SavedRoomPageState extends State<PostImage> {
  List<Asset> images = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> pickImages() async {
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
    return Column(
      children: <Widget>[
        ElevatedButton(
          child: Text("Chọn 6 ảnh"),
          onPressed: pickImages,
        ),
        GridView.count(
          crossAxisCount: 2,
          controller: new ScrollController(keepScrollOffset: false),
          shrinkWrap: true,
          //scrollDirection: Axis.vertical,
          children: List.generate(images.length, (index) {
            Asset asset = images[index];
            return Padding(
              padding: const EdgeInsets.all(2.0),
              child: Stack(children: [
                AssetThumb(
                  asset: asset,
                  width: 300,
                  height: 300,
                ),
                Positioned(
                    right: -10,
                    top: 5,
                    child: Container(
                      child: MaterialButton(
                        onPressed: () {
                          images.removeAt(index);
                          setState(() {});
                        },
                        color: Colors.blue,
                        textColor: Colors.white,
                        child: Icon(
                          Icons.close,
                          size: 20,
                        ),
                        padding: EdgeInsets.all(10),
                        shape: CircleBorder(),
                        //shape: CircleBorder(),
                      ),
                    ))
              ]),
            );
          }),
        )
      ],
    );
  }
}
