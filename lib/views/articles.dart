import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  // const ArticleView({Key? key}) : super(key: key);

  final String blogUrl;
  ArticleView({required this.blogUrl});
  bool _loading = true;

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {


  // final Completer<WebViewContoller> _completer = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    // final String artUrl =  blogUrl;
    var controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
    // "https://www.youtube.com/"
      ..loadRequest(Uri.parse(widget.blogUrl));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Only",
              style: TextStyle(color: Colors.grey),
            ),
            Text(
              "News",
              style: TextStyle(color: Colors.blue),
            )
          ],
        ),
        actions: <Widget>[
          Opacity(
              opacity: 0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.save),),
          )
        ],
        centerTitle: true,
        elevation: 0.0,
      ),
      body:Container(
      child:(
      WebViewWidget(
          controller: controller
      )),
      )



    );
  }
}
