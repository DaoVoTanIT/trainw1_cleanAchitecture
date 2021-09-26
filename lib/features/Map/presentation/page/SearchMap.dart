import 'package:clean_achitecture/Theme/color.dart';
import 'package:clean_achitecture/routes/route_name.dart';
import 'package:clean_achitecture/style/styleAppBar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class SearchMapPage extends StatefulWidget {
  const SearchMapPage({Key? key}) : super(key: key);

  @override
  _SearchMapPageState createState() => _SearchMapPageState();
}

class _SearchMapPageState extends State<SearchMapPage> {
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  // appBar: StyleAppBar(
  //   backgroundColor: kBackgroudColor,
  //   elevation: 0.3,
  //   height: 60,
  //   leading: InkWell(
  //     onTap: () {},
  //     child: Container(
  //       margin: EdgeInsetsDirectional.only(start: 5),
  //       child: ShaderMask(
  //           child: Icon(
  //             FontAwesomeIcons.heartBroken,
  //             size: 42,
  //             color: Colors.redAccent,
  //           ),
  //           blendMode: BlendMode.srcATop,
  //           shaderCallback: (bounds) {
  //             return LinearGradient(
  //                     colors: [
  //                   Colors.redAccent,
  //                   Colors.deepPurpleAccent,
  //                 ],
  //                     begin: Alignment.bottomCenter,
  //                     end: Alignment.topCenter,
  //                     tileMode: TileMode.repeated)
  //                 .createShader(bounds);
  //           }),
  //     ),
  //   ),
  //   title: Text(
  //     'Phòng quanh đây',
  //     style: TextStyle(fontSize: 20.0, color: Colors.blue),
  //   ),
  //   actions: [
  //     IconButton(
  //         icon: Icon(Icons.settings),
  //         color: Colors.grey,
  //         onPressed: () {
  //           Navigator.of(context).pushNamed('/notification');
  //         })
  //   ],
  // ),
  // body: Center(
  //   child: Text('Map'),
  // ),
  GoogleMapController? _mapController;

  LatLng _center = const LatLng(10.779785, 106.699020);

  final Location _location = Location();

  MapType _currentMapType = MapType.normal;
  final Set<Marker> _markers = {};
  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _location.onLocationChanged.listen((event) {
      _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(event.latitude!, event.longitude!), zoom: 11),
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
      // appBar: StyleAppBar(
      //   backgroundColor: kBackgroudColor,
      //   elevation: 0.3,
      //   height: 60,
      //   leading: InkWell(
      //     onTap: () {},
      //     child: Container(
      //       margin: EdgeInsetsDirectional.only(start: 5),
      //       child: ShaderMask(
      //           child: Icon(
      //             FontAwesomeIcons.heartBroken,
      //             size: 42,
      //             color: Colors.redAccent,
      //           ),
      //           blendMode: BlendMode.srcATop,
      //           shaderCallback: (bounds) {
      //             return LinearGradient(
      //                     colors: [
      //                   Colors.redAccent,
      //                   Colors.deepPurpleAccent,
      //                 ],
      //                     begin: Alignment.bottomCenter,
      //                     end: Alignment.topCenter,
      //                     tileMode: TileMode.repeated)
      //                 .createShader(bounds);
      //           }),
      //     ),
      //   ),
      //   title: Text(
      //     'Phòng quanh đây',
      //     style: TextStyle(fontSize: 20.0, color: Colors.blue),
      //   ),
      //   actions: [
      //     IconButton(
      //         icon: Icon(Icons.settings),
      //         color: Colors.grey,
      //         onPressed: () {
      //           Navigator.of(context).pushNamed('/notification');
      //         })
      //   ],
      // ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: _currentMapType,
            onMapCreated: _onMapCreated,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            markers: _markers,
            onCameraMove: _onCameraMove,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Align(
              alignment: Alignment.topRight,
              child: FloatingActionButton(
                onPressed: _onAddMarkerButtonPressed,
                materialTapTargetSize: MaterialTapTargetSize.padded,
                backgroundColor: Colors.green,
                child: const Icon(Icons.map, size: 30.0),
              ),
            ),
          ),
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
