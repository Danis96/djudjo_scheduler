import 'package:djudjo_scheduler/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/color_helper.dart';
import '../../../widgets/app_bars/common_app_bar.dart';
import '../../../widgets/buttons/common_button.dart';
import '../../../widgets/dialogs/simple_dialog.dart';
import '../../../widgets/loaders/loader_app_dialog.dart';
import '../../../widgets/modal_sheet/custom_modal_sheet.dart';
import '../../../widgets/text_fields/custom_text_form_field.dart';
import '../../providers/login_provider/login_provider.dart';
import '../../utils/language/language_strings.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) => commonAppBar(
        context,
        color: ColorHelper.white.color,
        title: Language.cp_app_bar,
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
            Language.cp_headline,
            style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        Image.asset(Assets.assetsPassword, scale: 8)
      ],
    );
  }
}

Widget _buildForm(BuildContext context) {
  return Form(
      child: Column(
    children: <Widget>[
      _buildOldPasswordField(context),
      _buildNewPasswordField(context),
      _buildConfirmNewPasswordField(context),
    ],
  ));
}

Widget _buildOldPasswordField(BuildContext context) {
  return CustomTextFormField(
    controller: context.read<LoginProvider>().cpOldController,
    hintText: Language.cp_old_hint,
    key: const Key('cp_pass_hint'),
    type: TextFieldType.passwordType,
    onFieldSubmitted: (String? s) {
      FocusScope.of(context).nextFocus();
    },
  );
}

Widget _buildNewPasswordField(BuildContext context) {
  return CustomTextFormField(
    controller: context.read<LoginProvider>().cpNewController,
    hintText: Language.cp_new_hint,
    key: const Key('cp_pass_new_hint'),
    type: TextFieldType.passwordType,
    onFieldSubmitted: (String? s) {
      FocusScope.of(context).nextFocus();
    },
  );
}

Widget _buildConfirmNewPasswordField(BuildContext context) {
  return CustomTextFormField(
    controller: context.read<LoginProvider>().cpConfirmController,
    hintText: Language.cp_confirm_hint,
    type: TextFieldType.passwordType,
    key: const Key('cp_pass_new_confirm_hint'),
    onFieldSubmitted: (String? s) {
      FocusScope.of(context).nextFocus();
    },
  );
}

Widget _buildBottomBar(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 15),
    child: CommonButton(
      disabled: !context.watch<LoginProvider>().areChangePasswordFieldsEmpty(),
      onPressed: () {
        customLoaderCircleWhite(context: context);
        context.read<LoginProvider>().reAuthenticateAdminAndChangePassword().then((String? error) {
          Navigator.of(context).pop();
          if (error != null) {
            customSimpleDialog(context, title: Language.common_error, content: error, buttonText: Language.common_ok);
          } else {
            context.read<LoginProvider>().clearChangePasswordControllers();
            showSuccessModal(context);
          }
        });
      },
      buttonTitle: Language.cp_button,
    ),
  );
}

void showSuccessModal(BuildContext context) {
  showModalBottomSheet<dynamic>(
    context: context,
    isDismissible: false,
    enableDrag: false,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    ),
    builder: (BuildContext ctx) {
      return ListenableProvider<LoginProvider>.value(
        value: context.read<LoginProvider>(),
        child: CustomModalSheet(
          height: 400,
          title: Language.ana_success_title,
          onClosePressed: () => Navigator.of(context).pop(),
          bodyWidget: Container(
              child: Column(
            children: <Widget>[
              Image.asset(Assets.assetsSuccess, height: MediaQuery.of(context).size.height / 6),
              const SizedBox(height: 30),
              Text(Language.cp_success_subtitle,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(fontWeight: FontWeight.w400, fontSize: 18)),
            ],
          )),
          bottomWidget: CommonButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            buttonTitle: Language.common_ok,
          ),
        ),
      );
    },
  );
}
