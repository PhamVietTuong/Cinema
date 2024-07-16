class SearchKey {
  String searchkey;
  bool isActor;

  SearchKey({this.searchkey = "", this.isActor = false});

  Map<String, dynamic> toJson() {
    return {
      'searchKey': searchkey,
      'isActor': isActor,
    };
  }
}
