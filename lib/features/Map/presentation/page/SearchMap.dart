import 'package:clean_achitecture/Theme/color.dart';
import 'package:clean_achitecture/features/room/data/RoomAPI.dart';
import 'package:clean_achitecture/features/room/model/RoomModel.dart';
import 'package:clean_achitecture/features/room/presentation/page/DetailRoomPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchMapPage extends StatefulWidget {
  const SearchMapPage({Key? key}) : super(key: key);

  @override
  _SearchMapPageState createState() => _SearchMapPageState();
}

class _SearchMapPageState extends State<SearchMapPage> {
  GoogleMapController? _mapController;
  String? buldingChoose;

  // LatLng _center = const LatLng(10.779785, 106.699020);

  final Location _location = Location();
  List<RoomModel> listRoom = [];
  RoomAPI roomAPI = RoomAPI();
  MapType _currentMapType = MapType.normal;
  final Map<String, Marker> _markers = {};
  static String? longtitude;
  static double? latitude;
  List<RoomModel> listRoomFilter = [];
  final items = [
    'Tất cả',
    'Quận 1',
    'Quận 2',
    'Quận 3',
    'Quận 4',
    'Quận 5',
    'Quận 6',
    'Quận 7',
    'Quận 8',
    'Quận 9',
    'Quận 10',
    'Quận 11',
    'Quận 12',
  ];
  //MapType _currentMapType = MapType.normal;
  //final Map<String, Marker> _markers = {};
  @override
  void initState() {
    setState(() {
      getListRoom();
    });
  }

  getListRoom() async {
    listRoom = await roomAPI.getListRoom();
    setState(() {});
  }

  filterByArea() {
    listRoomFilter = listRoom
        .where((element) => element.areaName!
            .toUpperCase()
            .contains(buldingChoose!.toUpperCase()))
        .toList();
    setState(() {
      // ignore: unrelated_type_equality_checks
      if (listRoomFilter != 0) {
        listRoom = listRoomFilter;
      }
    });
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _markers.clear();
    setState(() {
      for (int i = 0; i < listRoom.length; i++) {
        print("For Loop");
        final marker = Marker(
            markerId: MarkerId(listRoom[i].id.toString()),
            position: LatLng(double.parse(listRoom[i].latitude!),
                double.parse(listRoom[i].longitude!)),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueViolet,
            ),
            onTap: () {
              print("Clicked on marker");
              showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  builder: (builder) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DetailRoomPage(),
                            settings: RouteSettings(
                              arguments: listRoom[i],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        //  padding: EdgeInsets.only(top: 10, left: 7, right: 7),
                        height: 350,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 200,
                              decoration: BoxDecoration(
                                // borderRadius:
                                //     BorderRadius.all(Radius.circular(10)),
                                image: DecorationImage(
                                  image: NetworkImage(listRoom[i].imageMain),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(listRoom[i].subject.toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold
                                          // color: Colors.black,
                                          )),
                                  SizedBox(height: 5),
                                  Text('${listRoom[i].size} m2',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                      )),
                                  SizedBox(height: 5),
                                  Text(listRoom[i].priceString.toString(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      )),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.placemark,
                                        size: 20,
                                        color: Colors.grey,
                                      ),
                                      Expanded(
                                        child: Text('${listRoom[i].streetName}',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: CupertinoColors.systemRed,
                                            )),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            });
        _markers[listRoom[i].streetName.toString()] = marker;
      }
    });
  }

  @override
  bool get wantKeepAlive => true;

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
                    Image.asset(
                      "assets/images/logo.png",
                      fit: BoxFit.fill,
                      color: CupertinoColors.activeBlue,
                    )
                  ],
                ),
                onTap: () {},
              ),
            ],
          ),
          middle: Text(
            "Bản đồ",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        child: Scaffold(
            body: listRoom.isEmpty
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SafeArea(
                    child: Stack(
                      children: [
                        GoogleMap(
                          mapType: MapType.normal,
                          onMapCreated: _onMapCreated,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(double.parse(listRoom[0].latitude!),
                                double.parse(listRoom[0].longitude!)),
                            zoom: 15,
                          ),
                          myLocationEnabled: true,
                          myLocationButtonEnabled: true,
                          markers: _markers.values.toSet(),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Container(
                        //         width: MediaQuery.of(context).size.width * 0.8,
                        //         alignment: Alignment.center,
                        //         margin: EdgeInsets.symmetric(horizontal: 20),
                        //         height: 50,
                        //         decoration: BoxDecoration(
                        //           color: Colors.white,
                        //           borderRadius: BorderRadius.circular(20),
                        //           boxShadow: [
                        //             BoxShadow(
                        //               offset: Offset(0.0, 4.0),
                        //               color: Color(0xffe8f2ff),
                        //               blurRadius: 24.0,
                        //             ),
                        //           ],
                        //         ),
                        //         child: FormField<String>(
                        //           builder: (FormFieldState<String> state) {
                        //             return InputDecorator(
                        //               decoration: InputDecoration(
                        //                 contentPadding:
                        //                     const EdgeInsets.fromLTRB(
                        //                         12, 13, 20, 20),
                        //               ),
                        //               child: DropdownButtonHideUnderline(
                        //                 child: DropdownButton<String>(
                        //                   onTap: () {},
                        //                   style: const TextStyle(
                        //                     fontSize: 16,
                        //                     color: CupertinoColors.black,
                        //                     fontFamily: "verdana_regular",
                        //                   ),
                        //                   hint: const Text(
                        //                     "Bạn muốn tìm phòng trọ?",
                        //                     style: TextStyle(
                        //                       color: CupertinoColors.systemGrey,
                        //                       fontSize: 16,
                        //                       fontFamily: "verdana_regular",
                        //                     ),
                        //                   ),
                        //                   value: buldingChoose,
                        //                   isExpanded: true,
                        //                   isDense: true,
                        //                   onChanged: (newValue) {
                        //                     // Future.delayed(Duration.zero, () {
                        //                     //   getListRoom();
                        //                     // });

                        //                     setState(() {
                        //                       buldingChoose = newValue;
                        //                     });
                        //                     filterByArea();
                        //                   },
                        //                   items: items
                        //                       .map<DropdownMenuItem<String>>(
                        //                           (valueItem) {
                        //                     return DropdownMenuItem(
                        //                       value: valueItem,
                        //                       child: Row(
                        //                         children: [
                        //                           Text(valueItem),
                        //                         ],
                        //                       ),
                        //                     );
                        //                   }).toList(),
                        //                 ),
                        //               ),
                        //             );
                        //           },
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 60.0, right: 10.0),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: FloatingActionButton(
                              mini: true,
                              onPressed: () => {_onMapTypeButtonPressed()},
                              materialTapTargetSize:
                                  MaterialTapTargetSize.padded,
                              backgroundColor: Colors.white60,
                              child: Icon(
                                Icons.map_outlined,
                                // size: ScreenUtil().setWidth(20),
                                color: Colors.black87.withOpacity(0.7),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )));
  }

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }
}
