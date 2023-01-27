import 'package:example/modules/debit-card/controllers/debit_card_notifier.dart';
import 'package:example/modules/ussd/controllers/ussd_notifier.dart';
import 'package:example/modules/view-notifiers/view_notifier.dart';
import 'package:provider/provider.dart';

class AppProviders {
  static final providers = [
    ChangeNotifierProvider<ViewsNotifier>(create: (_) => ViewsNotifier()),
    ChangeNotifierProvider<DebitCardNotifier>(
        create: (_) => DebitCardNotifier()),
    ChangeNotifierProvider<UssdNotifier>(create: (_) => UssdNotifier()),
  ];
}
