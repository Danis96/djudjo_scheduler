import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../routing/routes.dart';
import '../../../widgets/dialogs/simple_dialog.dart';
import '../../../widgets/loaders/loader_app_dialog.dart';
import '../../providers/login_provider/login_provider.dart';
import '../language/language_strings.dart';

void showLogoutDialog(BuildContext context) => customSimpleDialog(
      context,
      buttonText: Language.hd_cancel,
      buttonTwoText: Language.common_ok,
      onButtonTwoPressed: () => logout(context),
      onButtonPressed: () => Navigator.of(context).pop(),
      title: Language.hd_title,
      content: Language.hd_content,
    );

void showDeleteDialog(BuildContext context) => customSimpleDialog(
      context,
      buttonText: Language.sh_delete_cancel,
      buttonTwoText: Language.common_ok,
      onButtonTwoPressed: () => delete(context),
      onButtonPressed: () => Navigator.of(context).pop(),
      title: Language.sh_delete_title,
      content: Language.sh_delete_subtitle,
    );

Future<void> logout(BuildContext context) async {
  customLoaderCircleWhite(context: context);
  await context.read<LoginProvider>().logoutFromFirebase().then((String? error) {
    Navigator.of(context).pop();
    if (error != null) {
      customSimpleDialog(context, title: Language.common_error, content: error, buttonText: Language.common_ok);
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil(Login, arguments: false, (Route<dynamic> route) => false);
    }
  });
}

Future<void> delete(BuildContext context) async {
  customLoaderCircleWhite(context: context);
  await context.read<LoginProvider>().deleteUserAdmin().then((String? error) {
    Navigator.of(context).pop();
    if (error != null) {
      customSimpleDialog(context, title: Language.common_error, content: error, buttonText: Language.common_ok);
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil(Login, (Route<dynamic> route) => false);
    }
  });
}
