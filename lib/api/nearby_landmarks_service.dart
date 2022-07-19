import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
  Future<List<Landmark>> getNearby(String university,String landmarkTpe) async {
    if (university == "Mahidol University"){
      university = "Mahidol University, Phutthamonthon";
    }

    Map<String, dynamic> uniPlace = await LocationService().getPlace(university);

    double lat = uniPlace['geometry']['location']['lat'];
    double lng = uniPlace['geometry']['location']['lng'];

    //print(lat);
    //print(lng);

    String url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&radius=10000&type=$landmarkTpe&keyword=$landmarkTpe&key=$key';
    //print(url);
    http.Response response = await http.get(Uri.parse(url));
    Map<String,dynamic> values = jsonDecode(response.body);
    List results = values['results'];

    /// A ist for marking landmark with null photo and one that permanently closed
    var toRemove = [];
    for (Map<String,dynamic> result in results){
      if(!result.containsKey("photos") || !(result["business_status"] == "OPERATIONAL") || !(result.containsKey("opening_hours"))){
        toRemove.add(result);
      }
      //print(result);
    }
    /// Removing the landmark with null photo
    results.removeWhere((element) => toRemove.contains(element));
    return results.map((e) => Landmark.fromJson(e)).toList();

  }

  /// Get image for each landmarks
  Image getImage(String photoReference){
    print(photoReference);
    String baseUrl = "https://maps.googleapis.com/maps/api/place/photo";
    String maxWidth = "400";
    String maxHeight = "200";
    String url = "$baseUrl?maxwidth=$maxWidth&maxHeight=$maxHeight&photoreference=$photoReference&key=$key";
    return Image.network(url, fit: BoxFit.fitHeight);
  }


   /// Get information for each landmarks by placeId
   Future<Map<String, dynamic>> getInfo(String placeId) async {
     final String url =
         "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key";
     print(url);
     var response = await http.get(Uri.parse(url));
     //print(response);
     var json = convert.jsonDecode(response.body);
     var results = json['result'] as Map<String, dynamic>;
     if(!results.containsKey("website")){
       results["website"] = "N/A";
     }if(!results.containsKey("formatted_phone_number")){
       results["formatted_phone_number"] = "N/A";
     }
     print(results["website"]);
     return results;
   }

   /// get nearby university from current location
   Future<List<Landmark>> getNearbyUni() async {
     var position = await Geolocator.getCurrentPosition(
         desiredAccuracy: LocationAccuracy.high);
     var lat = position.latitude;
     var lng = position.longitude;

     print(lat);
     print(lng);
     String url =
         'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&radius=10000&type=university&keyword=university&key=$key';
     //print(url);
     http.Response response = await http.get(Uri.parse(url));
     Map<String,dynamic> values = jsonDecode(response.body);
     List results = values['results'];

     /// A ist for marking landmark with null photo and one that permanently closed
     var toRemove = [];
     for (Map<String,dynamic> result in results){
       if(!result.containsKey("photos") || !(result["business_status"] == "OPERATIONAL") || !(result.containsKey("opening_hours"))){
         toRemove.add(result);
       }
       //print(result);
     }
     /// Removing the landmark with null photo
     results.removeWhere((element) => toRemove.contains(element));
     //print(results);
     return results.map((e) => Landmark.fromJson(e)).toList();

   }



}
