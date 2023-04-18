import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:seerbit_flutter_native/src/models/merchant_model.dart';
import 'package:seerbit_flutter_native/src/models/payment_payload_model.dart';
import 'package:seerbit_flutter_native/src/modules/-core-global/-core-global.dart';
import 'package:seerbit_flutter_native/src/modules/channel_selection.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_notifier.dart';
import 'package:validatorless/validatorless.dart';

class SeerbitModal extends StatefulWidget {
  const SeerbitModal(
      {super.key,
      required this.publicKey,
      this.onClose,
      this.onSuccess,
      this.showForm = false,
      this.onFailure,
      required this.payloadModel,
      required this.isRelease});
  final String publicKey;
  final Function? onClose, onSuccess, onFailure;
  final PaymentPayloadModel payloadModel;
  final bool showForm, isRelease;

  @override
  State<SeerbitModal> createState() => _SeerbitModalState();
}

class _SeerbitModalState extends State<SeerbitModal> {
  final _formKey = GlobalKey<FormState>();
  late Future myFuture;
  bool showChannels = false;
  @override
  void initState() {
    myFuture = Future(() async {
      ViewsNotifier vn = Provider.of<ViewsNotifier>(context, listen: false);
      vn.setIsReleaseMode(widget.isRelease);
      vn.setConpletionFunctions(
          onCloseFunc: widget.onClose,
          onFailureFunc: widget.onFailure,
          onSuccessFunc: widget.onSuccess);
      vn.setPaymentPayload(
          widget.payloadModel.copyWith(isLive: widget.isRelease));
      vn.setPublicKey(widget.publicKey);
      await vn.getMerchantDetails();
      if (!widget.showForm) setState(() => showChannels = true);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ViewsNotifier vn = Provider.of<ViewsNotifier>(context);
    return showChannels
        ? const ChannelSelection()
        : FutureBuilder(
            future: myFuture,
            builder: (context, snapshot) {
              return Builder(builder: (context) {
                MerchantDetailModel? mdm = vn.merchantDetailModel;
                if (mdm == null) {
                  return SizedBox(
                    height: 812.h,
                    width: double.infinity,
                    child: const Center(
                      child: CupertinoActivityIndicator(
                        radius: 15,
                      ),
                    ),
                  );
                }
                return SingleChildScrollView(
                  child: Container(
                    height: 812.h,
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    color: Colors.white,
                    child: Form(
                      key: _formKey,
                      // autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const YSpace(22),
                          if (mdm.payload.logo != null)
                            Image.network(mdm.payload.logo!,
                                height: 50.h, width: 50.h),
                          const YSpace(12),
                          CustomText(
                              "${mdm.payload.businessName} Payment Page.",
                              weight: FontWeight.bold,
                              size: 14),
                          const YSpace(24),
                          Row(
                            children: [
                              Expanded(
                                  child: CustomTextField(
                                label: "First Name",
                                inputType: TextInputType.name,
                                validator:
                                    Validatorless.required("Field is required"),
                                onChanged: (_) => vn.setPaymentPayload(
                                    vn.paymentPayload!.copyWith(firstName: _)),
                              )),
                              const XSpace(10),
                              Expanded(
                                  child: CustomTextField(
                                label: "Last Name",
                                inputType: TextInputType.name,
                                validator:
                                    Validatorless.required("Field is required"),
                                onChanged: (_) => vn.setPaymentPayload(
                                    vn.paymentPayload!.copyWith(lastName: _)),
                              )),
                            ],
                          ),
                          const YSpace(12),
                          CustomTextField(
                            label: "Email",
                            inputType: TextInputType.emailAddress,
                            validator: Validatorless.multiple([
                              Validatorless.email("This is not a valid email"),
                              Validatorless.required("Field is required")
                            ]),
                            onChanged: (_) => vn.setPaymentPayload(
                                vn.paymentPayload!.copyWith(email: _)),
                          ),
                          const YSpace(12),
                          CustomTextField(
                            label: "Phone Number",
                            inputType: TextInputType.phone,
                            formatter: [LengthLimitingTextInputFormatter(13)],
                            validator:
                                Validatorless.required("Field is required"),
                            onChanged: (_) => vn.setPaymentPayload(
                                vn.paymentPayload!.copyWith(mobileNumber: _)),
                          ),
                          const YSpace(12),
                          CustomTextField(
                              label: "Amount to charge",
                              inputType: TextInputType.number,
                              formatter: [CurrencyInputFormatter()],
                              validator: Validatorless.multiple([
                                Validatorless.required("Field is required"),
                                // Validatorless.number("Amount needs to be a number")
                              ]),
                              onChanged: (_) => {
                                    vn.setPaymentPayload(vn.paymentPayload!
                                        .copyWith(
                                            amount: _.replaceAll(",", ""))),
                                  }),
                          const YSpace(24),
                          CustomFlatButton(
                              label: "Continue to Payment",
                              onTap: () async {
                                if (!_formKey.currentState!.validate()) return;
                                await vn.getBanks();
                                setState(() {
                                  showChannels = true;
                                });
                              },
                              color: _validateFields(vn)
                                  ? Colors.white54
                                  : Colors.white,
                              bgColor: _validateFields(vn)
                                  ? Colors.grey
                                  : Colors.black),
                          const YSpace(25),
                          const SecuredByMarker(),
                          const YSpace(25),
                        ],
                      ),
                    ),
                  ),
                );
              });
            });
  }
}

_validateFields(ViewsNotifier vn) {
  PaymentPayloadModel? pm = vn.paymentPayload;

  return !((pm?.amount?.isNotEmpty ?? false) &&
      (pm?.firstName?.isNotEmpty ?? false) &&
      (pm?.lastName?.isNotEmpty ?? false) &&
      (pm?.mobileNumber?.isNotEmpty ?? false) &&
      (pm?.email?.isNotEmpty ?? false));
}
