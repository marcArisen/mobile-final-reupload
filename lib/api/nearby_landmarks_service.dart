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

  final String key = "AIzaSyC5oNMyNUeWQpVObcQ5845M4884zRI6dTY";

  /// get nearby landmark around university
  Future<List<Landmark>> getNearby(String university) async {
    Map<String, dynamic> uniPlace = await LocationService().getPlace(university);

    double lat = uniPlace['geometry']['location']['lat'];
    double lng = uniPlace['geometry']['location']['lng'];

    print(lat);
    print(lng);
    String url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${lat},${lng}&radius=10000&type=restaurant&keyword=restaurant&key=${key}';
    http.Response response = await http.get(Uri.parse(url));
    final values = jsonDecode(response.body);
    final List result = values['results'];
    print(result);
    return result.map((e) => Landmark.fromJson(e)).toList();
  }
}
