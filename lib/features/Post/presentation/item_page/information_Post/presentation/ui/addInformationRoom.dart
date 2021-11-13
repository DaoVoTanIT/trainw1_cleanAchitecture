import 'package:clean_achitecture/features/Post/presentation/item_page/information_Post/presentation/widget/Utilities_room.dart';
import 'package:clean_achitecture/features/Post/presentation/item_page/information_Post/presentation/widget/postImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostInformation extends StatefulWidget {
  const PostInformation({Key? key}) : super(key: key);

  @override
  _PostInformationState createState() => _PostInformationState();
}

class _PostInformationState extends State<PostInformation> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FlutterToggleTab(
            width: 75,
            borderRadius: 30,
            height: 40,
            selectedTextStyle: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
            unSelectedTextStyle: TextStyle(
                color: Colors.black87,
                fontSize: 14,
                fontWeight: FontWeight.w500),
            labels: ["Phòng", "Căn hộ", "Nguyên căn"],
            selectedLabelIndex: (index) {
              setState(() {
                counter = index;
              });
              print("Selected Index $index");
            },
            selectedIndex: counter,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Giá phòng(VND)', style: TextStyle(fontSize: 16)),
                Text('Diện tích(m2)', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: <Widget>[
                Flexible(
                    child: Container(
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "3.000.000",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                )),
                SizedBox(width: 10),
                Flexible(
                    child: Container(
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "20",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Tiện ích phòng', style: TextStyle(fontSize: 16)),
          ),
          UtilitiesRoom(),
          PostImage()
        ],
      ),
    );
  }
}
