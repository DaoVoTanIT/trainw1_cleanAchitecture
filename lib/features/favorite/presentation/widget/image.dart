// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:io';

import 'package:clean_achitecture/style/showdialog.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

// class AddImage extends StatefulWidget {
//   const AddImage({Key? key}) : super(key: key);

//   @override
//   _AddImageState createState() => _AddImageState();
// }

// class _AddImageState extends State<AddImage> {
//   File? _imageFile;
//   String imagePath = "";

//   Future<void> captureImage(ImageSource imageSource) async {
//     try {
//       final imageFile =
//           await ImagePicker.platform.pickImage(source: imageSource);
//       setState(() {
//         _imageFile = imageFile as File?;
//       });
//     } catch (e) {
//       print(e);
//     }
//   }

//   Widget _buildImage() {
//     if (_imageFile != null) {
//       return Image.file(_imageFile!);
//     } else {
//       return Text('Take an image to start', style: TextStyle(fontSize: 18.0));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Expanded(child: Center(child: _buildImage())),
//           _buildButtons(),
//         ],
//       ),
//     );
//   }

//   Widget _buildButtons() {
//     return ConstrainedBox(
//         constraints: BoxConstraints.expand(height: 80.0),
//         child: Row(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: <Widget>[
//               _buildActionButton(
//                 key: Key('retake'),
//                 text: 'Photos',
//                 onPressed: () => captureImage(ImageSource.gallery),
//               ),
//               _buildActionButton(
//                 key: Key('upload'),
//                 text: 'Camera',
//                 onPressed: () => captureImage(ImageSource.camera),
//               ),
//             ]));
//   }

//   Widget _buildActionButton(
//       {Key? key, required String text, Function()? onPressed}) {
//     return Expanded(
//       child: FlatButton(
//           key: key,
//           child: Text(text, style: TextStyle(fontSize: 20.0)),
//           shape: RoundedRectangleBorder(),
//           color: Colors.blueAccent,
//           textColor: Colors.white,
//           onPressed: onPressed),
//     );
//   }
// }

class AddImage extends StatefulWidget {
  const AddImage({Key? key}) : super(key: key);

  @override
  _AddImageState createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
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
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        materialOptions: MaterialOptions(
          actionBarTitle: "FlutterCorner.com",
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
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        body: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("Pick images"),
              onPressed: pickImages,
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                children: List.generate(images.length, (index) {
                  Asset asset = images[index];
                  return Stack(children: [
                    FlatButton(
                      onPressed: () {},
                      onLongPress: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return CustomDialogBox(
                                  title: 'Xoá ảnh',
                                  descriptions: 'Bạn có muốn xoá ảnh $index?',
                                  yes: 'Xoá',
                                  press: () {
                                    images.removeAt(index);
                                    setState(() {});
                                  });
                            });
                      },

                      //padding: EdgeInsets.all(6.0),
                      child: AssetThumb(
                        asset: asset,
                        width: 300,
                        height: 300,
                      ),
                    ),
                  ]);
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
  // final ImagePicker _imagePicker = ImagePicker();
  // List<XFile> _imageList = [];
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: SafeArea(
  //         child: Column(children: [
  //       OutlinedButton(
  //           onPressed: () {
  //             selectImage();
  //           },
  //           child: Text('Select Image')),
  //       Expanded(
  //         child: GridView.builder(
  //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //                 crossAxisCount: 3),
  //             itemCount: _imageList.length,
  //             itemBuilder: (BuildContext context, int index) {
  //               return Padding(
  //                 padding: const EdgeInsets.all(3.0),
  //                 child: Stack(fit: StackFit.expand, children: [
  //                   Image.file(
  //                     File(_imageList[index].path),
  //                     fit: BoxFit.cover,
  //                   ),
  //                   Container(
  //                     alignment: Alignment.topRight,
  //                     child: IconButton(
  //                         onPressed: () {
  //                           _imageList.removeAt(index);
  //                           setState(() {});

  //                         },
  //                         icon: Icon(
  //                           Icons.close,
  //                           color: Colors.red,
  //                           size: 35,
  //                         )),
  //                   ),
  //                 ]),
  //               );
  //             }),
  //       )
  //     ])),
  //   );
  // }

  // void selectImage() async {
  //   // final XFile? selected =
  //   //     await _imagePicker.pickImage(source: ImageSource.gallery);
  //   // if (selected!.path.isNotEmpty) {
  //   //   _imageList.add(selected); //if not empty then add to list
  //   // }
  //   // setState(() {});
  //   // print(selected.path.toString());
  // }
}
