import 'package:card_slider/card_slider.dart';
import 'package:djudjo_scheduler/app/providers/appointment_provider/appointment_provider.dart';
import 'package:djudjo_scheduler/widgets/tab_bar/tab_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/color_helper.dart';
import '../../../widgets/app_bars/common_app_bar.dart';
import '../../../widgets/app_bars/custom_wave_clipper.dart';

class AppointmentDetailsPage extends StatefulWidget {
  AppointmentDetailsPage({super.key});

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
    TabBarModel(title: 'Info'),
    TabBarModel(title: 'Images'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabBarItems.length,
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: _buildBody(context),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) => commonAppBar(
        context,
        color: ColorHelper.white.color,
        icon: Icons.arrow_back_ios,
        leadingIconColor: ColorHelper.black.color,
        titleColor: ColorHelper.black.color,
        bottomWidget: _buildTabBar(),
        title: 'November, 12 - Danis',
        action: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: GestureDetector(
              onTap: () {
                print('Open edit page');
              },
              child: const Icon(Icons.edit, color: Colors.black)),
        ),
      );

  PreferredSizeWidget _buildTabBar() {
    return customTabBar(
      widgetKey: const Key('quick_assist_tab_bar_key'),
      items: _tabBarItems,
      unselectedLabelColor: ColorHelper.white.color.withOpacity(0.5),
    );
  }

  Widget _buildBody(BuildContext context) {
    return TabBarView(children: [
      SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _imgSlider(context),
            _buildHeadline(context),
            _buildMandatoryInfoSegment(context),
            const SizedBox(height: 50),
          ],
        ),
      ),
      const SizedBox(),
    ]);
  }
}

Widget _imgSlider(BuildContext context) {
  return CardSlider(
    cards: context.watch<AppointmentProvider>().valuesWidget,
    bottomOffset: .0008,
    itemDotOffset: -0.05,
  );
}

Widget _buildHeadline(BuildContext context) {
  return Column(
    children: <Widget>[
      Text(
        'Appointment Details',
        style: TextStyle(fontSize: 24),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Divider(),
      ),
    ],
  );
}

Widget _buildMandatoryInfoSegment(BuildContext context) {
  return Card(
    color: ColorHelper.black.color,
    elevation: 10,
    child: Column(
      children: <Widget>[
        _buildInfoTile(context, Icons.person, 'Danis'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildInfoTile(context, Icons.email_outlined, 'danis.preldzic@gmail.com'),
            _buildInfoTile(context, Icons.phone, '062-748/065'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildInfoTile(context, Icons.access_time_filled_outlined, '11:00 h - 13:00 h'),
            _buildInfoTile(context, Icons.date_range, '21.11.2023'),
          ],
        ),
      ],
    ),
  );
}

Widget _buildInfoTile(BuildContext context, IconData icon, String data) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: <Widget>[
        Icon(icon, color: ColorHelper.white.color.withOpacity(0.7)),
        const SizedBox(
          width: 2,
        ),
        Text(data, style: TextStyle(color: ColorHelper.white.color.withOpacity(0.7))),
      ],
    ),
  );
}
