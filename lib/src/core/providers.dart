import 'package:provider/provider.dart';
import 'package:seerbit_flutter_native/src/modules/bank-account/controllers/bank_account_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/bank-transfer/controllers/bank_transfer_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/debit-card/controllers/debit_card_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/momo/controllers/momo_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/ussd/controllers/ussd_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_notifier.dart';

class AppProviders {
  static final providers = [
    ChangeNotifierProvider<ViewsNotifier>(create: (_) => ViewsNotifier()),
    ChangeNotifierProvider<DebitCardNotifier>(
        create: (_) => DebitCardNotifier()),
    ChangeNotifierProvider<UssdNotifier>(create: (_) => UssdNotifier()),
    ChangeNotifierProvider<BankTransferNotifier>(
        create: (_) => BankTransferNotifier()),
    ChangeNotifierProvider<BankAccountNotifier>(
        create: (_) => BankAccountNotifier()),
    ChangeNotifierProvider<MomoNotifier>(create: (_) => MomoNotifier()),
  ];
}
