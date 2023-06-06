import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seerbit_flutter_native/src/modules/-core-global/-core-global.dart';
import 'package:seerbit_flutter_native/src/modules/momo/controllers/momo_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_state.dart';

class MomoProgress extends StatelessWidget {
  const MomoProgress({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ViewsNotifier vn = Provider.of<ViewsNotifier>(context);
    MomoNotifier mn = Provider.of<MomoNotifier>(context);
    return StreamBuilder(
        stream: Stream.periodic(const Duration(seconds: 5), (_) {
          vn.confirmTransaction(context,
              onError: () => mn.changeView(CurrentCardView.error));
        }),
        builder: (context, snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const YSpace(34),
              const CustomText("Please wait",
                  weight: FontWeight.bold, size: 16),
              const YSpace(8),
              LinearProgressIndicator(
                backgroundColor: Colors.grey.shade300,
                valueColor: const AlwaysStoppedAnimation(Colors.black),
              )
            ],
          );
        });
  }
}
