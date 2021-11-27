import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class LubyGray extends StatefulWidget {
    final double? width;
    final double? height;

    LubyGray({
        Key? key,
        this.width,
        this.height,
    }): super(key: key);

  @override
  _LubyGrayState createState() => new _LubyGrayState();
}

class _LubyGrayState extends State<LubyGray> {
  final _key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    if (kIsWeb || (!Platform.isAndroid && !Platform.isIOS)) {
      return Text(
        "SVGator's Flutter animations run only on Android or iOS",
        textAlign: TextAlign.center,
      );
    } else {
      return Container(
        width: this.widget.width,
        height: this.widget.height,
        child: WebView(
                key: _key,
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: 'about:blank',
                onWebViewCreated: (WebViewController webViewController) {
                    _loadHtmlFromAssets(webViewController);
                },
            )
        );
    }
  }
  _loadHtmlFromAssets(webViewController) async {
    String Svg = "<svg id=\"eVJ5UTLqMvC1\" xmlns=\"http:\/\/www.w3.org\/2000\/svg\" xmlns:xlink=\"http:\/\/www.w3.org\/1999\/xlink\" viewBox=\"0 0 34.02 29.328\" shape-rendering=\"geometricPrecision\" text-rendering=\"geometricPrecision\"><g id=\"eVJ5UTLqMvC2\" transform=\"matrix(1 0 0 1 -491.44101 -175.205002)\"><circle id=\"eVJ5UTLqMvC3\" r=\"1.804\" transform=\"matrix(1 0 0 1 504.319991 189.912994)\" fill=\"rgb(119,119,119)\" stroke=\"none\" stroke-width=\"1\"\/><circle id=\"eVJ5UTLqMvC4\" r=\"1.804\" transform=\"matrix(1 0 0 1 511.79399 189.912994)\" fill=\"rgb(119,119,119)\" stroke=\"none\" stroke-width=\"1\" stroke-dasharray=\"11.33\"\/><\/g><path id=\"eVJ5UTLqMvC5\" d=\"M27.891,29.328C27.647644,29.329359,27.406173,29.285271,27.179,29.198L22.438,27.398L18.075,29.184C17.609632,29.37059,17.090894,29.374163,16.623,29.194L12.088,27.494L7.724,29.194C7.262206,29.370029,6.751794,29.370029,6.29,29.194L0.667,26.561C0.259934,26.369877,0.000009,25.960701,0,25.511L0,18.585C0,16.34,0.016,14.977,0.023,14.5C0.123,7.786,3.531,3.85,9.376,3.7C10.765392,3.684759,12.139053,3.99504,13.387,4.606C14.581717,2.388405,16.676079,0.79494,19.132,0.235C20.094129,0.090099,21.06509,0.01158,22.038,0C24.680456,-0.052461,27.258365,0.818985,29.327,2.464C32.127,4.735,33.67,8.23,33.927,12.854Q34.02,14.526,34.019,16.154L33.986,25.126C33.925,25.873,33.907,26.092,28.78,29.111C28.502855,29.246797,28.199543,29.320834,27.891,29.328ZM12.081,25.1C12.220005,25.100082,12.357863,25.125147,12.488,25.174L17.451,27.034L21.983,25.085C22.254734,24.973909,22.558482,24.969978,22.833,25.074L27.868,26.981C29.25,26.15,30.968,25.09,31.668,24.595L31.695,16.156Q31.695,14.596,31.606,12.986C31.387,9.041,30.129,6.11,27.866,4.272C26.214157,2.954701,24.150025,2.263352,22.038,2.32C21.723,2.32,20.028,2.41,19.7,2.484C17.52043,2.962966,15.746472,4.540364,15.016,6.649C14.897515,6.997245,14.620879,7.268651,14.270437,7.380469C13.919995,7.492287,13.537287,7.431262,13.239,7.216C12.158653,6.433347,10.85805,6.013233,9.524,6.016C3.674,6.165,2.398,10.73,2.342,14.533C2.335,15.008,2.319,16.36,2.319,18.586L2.319,24.775L7.019,26.981L11.659,25.181C11.793395,25.127954,11.936516,25.100483,12.081,25.1Z\" fill=\"none\" stroke=\"rgb(119,119,119)\" stroke-width=\"1\" stroke-dashoffset=\"418.28\" stroke-dasharray=\"209.14\"\/><\/svg>";
    String fileText = '<!doctype html><html><head><style>html, body, svg {width: 100%; height: 100%;}body {display:flex;align-items:center;justify-content:center;margin:0; padding:0;}</style></head><body>'
        + Svg
        + '</body></html>';
    String dataUrl = Uri.dataFromString(
        fileText,
        mimeType: 'text/html',
        encoding: Encoding.getByName('utf-8')
    ).toString();
    webViewController.loadUrl(dataUrl);
  }
}