class ResGetCode {
  bool state;
  String message;

  ResGetCode({this.state = false, this.message = ""});

  ResGetCode.formJson(Map<String, dynamic> json)
      : state = json['isSuccess'] ?? false,
        message = json['message'] ?? "";
}
