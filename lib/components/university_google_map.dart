import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapSample extends StatefulWidget {
  Map<String, dynamic> place;
  MapSample({required this.place});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {

  @override
  Widget build(BuildContext context) {
    CameraPosition position = getCameraPosition(widget.place);
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
  CameraPosition getCameraPosition(Map<String, dynamic> place) {
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];
    return CameraPosition(target: LatLng(lat, lng), zoom: 15);
  }


}
