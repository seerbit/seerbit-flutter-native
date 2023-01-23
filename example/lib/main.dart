import 'package:example/core/providers.dart';
import 'package:example/views/view.dart';
import 'package:example/views/widgets/custom_over_lay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

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
              theme: ThemeData(
                primarySwatch: Colors.red,
              ),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

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
            const Text('You have pushed the button this many times:'),
            Text('$_counter', style: Theme.of(context).textTheme.headline4),
            TextButton(
              onPressed: () {
                CustomOverlays().showPopup(const SeerbitCheckout());
                // Navigate.to(const SeerbitCheckout());
              },
              child: const Text("Start"),
            )
          ],
        ),
      ),
    );
  }
}
