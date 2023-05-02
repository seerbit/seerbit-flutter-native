# Seerbit Flutter SDK

![A beautiful sunset](https://assets.seerbitapi.com/images/seerbit_logo_type.png "Photo by John Doe")

Seerbit Flutter SDK can be used to integrate the SeerBit payment gateway into your flutter application.

## Requirements

Register for a merchant account on [Seerbit Merchant Dashboard](https://dashboard.seerbitapi.com) to get started.

```bash
   Dart sdk: ">=2.12.0-0 <3.0.0"
   Flutter: ">=1.22.2"
   Android: minSdkVersion 19 and add support for androidx (see AndroidX Migration to migrate an existing app) compilesdkversion 33
   iOS: --ios-language swift, Xcode version >= 12
```

## Instalation

```bash
flutter pub get seerbit_flutter_native
```

## API Documentation

![Seerbit API Docs](https://doc.seerbit.com)

## Support

If you have any problems, questions or suggestions, create an issue here or send your inquiry to care@seerbit.com

## Implementation

You should already have your API keys. If not, go to [dashboard.seerbitapi.com](https://dashboard.seerbitapi.com). Login -> Settings menu -> API Keys menu -> Copy your public key

## Usage

```dart
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
      SeerbitCheckout(publicKey: "YOUR PUBLIC KEY");

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
                      mobileNumber: "091231923012",
                      email: "mail@gmail.com",

                      productId: "",
                      currency: "NGN",
                      country: "NG",

                      amount: "121"),
                );
              },
              child: const Text("Pay without form"),
            ),
            TextButton(
              onPressed: () {
                seerbitCheckout.createCheckout(
                  context,
                  showForm: true,
                  isRelease: true, //Set true when using a test key
                  onClose: () => print("Closed"),
                  onSuccess: () => print("Success"),
                  onFailure: () => print("Failure"),
                  payload: PaymentPayloadModel(
                      currency: "NGN",
                      country: "NG",
                      amount: "20"),
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

```
