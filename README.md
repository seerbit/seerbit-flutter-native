<p align="center">
<img width="200" valign="top" src="https://assets.seerbitapi.com/images/seerbit_logo_type.png" data-canonical-src="https://assets.seerbitapi.com/images/seerbit_logo_type.png" style="max-width:100%; ">
</p>
 
# Seerbit Flutter SDK
 
Seerbit Flutter SDK can be used to integrate the SeerBit payment gateway into your flutter application.
 
## Requirements
 
Register for a merchant account on [Seerbit Merchant Dashboard](https://dashboard.seerbitapi.com) to get started.
 
```
   Dart sdk: ">=2.12.0-0 <3.0.0"
   Flutter: ">=1.22.2"
   Android: minSdkVersion 17 and add support for androidx (see AndroidX Migration to migrate an existing app)
   iOS: --ios-language swift, Xcode version >= 12
```
 
 ## Instalation

```bash
flutter pub get seerbit_flutter_native
```

## API Documentation

https://doc.seerbit.com

## Support

If you have any problems, questions or suggestions, create an issue here or send your inquiry to care@seerbit.com

## Implementation

You should already have your API keys. If not, go to [dashboard.seerbitapi.com](https://dashboard.seerbitapi.com). Login -> Settings menu -> API Keys menu -> Copy your public key

## Properties

| Property            | Type               | Required | Default            | Desc                                                                                                                                                                                                                                    |
| ------------------- | ------------------ | -------- | ------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| currency            | `String`           | Optional | NGN                | The currency for the transaction e.g NGN                                                                                                                                                                                                |
| email               | `String`           | Required | None               | The email of the user to be charged                                                                                                                                                                                                     |
| description         | `String`           | Optional | None               | The transaction description which is optional                                                                                                                                                                                           |
| fullName            | `String`           | Optional | None               | The fullname of the user to be charged                                                                                                                                                                                                  |
| country             | `String`           | Optional | None               | Transaction country which can be optional                                                                                                                                                                                               |
| transRef            | `String`           | Required | None               | Set a unique transaction reference for every transaction                                                                                                                                                                                |
| amount              | `String`           | Required | None               | The transaction amount in kobo                                                                                                                                                                                                          |
| callbackUrl         | `String`           | Optional | None               | This is the redirect url when transaction is successful                                                                                                                                                                                 |
| publicKey           | `String`           | Required | None               | Your Public key or see above step to get yours                                                                                                                                                                                          |
| closeOnSuccess      | `bool`             | Optional | False              | Close checkout when trasaction is successful                                                                                                                                                                                            |
| closePrompt         | `bool`             | Optional | False              | Close the checkout page if transaction is not initiated                                                                                                                                                                                 |
| setAmountByCustomer | `bool`             | Optional | False              | Set to true if you want user to enter transaction amount                                                                                                                                                                                |
| pocketRef           | `String`           | Optional | None               | This is your pocket reference for vendors with pocket                                                                                                                                                                                   |
| vendorId            | `String`           | Optional | None               | This is the vendorId of your business using pocket                                                                                                                                                                                      |
| tokenize            | `bool`             | Optional | False              | Tokenize card                                                                                                                                                                                                                           |
| customization       | CustomizationModel | Optional | CustomizationModel | CustomizationMode( borderColor: "#000000", backgroundColor: "#004C64", buttonColor: "#0084A0", paymentMethod:[PayChannel.card, PayChannel.account, PayChannel.transfer, PayChannel.momo], confetti: false , logo: "logo_url or base64") |
| onSuccess           | `Method`           | Optional | None               | Callback method if transaction was successful                                                                                                                                                                                           |
| onCancel            | `Method`           | Optional | None               | Callback method if transaction was cancelled                                                                                                                                                                                            |

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seerbit_flutter_native/seerbit_flutter_native.dart';




class CheckOut extends StatelessWidget {
const CheckOut({Key? key}) : super(key: key);
SeerbitMethod SeerBit = new SeerbitMethod();

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
                      firstName: "Falola",
                      lastName: "Adedayo",
                      fullName: "Falola Adedayo",
                      mobileNumber: "09012312312",
                      email: "mail@gmail.com",
                      productId: "",
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


SeerBit.startPayment(
  context,
  payload: payload,
  onSuccess: (*) { print(*);},
  onCancel: (_) { print('_' _ 400);}
);

}
}

```

`onSuccess` you will recieve a Map containing the response from the payment request.

During the payment process you can simply end the process by calling

```dart
SeerbitMethod.endPayment(context);
```

This ends the payment and removes the checkout view from the screen.
