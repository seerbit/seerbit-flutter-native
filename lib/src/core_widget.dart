import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:seerbit_flutter_native/src/core/providers.dart';
import 'package:seerbit_flutter_native/src/models/payment_payload_model.dart';
import 'package:seerbit_flutter_native/src/modules/view.dart';

import 'modules/-core-global/custom_over_lay.dart';

class SeerbitCheckout {
  SeerbitCheckout({required this.publicKey});
  final String publicKey;
  createCheckout(BuildContext context,
      {Function? onClose,
      Function? onSuccess,
      Function? onFailure,
      bool showForm = false,
      required bool isRelease,
      required PaymentPayloadModel payload}) {
    if (!showForm) {
      assert(payload.amount != null, "Amount is required if showForm = false");
      assert(payload.firstName != null,
          "FirstName is required if showForm = false");
      assert(
          payload.lastName != null, "LastName is required if showForm = false");
      assert(payload.email != null, "Email is required if showForm = false");
      assert(payload.mobileNumber != null,
          "Mobile Number is required if showForm = false");
    }
    payload.copyWith(isLive: isRelease);
    if (payload.redirectUrl == null) {
      payload.copyWith(redirectUrl: "https://google.com");
    }
    CustomOverlays().showPopup(
        SeerbitProvider(
            child: SeerbitModal(
          publicKey: publicKey,
          payloadModel: payload.copyWith(publicKey: publicKey),
          onSuccess: onSuccess,
          onFailure: onFailure,
          onClose: onClose,
          isRelease: isRelease,
          showForm: showForm,
        )),
        whenComplete: () => onClose?.call(),
        context: context);
  }
}

class SeerbitProvider extends StatelessWidget {
  const SeerbitProvider({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (_, context) {
          return MultiProvider(
            providers: AppProviders.providers,
            child: child,
          );
        });
  }
}
