import 'package:cinema_app/config.dart';
import 'package:http/http.dart' as http;
class BaseUrl{
  static Future<http.Response> get(url) async{
    return await http.get(Uri.parse(url),
    headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          // Gửi token nếu cần
          'Authorization': 'Bearer ${Config.userInfo?.token}',
        },);
  }
}