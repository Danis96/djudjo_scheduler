import 'package:djudjo_scheduler/app/providers/login_provider/login_provider.dart';
import 'package:djudjo_scheduler/app/utils/helpers/settings_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/color_helper.dart';
import '../../../widgets/app_bars/common_app_bar.dart';
import '../../../widgets/list_item/custom_list_item.dart';
import '../../utils/language/language_strings.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    _getInitialData(context);
    super.initState();
  }

  Future<void> _getInitialData(BuildContext context) async {
    await context.read<LoginProvider>().fetchAppVersion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(context), body: _buildBody(context));
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) => commonAppBar(
        context,
        color: ColorHelper.white.color,
        title: Language.s_app_bar,
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
          _buildListOfItems(context),
          const SizedBox(height: 10),
          _buildListOfItemsFeedback(context),
          const SizedBox(height: 10),
          _buildListOfItemsOther(context),
          const SizedBox(height: 30),
          _buildAppVersion(context),
        ],
      ),
    );
  }

  Widget _buildHeadline(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          Language.s_headline,
          style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildListOfItems(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          Language.s_general,
          style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 20, fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 10),
        const Divider(),
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: settingsItemsGeneral(context).length,
            itemBuilder: (BuildContext context, int x) {
              return CustomListItem(
                title: settingsItemsGeneral(context)[x].title,
                imageUrl: settingsItemsGeneral(context)[x].icon,
                hideOnTap: settingsItemsGeneral(context)[x].hideIconArrow,
                onTap: () => _executeFunctionOrNavigate(settingsItemsGeneral(context), x, context),
              );
            }),
      ],
    );
  }

  Widget _buildListOfItemsFeedback(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          Language.s_feedback,
          style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 20, fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 10),
        const Divider(),
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: settingsItemsFeedback(context).length,
            itemBuilder: (BuildContext context, int x) {
              return CustomListItem(
                title: settingsItemsFeedback(context)[x].title,
                imageUrl: settingsItemsFeedback(context)[x].icon,
                hideOnTap: settingsItemsFeedback(context)[x].hideIconArrow,
                onTap: () => _executeFunctionOrNavigate(settingsItemsFeedback(context), x, context),
              );
            }),
      ],
    );
  }

  Widget _buildListOfItemsOther(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          Language.s_goodbye,
          style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 20, fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 10),
        const Divider(),
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: settingsItemsOther(context).length,
            itemBuilder: (BuildContext context, int x) {
              return CustomListItem(
                title: settingsItemsOther(context)[x].title,
                imageUrl: settingsItemsOther(context)[x].icon,
                hideOnTap: settingsItemsOther(context)[x].hideIconArrow,
                onTap: () => _executeFunctionOrNavigate(settingsItemsOther(context), x, context),
              );
            }),
      ],
    );
  }

  Widget _buildAppVersion(BuildContext context) {
    return Text('v.${context.watch<LoginProvider>().appVersion}');
  }


  void _executeFunctionOrNavigate(List<SettingsItemModel> list, int x, BuildContext context) {
    if (list[x].route != null && list[x].route!.isNotEmpty) {
      if (list[x].arguments != null) {
        Navigator.of(context).pushNamed(list[x].route!, arguments: list[x].arguments);
      } else {
        Navigator.of(context).pushNamed(list[x].route!);
      }
    } else {
      if (list[x].function != null) {
        list[x].function!();
      }
    }
  }
}
