import 'dart:convert';

class SearchKey {
  String searchkey;
  bool isActor;

  SearchKey({this.searchkey = "", this.isActor = false});

  // Chuyển đổi SearchKey thành Map
  Map<String, dynamic> toJson() {
    return {
      'searchKey': searchkey,
      'isActor': isActor,
    };
  }

  String toJsonString() => json.encode(toJson());

  factory SearchKey.fromMap(Map<String, dynamic> map) {
    return SearchKey(
      searchkey: map['searchKey'],
      isActor: map['isActor'],
    );
  }

  factory SearchKey.fromJsonString(String source) => SearchKey.fromMap(json.decode(source));
}
