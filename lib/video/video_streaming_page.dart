import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VideoWebViewPage extends StatefulWidget {
  @override
  _VideoWebViewPageState createState() => _VideoWebViewPageState();
}

class _VideoWebViewPageState extends State<VideoWebViewPage> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition for Android to support embedded WebViews
    if (WebView.platform is WebViewPlatform) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 10, 19, 30),
        title: Text('97.7 Record FM',style: TextStyle(color: Colors.white),),
      ),
      body: WebView(
        initialUrl: 'https://player.castr.com/live_34f30f70f4f611edab1809312648496c', // Replace with your video URL
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController;
        },
      ),
    );
  }
}
