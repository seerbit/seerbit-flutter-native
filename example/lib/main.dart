import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seerbit_flutter_native/seerbit_flutter_native.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (_, context) {
          return MaterialApp(
            title: 'Seerbit Demo',
            theme: ThemeData(fontFamily: 'FaktPro'),
            navigatorKey: navigatorKey,
            home: const MyHomePage(title: 'Seerbit Demo'),
          );
        });
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
      SeerbitCheckout(publicKey: "SBTESTPUBK_t4G16GCA1O51AV0Va3PPretaisXubSw1");

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
                  onClose: () => print("Closed"),
                  onSuccess: () => print("Success"),
                  onFailure: () => print("Failure"),
                  payload: PaymentPayloadModel(
                      firstName: "Falola",
                      lastName: "Adedayo",
                      fullName: "Falola Adedayo",
                      mobileNumber: "08140276106",
                      email: "onuohasilver9@gmail.com",
                      redirectUrl: "https://google.com",
                      sourceIp: "0.0.0.1",
                      productId: "",
                      currency: "NGN",
                      fee: "1.5",
                      amount: "20"),
                );
              },
              child: const Text("Start"),
            )
          ],
        ),
      ),
    );
  }
}
