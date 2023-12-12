import 'package:djudjo_scheduler/app/providers/login_provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/color_helper.dart';
import '../../../widgets/app_bars/common_app_bar.dart';
import '../../../widgets/buttons/common_button.dart';
import '../../../widgets/dialogs/simple_dialog.dart';
import '../../../widgets/loaders/loader_app_dialog.dart';
import '../../../widgets/modal_sheet/custom_modal_sheet.dart';
import '../../../widgets/text_fields/custom_text_form_field.dart';
import '../../utils/language/language_strings.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, this.isFromBottom = false});

  final bool isFromBottom;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    _getInitialData();
    super.initState();
  }

  Future<void> _getInitialData() async {
    customFutureBuilderLoader(context: context);
    await context.read<LoginProvider>().fetchAdmins().then((value) => Navigator.of(context).pop());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context, widget.isFromBottom),
      body: _buildBody(context),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }
}

PreferredSizeWidget _buildAppBar(BuildContext context, bool isFromBottom) => commonAppBar(
      context,
      color: ColorHelper.white.color,
      title: Language.pp_app_bar,
      titleColor: Colors.black,
      icon: isFromBottom ? null : Icons.arrow_back_ios,
      leadingIconColor: ColorHelper.black.color,
      onLeadingTap: () => Navigator.of(context).pop(),
    );

Widget _buildBody(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.symmetric(horizontal: 34),
    child: Column(
      children: <Widget>[
        const SizedBox(height: 30),
        _buildImgHeader(context),
        const Divider(),
        _buildForm(context),
      ],
    ),
  );
}

Widget _buildImgHeader(BuildContext context) {
  return Row(
    children: <Widget>[
      GestureDetector(
        onTap: () {
          print('OPEN SLIKA upload');
        },
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(shape: BoxShape.circle, color: ColorHelper.monochromaticGray200.color),
          child: Image.asset('assets/user.png'),
        ),
      ),
      const SizedBox(width: 20),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(context.watch<LoginProvider>().admin.name!, style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 20)),
          const Text(Language.pp_headline),
        ],
      ),
    ],
  );
}

Widget _buildForm(BuildContext context) {
  return Form(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 20),
        _buildNameField(context),
        _buildPhoneField(context),
        _buildEmailField(context),
      ],
    ),
  );
}

Widget _buildEmailField(BuildContext context) {
  return CustomTextFormField(
    controller: context.read<LoginProvider>().profileEmailController,
    hintText: Language.pp_email_hint,
    key: const Key('pp_email_hint'),
    keyboardType: TextInputType.emailAddress,
    onChange: () => context.read<LoginProvider>().setChangesOccurred(),
    onFieldSubmitted: (String? s) {
      FocusScope.of(context).nextFocus();
    },
  );
}

Widget _buildNameField(BuildContext context) {
  return CustomTextFormField(
    controller: context.read<LoginProvider>().profileNameController,
    hintText: Language.pp_name_hint,
    onChange: () => context.read<LoginProvider>().setChangesOccurred(),
    key: const Key('pp_name_hint'),
    onFieldSubmitted: (String? s) {
      FocusScope.of(context).nextFocus();
    },
  );
}

Widget _buildPhoneField(BuildContext context) {
  return CustomTextFormField(
    controller: context.read<LoginProvider>().profilePhoneController,
    hintText: Language.pp_phone_hint,
    key: const Key('pp_phone_hint'),
    onChange: () => context.read<LoginProvider>().setChangesOccurred(),
    keyboardType: TextInputType.phone,
    onFieldSubmitted: (String? s) {
      FocusScope.of(context).nextFocus();
    },
  );
}

Widget _buildBottomBar(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
    child: CommonButton(
      disabled: !context.watch<LoginProvider>().changesOccurred,
      onPressed: () {
        customLoaderCircleWhite(context: context);
        context.read<LoginProvider>().updateCurrentAdmin().then((String? error) {
          Navigator.of(context).pop();
          if (error != null) {
            customSimpleDialog(context, buttonText: Language.common_ok, title: Language.common_error, content: error);
          } else {
            showSuccessModal(context);
          }
        });
      },
      buttonTitle: Language.pp_button,
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
      return CustomModalSheet(
          height: 400,
          title: Language.ana_success_title,
          onClosePressed: () => Navigator.of(context).pop(),
          bodyWidget: Container(
              child: Column(
            children: <Widget>[
              Image.asset('assets/success.png', height: MediaQuery.of(context).size.height / 7),
              const SizedBox(height: 30),
              Text(Language.ana_success_subtitle,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(fontWeight: FontWeight.w400, fontSize: 18)),
            ],
          )),
          bottomWidget: CommonButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            buttonTitle: Language.common_ok,
          ));
    },
  );
}
