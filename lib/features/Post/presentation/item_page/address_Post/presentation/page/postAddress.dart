import 'package:clean_achitecture/features/Post/presentation/item_page/address_Post/domain/entity/distric.dart';
import 'package:clean_achitecture/features/Post/presentation/item_page/address_Post/domain/entity/ward.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';

class PostAddress extends StatefulWidget {
  const PostAddress({Key? key}) : super(key: key);

  @override
  _PostAddressState createState() => _PostAddressState();
}

class _PostAddressState extends State<PostAddress> {
  late String countryValue;
  late String stateValue;
  late String cityValue;
  late Ward ward;
  String? _selectionDistrict;
  String? _selectionWard;
  List dataD = [];
  List dataW = []; //edited line

  Future<String> getDataDistict() async {
    final assetBundle = DefaultAssetBundle.of(context);
    final data = await assetBundle.loadString('assets/json/district.json');
    final body = json.decode(data);
    setState(() {
      dataD = body;
    });
    return body.map<District>(District.fromJson).toList();
  }

  Future<String> getDataWard() async {
    final assetBundle = DefaultAssetBundle.of(context);
    final data = await assetBundle.loadString('assets/json/ward.json');
    final body = json.decode(data);
    setState(() {
      dataW = body;
    });
    return body.map<Ward>(Ward.fromJson(json)).toList();
  }

  @override
  void initState() {
    super.initState();
    this.getDataDistict();
    this.getDataWard();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Chọn Tỉnh/TP', style: TextStyle(fontSize: 16)),
            Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.add_location, color: Colors.blue)),
                Text('Vị trí hiện tại', style: TextStyle(color: Colors.blue))
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Chọn Quận/Huyện', style: TextStyle(fontSize: 16)),
        ),
        DropdownButtonFormField(
          decoration: InputDecoration(
            // enabledBorder: OutlineInputBorder(
            //   borderSide: BorderSide(color: Colors.blue, width: 2),
            //   borderRadius: BorderRadius.circular(10),
            // ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            filled: true,
          ),
          hint: Text('Chọn quận/huyện'),
          onChanged: (newVal) {
            setState(() {
              _selectionDistrict = newVal! as String?;
            });
          },
          value: _selectionDistrict,
          items: dataD.map((item) {
            return new DropdownMenuItem(
              child: new Text(item['name'].toString()),
              value: item['id_District'].toString(),
            );
          }).toList(),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Phường/Xã', style: TextStyle(fontSize: 16)),
        ),
        DropdownButtonFormField(
          decoration: InputDecoration(
            // enabledBorder: OutlineInputBorder(
            //   borderSide: BorderSide(color: Colors.blue, width: 2),
            //   borderRadius: BorderRadius.circular(20),
            // ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            filled: true,
          ),
          hint: Text('Chọn phường/xã'),
          onChanged: (newVal) {
            setState(() {
              _selectionWard = newVal! as String?;
            });
          },
          value: _selectionWard,
          items: dataW.map((item) {
            return new DropdownMenuItem(
              child: new Text(item['name'].toString()),
              value: item['id_Ward'].toString(),
            );
          }).toList(),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Số nhà, tên đường', style: TextStyle(fontSize: 16)),
        ),
        TextFormField(
          decoration: InputDecoration(
              hintText: "Nhập số nhà, tên đường",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        ),
      ],
    );
  }
}
