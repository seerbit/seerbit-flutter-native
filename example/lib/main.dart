import 'package:flutter/material.dart';
import 'package:seerbit_flutter_native/seerbit_flutter_native.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Seerbit Demo',
      home: MyHomePage(title: 'Seerbit Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SeerbitCheckout seerbitCheckout =
      SeerbitCheckout(publicKey: "SBPUBK_WWEQK6UVR1PNZEVVUOBNIQHEIEIM1HJC");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () {
                seerbitCheckout.createCheckout(
                  context,
                  showForm: false,
                  isRelease: true,
                  onClose: () => print("Closed"),
                  onSuccess: () => print("Success"),
                  onFailure: () => print("Failure"),
                  payload: PaymentPayloadModel(
                      firstName: "Jane",
                      lastName: "Doe",
                      fullName: "Jane Doe",
                      mobileNumber: "08140273333",
                      email: "abcd@gmail.com",
                      redirectUrl: "https://google.com",
                      sourceIp: "0.0.0.1",
                      productId: "",
                      currency: "NGN",
                      country: "NG",
                      amount: "101"),
                );
              },
              child: const Text("Pay without form"),
            ),
            TextButton(
              onPressed: () {
                seerbitCheckout.createCheckout(
                  context,
                  isRelease: true,
                  showForm: true,
                  onClose: () => print("Closed"),
                  onSuccess: () => print("Success"),
                  onFailure: () => print("Failure"),
                  payload: PaymentPayloadModel(
                      currency: "NGN", country: "NG", amount: "101"),
                );
              },
              child: const Text("Pay with form"),
            )
          ],
        ),
      ),
    );
  }
}
