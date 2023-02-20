import 'package:example/core/providers.dart';
import 'package:example/modules/-core-global/-core-global.dart';
import 'package:example/modules/view-notifiers/view_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'modules/view.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: AppProviders.providers,
      child: ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (_, context) {
            return MaterialApp(
              title: 'Seerbit Demo',
              theme: ThemeData(fontFamily: 'FaktPro'),
              navigatorKey: navigatorKey,
              home: const MyHomePage(title: 'Seerbit Demo'),
            );
          }),
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
  @override
  Widget build(BuildContext context) {
    ViewsNotifier vn = Provider.of<ViewsNotifier>(context);
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
                vn.getMerchantDetails();
                CustomOverlays()
                    .showPopup(SeerbitCheckout(), whenComplete: vn.reset());

                // Navigate.to(const Marquee());
              },
              child: const Text("Start"),
            )
          ],
        ),
      ),
    );
  }
}
