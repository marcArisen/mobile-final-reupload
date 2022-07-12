import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class LandmarkLocationMap extends StatefulWidget {
  dynamic lat;
  dynamic lng;
  LandmarkLocationMap({this.lat,this.lng});

  @override
  State<LandmarkLocationMap> createState() => LandmarkLocationMapState();
}

class LandmarkLocationMapState extends State<LandmarkLocationMap> {

  @override
  Widget build(BuildContext context) {
    CameraPosition position = getCameraPosition(widget.lat,widget.lng);
    return SizedBox(
      height: 300,
      width: 300,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: position,
      )
    );
  }

  /// get camera position to be display in GoogleMap
  CameraPosition getCameraPosition(dynamic lat, dynamic lng) {
    return CameraPosition(target: LatLng(lat, lng), zoom: 15);
  }


}
