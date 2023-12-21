import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../theme/color_helper.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: Container(
                color: ColorHelper.mercury.color, child: const Center(child: SpinKitWaveSpinner(size: 80.0, color: Colors.white))),
          ),
        ),
      ),
    );
  }
}
