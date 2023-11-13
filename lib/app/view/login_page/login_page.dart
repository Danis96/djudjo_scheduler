import 'package:djudjo_scheduler/app/providers/login_provider/login_provider.dart';
import 'package:djudjo_scheduler/app/utils/language_strings.dart';
import 'package:djudjo_scheduler/widgets/buttons/common_button.dart';
import 'package:djudjo_scheduler/widgets/dialogs/simple_dialog.dart';
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
      appBar: commonAppBar(color: ColorHelper.towerNavy2.color, hideLeading: true),
      body: _buildBody(context),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }
}

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
          if(error != null) {
            customSimpleDialog(context, buttonText: 'Ok', title: 'Error', content: error);
          } else {
            print(FirebaseAuth.instance.currentUser!.email);
          }
        });
      },
      buttonTitle: Language.login_btn,
    ),
  );
}

Widget _buildForm(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Form(
      child: Column(
        children: <Widget>[
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
