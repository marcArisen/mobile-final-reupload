import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class LocationService {
  final String key = "AIzaSyBXlhhKA3oCZJgTkcOdeuXIV4PyRewZ_G8";

  /// get the id of the university location
  Future<String> getPlaceId(String university) async {
    final String url =
        "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$university&inputtype=textquery&key=$key";
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var placeId = json['candidates'][0]['place_id'] as String;
    return placeId;
  }
  /// get the place based on university name
  Future<Map<String, dynamic>> getPlace(String university) async {
    final placeId = await getPlaceId(university);
    final String url =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key";
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var results = json['result'] as Map<String, dynamic>;
    return results;
  }

  Future<double> getRating(String university) async{
    final results = await getPlace(university);

    if (!results.containsKey("rating")){
      results["rating"] = 0.0;
    }
    return results["rating"];
  }
}
