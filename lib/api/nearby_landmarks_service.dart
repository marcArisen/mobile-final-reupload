import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project2_mobile_app/api/university_location_service.dart';
import 'dart:convert';
import '../model/landmark_model.dart';

class NearbyLocationService {
   static NearbyLocationService? _instance;

    NearbyLocationService._();

   static NearbyLocationService? get instance {
    _instance ??= NearbyLocationService._();
    return _instance;
  }

  final String key = "AIzaSyBXlhhKA3oCZJgTkcOdeuXIV4PyRewZ_G8";

  /// get nearby landmark around university
  Future<List<Landmark>> getNearby(String university) async {
    Map<String, dynamic> uniPlace = await LocationService().getPlace(university);

    double lat = uniPlace['geometry']['location']['lat'];
    double lng = uniPlace['geometry']['location']['lng'];

    print(lat);
    print(lng);

    String url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&radius=10000&type=restaurant&keyword=restaurant&key=$key';
    http.Response response = await http.get(Uri.parse(url));
    Map<String,dynamic> values = jsonDecode(response.body);
    List results = values['results'];
    for (Map<String,dynamic> r in results){
      //print(r["photos"]);
      //print(r);
      if(!r.containsKey("photos")){
        String dummyPhoto = "AeJbb3du7IOQPnc57VpMI4KUPuRt_5ivw3GouSaaeMh8IbRtpTta2WkrrZNenb3Nyj6ndK6FU4v9zqxwVjzg_mDkVlMi3dWKOweF6Ag0y6HlWHla936VDztEPudtxyqDnPlsN4HgQEqP_tAOcUSnKF-pT4GqLFOm4dXDZXsEUrVNKNPQAA-1";
        r["photos"][0] = [{"photo_reference" : dummyPhoto}];
      }
    }
    for (Map<String,dynamic> result in results){
      print(result["photos"][0]["photo_reference"]);
    }
    //print(result[0]["photo_reference"]);
    return results.map((e) => Landmark.fromJson(e)).toList();
  }


  /// get image for each landmarks
  Image getImage(String photoReference){
    print(photoReference);
    String baseUrl = "https://maps.googleapis.com/maps/api/place/photo";
    String maxWidth = "400";
    String maxHeight = "200";
    String url = "$baseUrl?maxwidth=$maxWidth&maxHeight=$maxHeight&photoreference=$photoReference&key=$key";
    return Image.network(url);
  }


   /// get information for each landmarks by placeId
   Future<Map<String, dynamic>> getInfo(String placeId) async {
     final String url =
         "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key";
     var response = await http.get(Uri.parse(url));
     var json = convert.jsonDecode(response.body);
     var results = json['result'] as Map<String, dynamic>;
     //print(results);
     return results;
   }


}
