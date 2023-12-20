import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:djudjo_scheduler/generated/assets.dart';
import 'package:djudjo_scheduler/widgets/snackbar/custom_snackbar.dart';
import 'package:djudjo_scheduler/widgets/tappable_texts/custom_tappable_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/color_helper.dart';
import '../../../widgets/app_bars/common_app_bar.dart';
import '../../../widgets/buttons/common_button.dart';
import '../../../widgets/dialogs/simple_dialog.dart';
import '../../../widgets/loaders/loader_app_dialog.dart';
import '../../../widgets/text_fields/custom_text_form_field.dart';
import '../../providers/login_provider/login_provider.dart';
import '../../utils/language/language_strings.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) => commonAppBar(
        context,
        color: ColorHelper.white.color,
        title: Language.fp_app_bar,
        titleColor: Colors.black,
        icon: Icons.arrow_back_ios,
        leadingIconColor: ColorHelper.black.color,
        onLeadingTap: () => Navigator.of(context).pop(),
      );

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 30),
          _buildHeadline(context),
          const SizedBox(height: 50),
          _buildForm(context),
        ],
      ),
    );
  }

  Widget _buildHeadline(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width / 1.7,
          child: Text(
            Language.fp_headline,
            style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        Image.asset(Assets.assetsForgot, scale: 8)
      ],
    );
  }
}

Widget _buildForm(BuildContext context) {
  return Form(child: Column(children: <Widget>[_buildEmailField(context)]));
}

Widget _buildEmailField(BuildContext context) {
  return CustomTextFormField(
    controller: context.read<LoginProvider>().fpEmailController,
    hintText: Language.fp_email_hint,
    key: const Key('fp_email_hint'),
    keyboardType: TextInputType.emailAddress,
    onFieldSubmitted: (String? s) {
      FocusScope.of(context).nextFocus();
    },
  );
}

Widget _buildBottomBar(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 15),
    child: CommonButton(
      disabled: !context.watch<LoginProvider>().isForgotEmailFieldEmpty(),
      onPressed: () {
        customLoaderCircleWhite(context: context);
        context.read<LoginProvider>().forgotPasswordFirebaseAuth().then((String? error) {
          Navigator.of(context).pop();
          if (error != null) {
            customSimpleDialog(context, title: Language.common_error, content: error, buttonText: Language.common_ok);
          } else {
            context.read<LoginProvider>().clearForgotPasswordControllers();
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(customSnackBar(
                snackBarTitle: Language.ana_success_title,
                snackBarMessage: Language.fp_email_sent_success,
                snackBarContentType: ContentType.success,
              ));
          }
        });
      },
      buttonTitle: Language.fp_button,
    ),
  );
}
