import 'package:example/views/view-notifiers/debit_card_notifier.dart';
import 'package:example/views/view-notifiers/view_notifier.dart';
import 'package:provider/provider.dart';

class AppProviders {
  static final providers = [
    ChangeNotifierProvider<ViewsNotifier>(create: (_) => ViewsNotifier()),
    ChangeNotifierProvider<DebitCardNotifier>(
        create: (_) => DebitCardNotifier()),
  ];
}
