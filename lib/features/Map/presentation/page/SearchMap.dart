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

  // LatLng _center = const LatLng(10.779785, 106.699020);

  final Location _location = Location();
  List<RoomModel> listRoom = [];
  RoomAPI roomAPI = RoomAPI();
  MapType _currentMapType = MapType.normal;
  final Map<String, Marker> _markers = {};
  static String? longtitude;
  static double? latitude;
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
          },
        );
        _markers[listRoom[i].streetName.toString()] = marker;
      }
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  //   padding: const EdgeInsets.all(14.0),
                  //   child: Align(
                  //     alignment: Alignment.topRight,
                  //     child: FloatingActionButton(
                  //       onPressed: _onAddMarkerButtonPressed,
                  //       materialTapTargetSize: MaterialTapTargetSize.padded,
                  //       backgroundColor: Colors.green,
                  //       child: const Icon(Icons.map, size: 30.0),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(top: 60.0, right: 10.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: FloatingActionButton(
                        mini: true,
                        onPressed: () => {_onMapTypeButtonPressed()},
                        materialTapTargetSize: MaterialTapTargetSize.padded,
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
            ),
    );
  }

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }
}
//     );
//   }
// }
