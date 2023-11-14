import 'package:djudjo_scheduler/app/providers/login_provider/login_provider.dart';
import 'package:djudjo_scheduler/app/utils/language_strings.dart';
import 'package:djudjo_scheduler/routing/routes.dart';
import 'package:djudjo_scheduler/widgets/buttons/common_button.dart';
import 'package:djudjo_scheduler/widgets/dialogs/simple_dialog.dart';
import 'package:djudjo_scheduler/widgets/loaders/loader_app_dialog.dart';
import 'package:djudjo_scheduler/widgets/tappable_texts/custom_tappable_text.dart';
import 'package:djudjo_scheduler/widgets/text_fields/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:provider/provider.dart';

import '../../../theme/color_helper.dart';
import '../../../widgets/app_bars/common_app_bar.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }
}

PreferredSizeWidget _buildAppBar(BuildContext context) => commonAppBar(
      context,
      color: ColorHelper.towerNavy2.color,
      hideLeading: true,
      action: _buildTappableRegister(context),
    );

Widget _buildBody(BuildContext context) {
  return ListView(
      physics: const NeverScrollableScrollPhysics(),
      reverse: true,
      shrinkWrap: true,
      children: <Widget>[_buildTopContainer(context), _buildForm(context)].reversed.toList());
}

Widget _buildTopContainer(BuildContext context) {
  return Stack(
    alignment: Alignment.bottomCenter,
    children: <Widget>[
      Container(
        height: MediaQuery.of(context).size.height / 2,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const <double>[0.9, 1],
            colors: [ColorHelper.towerNavy2.color, ColorHelper.white.color],
          ),
        ),
      ),
      ClipPath(clipper: WaveClipperOne(reverse: true), child: Container(height: 80, color: Colors.white)),
      // _buildHeadline(context),
    ],
  );
}

Widget _buildForm(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildHeadline(context),
          const SizedBox(height: 20),
          _buildEmailField(context),
          _buildPasswordField(context),
        ],
      ),
    ),
  );
}

Widget _buildEmailField(BuildContext context) {
  return CustomTextFormField(
    controller: context.read<LoginProvider>().loginEmailController,
    hintText: Language.email_hint,
    key: const Key('login_email'),
    onFieldSubmitted: (String? s) {
      FocusScope.of(context).nextFocus();
    },
  );
}

Widget _buildPasswordField(BuildContext context) {
  return CustomTextFormField(
    type: TextFieldType.passwordType,
    controller: context.read<LoginProvider>().loginPasswordController,
    hintText: Language.password_hint,
    key: const Key('login_pass'),
    onFieldSubmitted: (String? s) {
      FocusScope.of(context).nextFocus();
    },
  );
}

Widget _buildTappableRegister(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: CustomTappableText(
      text: Language.reg_tappable,
      links: Language.reg_tappable,
      linkStyle: const TextStyle(decoration: TextDecoration.none, color: Colors.white, fontSize: 17),
      onPressed: (int i) {
        Navigator.of(context).pushNamed(Register, arguments: context.read<LoginProvider>());
      },
    ),
  );
}

Widget _buildHeadline(BuildContext context) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(Language.login_headline, style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 24)),
        Image.asset('assets/ic_logo.png', width: 50),
      ],
    );

Widget _buildBottomBar(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
    child: CommonButton(
      onPressed: () {
        customLoaderCircleWhite(context: context);
        context.read<LoginProvider>().loginUser().then((String? error) {
          Navigator.of(context).pop();
          if (error != null) {
            customSimpleDialog(context, buttonText: Language.common_ok, title: Language.common_error, content: error);
          } else {
            Navigator.of(context).pushNamed(Home);
          }
        });
      },
      buttonTitle: Language.login_btn,
    ),
  );
}
