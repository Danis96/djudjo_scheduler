import 'package:djudjo_scheduler/app/providers/appointment_provider/appointment_provider.dart';
import 'package:djudjo_scheduler/app/utils/language_strings.dart';
import 'package:djudjo_scheduler/app/view/appointment_details/appointment_image_slider.dart';
import 'package:djudjo_scheduler/app/view/appointment_details/appointment_info.dart';
import 'package:djudjo_scheduler/routing/routes.dart';
import 'package:djudjo_scheduler/widgets/tab_bar/tab_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/color_helper.dart';
import '../../../widgets/app_bars/common_app_bar.dart';

class AppointmentDetailsPage extends StatefulWidget {
  @override
  State<AppointmentDetailsPage> createState() => _AppointmentDetailsPageState();
}

class _AppointmentDetailsPageState extends State<AppointmentDetailsPage> {
  @override
  void initState() {
    _getInitialData();
    super.initState();
  }

  Future<void> _getInitialData() async {
    context.read<AppointmentProvider>().setValuesForSlider();
  }

  final List<TabBarModel> _tabBarItems = <TabBarModel>[
    const TabBarModel(title: Language.ad_tab_info),
    const TabBarModel(title: Language.ad_tab_img),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: _tabBarItems.length, child: Scaffold(appBar: _buildAppBar(context), body: _buildBody(context)));
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) => commonAppBar(
        context,
        color: ColorHelper.white.color,
        icon: Icons.arrow_back_ios,
        leadingIconColor: ColorHelper.black.color,
        titleColor: ColorHelper.black.color,
        bottomWidget: _buildTabBar(),
        preferredSizeForBottom: const Size(300, 50),
        action: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: GestureDetector(
            onTap: () {
              context.read<AppointmentProvider>().clearControllersEdit();
              context.read<AppointmentProvider>().setDataForEdit();
              Navigator.of(context)
                  .pushNamed(EditAppointment, arguments: context.read<AppointmentProvider>())
                  .then((Object? value) => setState(() {}));
            },
            child: const Icon(Icons.edit, color: Colors.black),
          ),
        ),
      );

  PreferredSizeWidget _buildTabBar() {
    return customTabBar(
      widgetKey: const Key('quick_assist_tab_bar_key'),
      items: _tabBarItems,
      unselectedLabelColor: ColorHelper.black.color.withOpacity(0.5),
      labelColor: ColorHelper.black.color,
      hasIndicator: true,
      indicatorColor: ColorHelper.black.color,
    );
  }

  Widget _buildBody(BuildContext context) {
    return TabBarView(
        physics: const NeverScrollableScrollPhysics(), children: <Widget>[AppointmentInfoPage(), AppointmentImageSliderPage()]);
  }
}
