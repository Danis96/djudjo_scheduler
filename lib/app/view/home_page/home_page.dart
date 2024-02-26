import 'package:djudjo_scheduler/app/models/appointment_model.dart';
import 'package:djudjo_scheduler/app/providers/appointment_provider/appointment_provider.dart';
import 'package:djudjo_scheduler/app/utils/extensions/int_extensions.dart';
import 'package:djudjo_scheduler/app/utils/extensions/string_extensions.dart';
import 'package:djudjo_scheduler/generated/assets.dart';
import 'package:djudjo_scheduler/routing/routes.dart';
import 'package:djudjo_scheduler/widgets/app_bars/custom_wave_clipper.dart';
import 'package:djudjo_scheduler/widgets/appointment_card/appointment_card.dart';
import 'package:djudjo_scheduler/widgets/loaders/loader_app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

import '../../../theme/color_helper.dart';
import '../../../widgets/app_bars/common_app_bar.dart';
import '../../providers/stupidity_provider/stupidity_provider.dart';
import '../../utils/language/language_strings.dart';
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
    _getInitialData();
    super.initState();
  }

  Future<void> _getInitialData({bool isFromPull = false}) async {
    if (!isFromPull) {
      customFutureBuilderLoader(context: context);
    }
    await context.read<AppointmentProvider>().fetchAppointments();
    await context.read<StupidityProvider>().fetchStupidities();
    setState(() {});
    if (!isFromPull) {
      Navigator.of(context).pop();
    }
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
        action: _buildNotificationWidget(context),
      );

  Widget _buildNotificationWidget(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 11),
        child: GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(Notifications, arguments: context.read<AppointmentProvider>()),
            child: Stack(
              alignment: Alignment.topRight,
              children: <Widget>[
                const Icon(Icons.notifications),
                if (context.watch<AppointmentProvider>().appointmentsNotConfirmed.isNotEmpty)
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                  )
                else
                  const SizedBox(),
              ],
            )),
      );

  Widget _buildBody(BuildContext context) {
    return LiquidPullToRefresh(
      backgroundColor: Colors.black,
      color: ColorHelper.towerBronze.color,
      height: 50,
      showChildOpacityTransition: false,
      onRefresh: () => _getInitialData(isFromPull: true),
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          ClipPath(
              clipper: BackgroundWaveClipper(),
              child: Container(
                height: 140,
                width: double.infinity,
                color: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                child: context.watch<StupidityProvider>().stupidityOn
                    ? Text(
                        context.read<StupidityProvider>().models.isNotEmpty
                            ? context.read<StupidityProvider>().models.first.textValue!
                            : '',
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(color: ColorHelper.white.color, fontSize: 30),
                      )
                    : const SizedBox(),
              )),
          if (context.watch<AppointmentProvider>().appointmentsConfirmed.isNotEmpty) _buildHeadline(context),
          if (context.watch<AppointmentProvider>().appointmentsConfirmed.isNotEmpty) const SizedBox(height: 20),
          if (context.watch<AppointmentProvider>().appointmentsConfirmed.isNotEmpty)
            _listOfAppointments(context)
          else
            _buildEmptyState(context),
        ],
      ), // scroll view
    );
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
              onTap: () {
                context.read<AppointmentProvider>().isImagePicked = false;
                Navigator.of(context)
                    .pushNamed(NewAppointment, arguments: context.read<AppointmentProvider>())
                    .then((Object? value) => _getInitialData());
              },
              child: const Icon(Icons.add, size: 30),
            ),
          ],
        ),
      );

  Widget _listOfAppointments(BuildContext context) {
    return GroupedListView<Appointment, String>(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      elements: context.watch<AppointmentProvider>().appointmentsConfirmed,
      groupBy: (Appointment element) => element.suggestedDate!.returnDatetimeFormattedForGrouping(),
      groupSeparatorBuilder: (String date) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(date.returnDateMonthForHomeSeparator(),
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 24)),
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
          name: element.name ?? '',
          day: element.suggestedDate != null ? element.suggestedDate!.returnDateDayForHomeCard() : '',
          month: element.suggestedDate != null ? element.suggestedDate!.returnDateMonthForHomeCard() : '',
          phone: element.phone ?? '',
          time: element.allDay != null && element.allDay!
              ? Language.home_all_day
              : element.suggestedTime != null
                  ? element.suggestedTime!.returnTimeForHomeCard()
                  : '',
          dotColor: element.hashCode.getRandomColor(),
          finished: element.appointmentFinished ?? false,
        );
      },
      floatingHeader: true,
      order: GroupedListOrder.ASC, // optional
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(Assets.assetsHomeEmpty, height: 160),
        const SizedBox(height: 15),
        const Text(Language.home_empty),
      ],
    );
  }
}
