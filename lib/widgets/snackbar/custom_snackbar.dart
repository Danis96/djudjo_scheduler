import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

SnackBar customSnackBar({
  String snackBarTitle = 'Snack title default',
  String snackBarMessage = 'Snack message default',
  ContentType? snackBarContentType,
  Color backgroundColor = Colors.transparent,
  double elevation = 0,
  SnackBarBehavior snackBarBehavior = SnackBarBehavior.floating,
}) {
  return SnackBar(
    elevation: 0,
    behavior: snackBarBehavior,
    backgroundColor: backgroundColor,
    content: AwesomeSnackbarContent(
      title: snackBarTitle,
      message: snackBarMessage,
      contentType: snackBarContentType ?? ContentType.failure,
    ),
  );
}
