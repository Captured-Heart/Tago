import 'dart:async';

import 'package:tago/app.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OrderPaymentScreen extends StatefulWidget {
  const OrderPaymentScreen({super.key});

  @override
  _OrderPaymentScreenState createState() => _OrderPaymentScreenState();
}

class _OrderPaymentScreenState extends State<OrderPaymentScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    var data = HiveHelper().getData(HiveKeys.createOrder.keys)['data'];
    var url = data['url'];
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: true,
          leading: tagoBackButton(
            context: context,
            onTapBack: () {
              pop(context);
              pop(context);
            },
          ),
        ),
        body: WebView(
          initialUrl: url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          onPageFinished: (String url) {
            if (url.contains("https://tago-web-app.vercel.app/")) {
              navBarPush(
                context: context,
                screen: const OrderPlacedScreen(),
                withNavBar: false,
              );
            }
          },
        ).padOnly(
          bottom: context.sizeHeight(0.15),
        ));
  }
}
