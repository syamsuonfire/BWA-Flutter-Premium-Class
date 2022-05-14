import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PayWebView extends StatelessWidget {
	final String paymentUrl;

  const PayWebView({Key key, @required this.paymentUrl}) : super(key: key);
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				iconTheme: IconThemeData(color: Colors.black87),
				backgroundColor: Colors.white,
				title: Text("Pilih Metode Pembayaran", style: TextStyle(color: Colors.black87),),
			),
			body: WebView(
				initialUrl: paymentUrl,
				javascriptMode: JavascriptMode.unrestricted,
			),
		);
	}
}