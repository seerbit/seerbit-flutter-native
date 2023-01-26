import 'package:example/views/global_components/global_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        Image.asset(
          "assets/seerbit.png",
          width: 60,
        )
      ],
    );
  }
}
