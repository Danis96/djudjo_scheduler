import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:provider/provider.dart';

import '../../../theme/color_helper.dart';
import '../../../widgets/app_bars/common_app_bar.dart';
import '../../../widgets/buttons/common_button.dart';
import '../../../widgets/dialogs/simple_dialog.dart';
import '../../../widgets/text_fields/custom_text_form_field.dart';
import '../../providers/login_provider/login_provider.dart';
import '../../utils/language_strings.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }
}

PreferredSizeWidget _buildAppBar(BuildContext context) => commonAppBar(
      context,
      color: ColorHelper.towerNavy2.color,
      leadingIconColor: ColorHelper.white.color,
    );

Widget _buildBody(BuildContext context) {
  return ListView(reverse: true, shrinkWrap: true, children: <Widget>[_buildTopContainer(context), _buildForm(context)].reversed.toList());
}

Widget _buildTopContainer(BuildContext context) {
  return Stack(
    alignment: Alignment.bottomCenter,
    children: <Widget>[
      Container(height: MediaQuery.of(context).size.height / 2, color: ColorHelper.towerNavy2.color),
      ClipPath(clipper: WaveClipperOne(reverse: true), child: Container(height: 80, color: Colors.white)),
      // _buildHeadline(context),
    ],
  );
}

Widget _buildBottomBar(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
    child: CommonButton(
      onPressed: () {
        context.read<LoginProvider>().registerUser().then((String? error) {
          if (error != null) {
            customSimpleDialog(context, buttonText: Language.common_ok, title: Language.common_error, content: error);
          } else {
            print(FirebaseAuth.instance.currentUser!.email);
          }
        });
      },
      buttonTitle: Language.reg_btn,
    ),
  );
}

Widget _buildForm(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Form(
      child: Column(
        children: <Widget>[
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

Widget _buildHeadline(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.end,
    children: <Widget>[
      Text('data'),
      Text('data'),
    ],
  );
}
