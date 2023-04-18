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
          "https://res.cloudinary.com/shopspace/image/upload/v1681386543/zcnbrnpgbocyyxxlznqc.png",
          width: 60,
        )
      ],
    );
  }
}
