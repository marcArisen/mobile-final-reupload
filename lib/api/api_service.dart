import 'package:http/http.dart' as http;
import 'package:project2_mobile_app/api/api_constants.dart';
import 'package:project2_mobile_app/model/student_model.dart';

class ApiService {
  Future<List<StudentModel>?> getStudents() async {
    try {
      var url = Uri.parse(ApiConstants.studentsUrl);
      var response = await http.get(url, headers: {'api-key': '1g4NXdQKLQ2DnZnaEK5CdchX87z8C97L'} );
      if (response.statusCode == 200) {
        List<StudentModel> _model = studentModelFromJson(response.body);
        return _model;
      }
    }
    catch (e){
      print(e.toString());
    }
    return null;
  }
}