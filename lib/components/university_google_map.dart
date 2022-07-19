import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class LocationMap extends StatefulWidget {
  Map<String, dynamic> place;
  LocationMap({required this.place});

  @override
  State<LocationMap> createState() => LocationMapState();
}

class LocationMapState extends State<LocationMap> {

  @override
  Widget build(BuildContext context) {
    List<Marker> markers = <Marker>[];
    markers.add(
        Marker(markerId: MarkerId("Hi"),
            position: LatLng(widget.place['geometry']['location']['lat'],widget.place['geometry']['location']['lng']) ));

    CameraPosition position = getCameraPosition(widget.place);
    return Container(
      height: 300,
      width: 300,
      child: GoogleMap(
        markers: Set<Marker>.of(markers),
        mapType: MapType.normal,
        initialCameraPosition: position,
      ),

    );
  }

  /// get camera position to be display in GoogleMap
  CameraPosition getCameraPosition(Map<String, dynamic> place) {
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];
    return CameraPosition(target: LatLng(lat, lng), zoom: 15);
  }


}
