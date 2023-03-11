import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seerbit_flutter_native/src/modules/momo/controllers/momo_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/momo/widgets/momo_confirmation.dart';
import 'package:seerbit_flutter_native/src/modules/momo/widgets/momo_enter_phone.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_state.dart';

class MomoChannel extends StatelessWidget {
  const MomoChannel({super.key});

  @override
  Widget build(BuildContext context) {
    MomoNotifier mn = Provider.of<MomoNotifier>(context);
    return FadeInUp(
      key: Key(mn.currentCardView.toString()),
      duration: const Duration(milliseconds: 200),
      child: Builder(
        builder: (context) {
          switch (mn.currentCardView) {
            case CurrentCardView.info:
              return const MomoEnterPhone();
            case CurrentCardView.pin:
              return const MomoAuthorize();
            default:
              return Container();
          }
        },
      ),
    );
  }
}
