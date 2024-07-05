import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;


class WebPageView extends StatefulWidget {
  const WebPageView({super.key, required this.url, required this.callback});
  final String url;
  final void Function(int state) callback;
  @override
  State<WebPageView> createState() => _WebPageViewState();
}

class _WebPageViewState extends State<WebPageView> {
  late String url;
  @override
  void initState() {
    super.initState();
    url = widget.url;
    // Thiết lập để WebView hoạt động trên Android
    // Thiết lập để WebView hoạt động trên ios
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thanh Toán'),
        leading:const SizedBox(),
        centerTitle: true,
      ),
      body: WebViewWidget(
        controller: WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setBackgroundColor(const Color(0x00000000))
          ..setNavigationDelegate(
            NavigationDelegate(
              onProgress: (int progress) {
                // Update loading bar.
              },
              onPageStarted: (String url) {},
              onPageFinished: (String url) {},
              onHttpError: (HttpResponseError error) {},
              onWebResourceError: (WebResourceError error) {},
              onNavigationRequest: (NavigationRequest request) async {
                if (request.url.contains("VNPayReturn")||request.url.contains("MomoIpn")) {
                  final response = await http.get(Uri.parse(request.url));
                  dynamic json = jsonDecode(response.body);
                  int state = 1;
                  if (json["RspCode"] != "00") state = 2;
                  widget.callback(state);
                  // ignore: use_build_context_synchronously
                  Navigator.pop(this.context);
                }
                return NavigationDecision.navigate;
              },
            ),
          )
          ..loadRequest(Uri.parse(url)),
      ),
    );
  }
}
