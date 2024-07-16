import 'dart:convert';

import 'package:cinema_app/config.dart';
import 'package:cinema_app/services/base_url.dart';

class News {
  String id;
  String title;
  String content;
  bool status;
  DateTime createAt;
  String image;
  DateTime updatedAt;
  News({
    this.id = "",
    this.title = "",
    this.content = "",
    this.status = true,
    DateTime? createAt,
    this.image = "",
    DateTime? updatedAt,
  })  : createAt = createAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  News.fromJson(Map<String, dynamic> json)
      : id = json["id"] ?? "",
        title = json["title"] ?? "",
        content = json["content"] ?? "",
        status = json["status"] ?? true,
        createAt = json["createAt"] != null
            ? DateTime.parse(json["createAt"])
            : DateTime.now(),
        image = json["image"] ?? "",
        updatedAt = json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "content": content,
      "status": status,
      "createAt": createAt.toIso8601String(),
      "image": image,
      "updatedAt": updatedAt.toIso8601String(),
    };
  }
}

abstract class NewRepository {
  Future<List<News>> getNewModels();
}

class NewRepositoryImpl implements NewRepository {
  @override
  Future<List<News>> getNewModels() async {
    final url =
        '$serverUrl/api/Cinemas/GetNewsList';
    final response = await BaseUrl.get(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch news models');
    }

    final List<dynamic> newModelJsonList = jsonDecode(response.body);
    return newModelJsonList.map((json) => News.fromJson(json)).toList();
  }
}
