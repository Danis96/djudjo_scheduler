import 'package:djudjo_scheduler/app/models/appointment_model.dart';
import 'package:djudjo_scheduler/app/providers/appointment_provider/appointment_provider.dart';
import 'package:djudjo_scheduler/app/utils/int_extensions.dart';
import 'package:djudjo_scheduler/app/utils/string_extensions.dart';
import 'package:djudjo_scheduler/routing/routes.dart';
import 'package:djudjo_scheduler/widgets/app_bars/custom_wave_clipper.dart';
import 'package:djudjo_scheduler/widgets/appointment_card/appointment_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/color_helper.dart';
import '../../../widgets/app_bars/common_app_bar.dart';
import '../../../widgets/drawer/custom_drawer.dart';
import '../../utils/drawer_helper.dart';
import '../../utils/language_strings.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _getInitialData(context);
    super.initState();
  }

  Future<void> _getInitialData(BuildContext context) async {
    await context.read<AppointmentProvider>().fetchAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: _buildDrawer(context),
      backgroundColor: ColorHelper.white.color,
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) => commonAppBar(
        context,
        color: ColorHelper.black.color,
        icon: Icons.menu_rounded,
        leadingIconColor: ColorHelper.white.color,
        onLeadingTap: () => _scaffoldKey.currentState!.openDrawer(),
        action: IconButton(
            onPressed: () => Navigator.of(context).pushNamed(NewAppointment, arguments: context.read<AppointmentProvider>()),
            icon: const Icon(Icons.add)),
      );

  Widget _buildDrawer(BuildContext context) {
    final DrawerHelper _drawerHelper = DrawerHelper();

    return CustomDrawer(
      widgetKey: const Key('home_page_drawer_key'),
      actionKey: const Key('drawer_action_home_page_key'),
      onDrawerItemPressed: (String value) {},
      onDrawerOpened: (String value) {},
      wrapWithMaterial: true,
      headerHeight: 208,
      backgroundColor: ColorHelper.white.color,
      actionIconColor: ColorHelper.white.color,
      logoutTitle: 'Logout',
      onLogoutPress: () => print('Logout'),
      onActionIconPress: () => Navigator.of(context).pop(),
      listItems: _drawerHelper.drawerListItems(context),
      labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: ColorHelper.towerNavy2.color),
      logoutStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.w400, color: ColorHelper.towerNavy2.color, fontFamily: 'SourceSansPro'),
      customHeader: Padding(
        padding: const EdgeInsets.only(left: 15, bottom: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset('assets/ic_logo.png', scale: 10),
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    color: ColorHelper.white.color,
                    padding: const EdgeInsets.all(10),
                    child: const Icon(Icons.close),
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
            const SizedBox(height: 5),
            // todo get user data and show email
            // Text(
            //   userProfileProvider.user.email,
            //   style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 12),
            // )
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ClipPath(clipper: BackgroundWaveClipper(), child: Container(height: 60, color: Colors.black)),
        _buildHeadline(context),
        const SizedBox(height: 20),
        _buildTitle(context),
        const SizedBox(height: 20),
        Expanded(child: _listOfAppointments(context)),
      ],
    );
  }
}

Widget _buildHeadline(BuildContext context) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(Language.home_headline,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 24, fontWeight: FontWeight.w700)),
          const Icon(Icons.calendar_month_sharp),
        ],
      ),
    );

Widget _buildTitle(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Text('Today',
        style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 18, color: ColorHelper.black.color.withOpacity(0.5))),
  );
}

Widget _listOfAppointments(BuildContext context) {
  return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      shrinkWrap: true,
      itemCount: context.watch<AppointmentProvider>().appointments.length,
      itemBuilder: (BuildContext context, int index) {
        final Appointment _singleAppointment = context.read<AppointmentProvider>().appointments[index];
        return AppointmentCard(
          name: _singleAppointment.name,
          day: _singleAppointment.suggestedDate.returnDateDayForHomeCard(),
          month: _singleAppointment.suggestedDate.returnDateMonthForHomeCard(),
          phone: _singleAppointment.phone,
          time: _singleAppointment.suggestedTime.returnTimeForHomeCard(),
          dotColor: index.getRandomColor(),
          finished: _singleAppointment.appointmentFinished,
        );
      });
}

/// todo
/// add month/day separator check on pub dev
