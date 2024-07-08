// ignore_for_file: avoid_print

import 'package:cinema_app/services/base_url.dart';

import '../../config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentRequest {
  String orderId;
  int amout;
  String des;
  String opt;

  PaymentRequest(this.orderId, this.amout, this.des, this.opt);
}

abstract class PaymentRepository {
  Future<String> createPayment(PaymentRequest paymentRequest);
}

class PaymentRepositoryIml implements PaymentRepository {
  @override
  Future<String> createPayment(PaymentRequest paymentRequest) async {
    String option = paymentRequest.opt.compareTo("momo") == 0
        ? "CreateLinkCheckoutMomo"
        : "VNPayCreatePayment";
    String api = '$serverUrl/api/Payments/$option';
    print("payment api: $api");

    final response = await http.post(Uri.parse(api),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "Amount": paymentRequest.amout,
          "OrderInfo": paymentRequest.des,
          "OrderId": paymentRequest.orderId
        }));

    if (response.statusCode == 200) {
      final dynamic json = jsonDecode(response.body);
      print(json["paymentUrl"]);
      return json["paymentUrl"];
    } else {
      throw Exception(
          'Failed to create payment url, status code: ${response.statusCode}');
    }
  }
}
