import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

import '../../components/count_down.dart';


class WebPageView extends StatefulWidget {
  const WebPageView({super.key, required this.url, required this.callback});
  final String url;
  final void Function(int state) callback;
  @override
  State<WebPageView> createState() => _WebPageViewState();
}

class _WebPageViewState extends State<WebPageView> {
  late String url;
  Stream<int> get countStream async* {
    while (true) {
      await Future.delayed(Duration(seconds: 1));
      yield CountDown.time;
    }
  }

  late StreamSubscription<int> subscription;
  int counter = 0;
  @override
  void initState() {
    super.initState();
    CountDown.index=5;
    subscription = countStream.listen((_count) {
    
          if (CountDown.time == 0&&CountDown.index==5) {
        Navigator.of(context).popUntil((route) {
          return counter++ >= 5 || !Navigator.of(context).canPop();
        });
      }
    });
    url = widget.url;
    // Thiết lập để WebView hoạt động trên Android
    // Thiết lập để WebView hoạt động trên ios
  }
@override
  void dispose() {
    super.dispose();
    subscription.cancel();
    CountDown.index--;
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
                if (request.url.contains("VNPayReturn")) {
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
