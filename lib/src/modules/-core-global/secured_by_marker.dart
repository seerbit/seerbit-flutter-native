import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:seerbit_flutter_native/src/modules/-core-global/-core-global.dart';

class SecuredByMarker extends StatelessWidget {
  const SecuredByMarker({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset('assets/padlock.svg'),
        const XSpace(5),
        const CustomText("Secured by", size: 14),
        const XSpace(5),
        Image.network(
          "https://raw.githubusercontent.com/seerbit/seerbit-flutter-native/2c1339290a4b73fc8ea4f1057080f3dc9572427b/assets/seerbit.png?token=GHSAT0AAAAAAB3U6CZ6UHHQONELJRE3HL4EZBX5DAA",
          width: 60,
        )
      ],
    );
  }
}
