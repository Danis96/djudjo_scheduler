import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Future<void> showMyDialog({
  BuildContext? context,
  String title = '',
  String msg = '',
  Color color = Colors.white,
  Widget? mainWidget,
  Widget? action,
  double elevation = 0,
  bool barrier = false,
}) async {
  return showDialog<void>(
    context: context!,
    barrierDismissible: barrier,
    builder: (BuildContext context) {
      return WillPopScope(
          child: Container(
            height: 80,
            child: AlertDialog(
              elevation: 0,
              backgroundColor: color,
              title: Text(title),
              content: SingleChildScrollView(child: ListBody(children: <Widget>[Container(child: mainWidget ?? const SizedBox())])),
              actions: <Widget>[action ?? const SizedBox()],
            ),
          ),
          onWillPop: () async => false);
    },
  );
}

Future<void> customLoaderCircleWhite({@required BuildContext? context}) {
  return showMyDialog(
    msg: '',
    action: const SizedBox(),
    context: context,
    barrier: false,
    title: '',
    mainWidget: const SpinKitCircle(size: 80.0, color: Colors.white),
    color: Colors.transparent,
    elevation: 0,
  );
}
