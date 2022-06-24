import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapRoomPage extends StatefulWidget {
  const MapRoomPage({Key? key}) : super(key: key);

  @override
  _MapRoomPageState createState() => _MapRoomPageState();
}

class _MapRoomPageState extends State<MapRoomPage> {
  static String? longtitude;
  static double? latitude;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      var arg = ModalRoute.of(context)!.settings.arguments as Map;
      longtitude = arg['longtitude'];
      latitude = arg["latitude"];
      setState(() {});
    });
  }

  GoogleMapController? _mapController;

  LatLng _center = LatLng(latitude!, double.parse(longtitude!));

  final Location _location = Location();

  MapType _currentMapType = MapType.normal;
  final Set<Marker> _markers = {};
  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _location.onLocationChanged.listen((event) {
      _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(latitude!, double.parse(longtitude!)), zoom: 20),
        ),
      );
    });
  }

  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(_center.toString()),
        position: _center,
        // infoWindow:
        //     InfoWindow(title: 'Nice Place', snippet: 'Welcome to Poland'),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  void _onCameraMove(CameraPosition position) {
    _center = position.target;
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // body: Stack(
        //   children: [
        //     GoogleMap(
        //       mapType: _currentMapType,
        //       onMapCreated: _onMapCreated,
        //       // myLocationButtonEnabled: true,
        //       // myLocationEnabled: true,
        //       markers: _markers,
        //       onCameraMove: _onCameraMove,
        //       initialCameraPosition: CameraPosition(
        //         target: _center,
        //         zoom: 11.0,
        //       ),
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.all(14.0),
        //       child: Align(
        //         alignment: Alignment.topRight,
        //         child: FloatingActionButton(
        //           onPressed: _onAddMarkerButtonPressed,
        //           materialTapTargetSize: MaterialTapTargetSize.padded,
        //           backgroundColor: Colors.green,
        //           child: const Icon(Icons.map, size: 30.0),
        //         ),
        //       ),
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.only(top: 60.0, right: 10.0),
        //       child: Align(
        //         alignment: Alignment.topRight,
        //         child: FloatingActionButton(
        //           mini: true,
        //           onPressed: () => {_onMapTypeButtonPressed()},
        //           materialTapTargetSize: MaterialTapTargetSize.padded,
        //           backgroundColor: Colors.white60,
        //           child: Icon(
        //             Icons.map_outlined,
        //             // size: ScreenUtil().setWidth(20),
        //             color: Colors.black87.withOpacity(0.7),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
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
