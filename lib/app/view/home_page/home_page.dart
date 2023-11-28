import 'package:djudjo_scheduler/app/models/appointment_model.dart';
import 'package:djudjo_scheduler/app/providers/appointment_provider/appointment_provider.dart';
import 'package:djudjo_scheduler/app/utils/int_extensions.dart';
import 'package:djudjo_scheduler/app/utils/string_extensions.dart';
import 'package:djudjo_scheduler/routing/routes.dart';
import 'package:djudjo_scheduler/widgets/app_bars/custom_wave_clipper.dart';
import 'package:djudjo_scheduler/widgets/appointment_card/appointment_card.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:provider/provider.dart';

import '../../../theme/color_helper.dart';
import '../../../widgets/app_bars/common_app_bar.dart';
import '../../providers/stupidity_provider/stupidity_provider.dart';
import '../../utils/language_strings.dart';
import 'home_page_drawer.dart';

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
    await context.read<StupidityProvider>().fetchStupidities();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: buildDrawer(context),
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
        action: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: <Widget>[
              GestureDetector(
                  onTap: () => print('See UnConfirmed list'),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: <Widget>[
                      const Icon(Icons.notifications),
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      );

  Widget _buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ClipPath(
            clipper: BackgroundWaveClipper(),
            child: Container(
              height: 140,
              width: double.infinity,
              color: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              child: Text(
                context.read<StupidityProvider>().models.isNotEmpty ? context.read<StupidityProvider>().models.first.textValue! : '',
                style: Theme.of(context).textTheme.displayLarge!.copyWith(color: ColorHelper.white.color, fontSize: 30),
              ),
            )),
        _buildHeadline(context),
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
              style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 28, fontWeight: FontWeight.w700)),
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(NewAppointment, arguments: context.read<AppointmentProvider>()),
            child: const Icon(Icons.add, size: 30),
          ),
        ],
      ),
    );

Widget _listOfAppointments(BuildContext context) {
  return GroupedListView<Appointment, String>(
    shrinkWrap: true,
    padding: const EdgeInsets.symmetric(horizontal: 24),
    elements: context.watch<AppointmentProvider>().appointments,
    groupBy: (Appointment element) => element.suggestedDate.returnDatetimeFormattedForGrouping(),
    groupSeparatorBuilder: (String date) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(date.returnDateMonthForHomeSeparator(), style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 24)),
            const Divider(),
          ],
        ),
      );
    },
    itemBuilder: (BuildContext context, Appointment element) {
      return AppointmentCard(
        onCardPressed: () {
          context.read<AppointmentProvider>().setAppointmentDetails(element);
          Navigator.of(context).pushNamed(AppointmentDetails, arguments: context.read<AppointmentProvider>());
        },
        name: element.name,
        day: element.suggestedDate.returnDateDayForHomeCard(),
        month: element.suggestedDate.returnDateMonthForHomeCard(),
        phone: element.phone,
        time: element.suggestedTime.returnTimeForHomeCard(),
        dotColor: element.hashCode.getRandomColor(),
        finished: element.appointmentFinished,
      );
    },
    floatingHeader: true,
    order: GroupedListOrder.ASC, // optional
  );
}
