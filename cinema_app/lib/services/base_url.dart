// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cinema_app/config.dart';
import 'package:http/http.dart' as http;

class BaseUrl {
  static Future<http.Response> get(String url) async {
    var uri = Uri.parse(url);
    var headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      // Kiểm tra và gửi token nếu có
      if (Config.userInfo?.token != null)
        'Authorization': 'Bearer ${Config.userInfo?.token}',
    };

    try {
      final response = await http.get(uri, headers: headers);
      return response;
    } catch (e) {
      // Xử lý lỗi ở đây nếu cần
      print('Error during GET request: $e');
      rethrow; // Tái ném lỗi để cho phép lớp gọi xử lý tiếp
    }
  }

  static Future<http.Response> post(String url, dynamic body,
      {File? file}) async {
    var uri = Uri.parse(url);
    var headers = <String, String>{
      // Nếu gửi file thì chỉ định loại nội dung của request
      'Content-Type': file != null
          ? 'multipart/form-data; boundary=<calculated when request is sent>'
          : 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${Config.userInfo?.token}',
    };

    try {
      if (file == null) {
        // Gửi dữ liệu JSON
        final response = await http.post(uri, headers: headers, body: body);
        return response;
      } else {
        // Nếu có file, sử dụng multipart để gửi dữ liệu kèm file
        var request = http.MultipartRequest('POST', uri);
        request.headers.addAll(headers);
        // Thêm dữ liệu vào request
        request.fields.addAll(body);
        // Thêm file vào request
        var fileStream = http.ByteStream(file.openRead());
        var length = await file.length();
        var multipartFile =
            http.MultipartFile('file', fileStream, length, filename: file.path);
        request.files.add(multipartFile);
        // Gửi request và nhận response
        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);
        return response;
      }
    } catch (e) {
      print('Error during POST request: $e');
      rethrow;
    }
  }

  // static Future<http.Response> put(String url, dynamic body) async {
  //   var uri = Uri.parse(url);
  //   var headers = <String, String>{
  //     'Content-Type': 'application/json; charset=UTF-8',
  //     if (Config.userInfo?.token != null)
  //       'Authorization': 'Bearer ${Config.userInfo?.token}',
  //   };

  //   try {
  //     final response = await http.put(uri, headers: headers, body: body);
  //     return response;
  //   } catch (e) {
  //     print('Error during PUT request: $e');
  //     rethrow;
  //   }
  // }

  // static Future<http.Response> delete(String url) async {
  //   var uri = Uri.parse(url);
  //   var headers = <String, String>{
  //     'Content-Type': 'application/json; charset=UTF-8',
  //     if (Config.userInfo?.token != null)
  //       'Authorization': 'Bearer ${Config.userInfo?.token}',
  //   };

  //   try {
  //     final response = await http.delete(uri, headers: headers);
  //     return response;
  //   } catch (e) {
  //     print('Error during DELETE request: $e');
  //     rethrow;
  //   }
  // }
}
