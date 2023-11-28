import 'dart:ui';

import 'package:djudjo_scheduler/routing/routes.dart';
import 'package:djudjo_scheduler/widgets/loaders/loader_app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:provider/provider.dart';

import '../../../theme/color_helper.dart';
import '../../../widgets/app_bars/common_app_bar.dart';
import '../../../widgets/buttons/common_button.dart';
import '../../../widgets/dialogs/simple_dialog.dart';
import '../../../widgets/tappable_texts/custom_tappable_text.dart';
import '../../../widgets/text_fields/custom_text_form_field.dart';
import '../../providers/login_provider/login_provider.dart';
import '../../utils/language_strings.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      resizeToAvoidBottomInset: true,
      body: _buildBody(context),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) =>
      commonAppBar(context, color: ColorHelper.black.color, hideLeading: true, action: _buildTappableLogin(context));

  Widget _buildBody(BuildContext context) {
    return ListView(shrinkWrap: true, children: <Widget>[
      _buildForm(context),
    ]);
  }

  Widget _buildTappableLogin(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: CustomTappableText(
        text: Language.login_tappable,
        links: Language.login_tappable,
        linkStyle: const TextStyle(decoration: TextDecoration.none, color: Colors.white, fontSize: 17),
        onPressed: (int i) => Navigator.of(context).pushNamed(Login),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            _buildHeadline(context),
            const SizedBox(height: 20),
            _buildNameField(context),
            _buildPhoneField(context),
            _buildEmailField(context),
            _buildPasswordField(context),
            _buildConfirmPasswordField(context),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailField(BuildContext context) {
    return CustomTextFormField(
      controller: context.read<LoginProvider>().registerEmailController,
      hintText: Language.email_hint,
      key: const Key('reg_email'),
      keyboardType: TextInputType.emailAddress,
      onFieldSubmitted: (String? s) {
        FocusScope.of(context).nextFocus();
      },
    );
  }

  Widget _buildNameField(BuildContext context) {
    return CustomTextFormField(
      controller: context.read<LoginProvider>().registerNameController,
      hintText: Language.reg_name_hint,
      key: const Key('reg_name'),
      onFieldSubmitted: (String? s) {
        FocusScope.of(context).nextFocus();
      },
    );
  }

  Widget _buildPhoneField(BuildContext context) {
    return CustomTextFormField(
      controller: context.read<LoginProvider>().registerPhoneController,
      hintText: Language.reg_phone_hint,
      key: const Key('reg_phone'),
      keyboardType: TextInputType.phone,
      onFieldSubmitted: (String? s) {
        FocusScope.of(context).nextFocus();
      },
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    return CustomTextFormField(
      type: TextFieldType.passwordType,
      controller: context.read<LoginProvider>().registerPasswordController,
      hintText: Language.reg_password_hint,
      key: const Key('reg_pass'),
      onFieldSubmitted: (String? s) {
        FocusScope.of(context).nextFocus();
      },
    );
  }

  Widget _buildConfirmPasswordField(BuildContext context) {
    return CustomTextFormField(
      type: TextFieldType.passwordType,
      controller: context.read<LoginProvider>().registerConfirmPasswordController,
      hintText: Language.reg_confirm_password_hint,
      key: const Key('reg_pass_confirm'),
      onFieldSubmitted: (String? s) {
        FocusScope.of(context).nextFocus();
      },
    );
  }

  Widget _buildHeadline(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(Language.reg_headline, style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 24)),
          Image.asset('assets/ic_logo.png', width: 50),
        ],
      );

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: CommonButton(
        disabled: !context.watch<LoginProvider>().areRegPasswordIdentical(),
        onPressed: () {
          customLoaderCircleWhite(context: context);
          context.read<LoginProvider>().registerUser().then((String? error) {
            Navigator.of(context).pop();
            if (error != null) {
              customSimpleDialog(context, buttonText: Language.common_ok, title: Language.common_error, content: error);
            } else {
              Navigator.of(context).pushNamed(Login);
            }
          });
        },
        buttonTitle: Language.reg_btn,
      ),
    );
  }
}
