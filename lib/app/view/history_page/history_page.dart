import 'package:djudjo_scheduler/app/utils/extensions/int_extensions.dart';
import 'package:djudjo_scheduler/app/utils/extensions/string_extensions.dart';
import 'package:djudjo_scheduler/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

import '../../../routing/routes.dart';
import '../../../theme/color_helper.dart';
import '../../../widgets/app_bars/common_app_bar.dart';
import '../../../widgets/appointment_card/appointment_card.dart';
import '../../models/appointment_model.dart';
import '../../providers/appointment_provider/appointment_provider.dart';
import '../../utils/language/language_strings.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({this.isFromBottom = false});

  final bool isFromBottom;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(context, isFromBottom), body: _buildBody(context));
  }
}

PreferredSizeWidget _buildAppBar(BuildContext context, bool isFromBottom) => commonAppBar(
      context,
      color: ColorHelper.white.color,
      titleColor: Colors.black,
      icon: isFromBottom ? null : Icons.arrow_back_ios,
      title: 'History',
    );

Widget _buildBody(BuildContext context) {
  return LiquidPullToRefresh(
    backgroundColor: Colors.black,
    color: ColorHelper.towerBronze.color,
    height: 50,
    showChildOpacityTransition: false,
    onRefresh: () => context.read<AppointmentProvider>().fetchAppointments(),
    child: ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      shrinkWrap: true,
      children: <Widget>[
        const SizedBox(height: 20),
        _buildHeadline(context),
        const Divider(),
        const SizedBox(height: 20),
        if (context.watch<AppointmentProvider>().appointmentsFinished.isNotEmpty)
          _listOfAppointments(context)
        else
          _buildEmptyState(context),
        const SizedBox(height: 20),
      ],
    ),
  );
}

Widget _buildHeadline(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        width: MediaQuery.of(context).size.width * 0.6,
        child: Text(
          Language.hp_headline_info,
          style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      Image.asset(
        Assets.assetsHistory,
        scale: 7,
      ),
    ],
  );
}

Widget _listOfAppointments(BuildContext context) {
  return GroupedListView<Appointment, String>(
    shrinkWrap: true,
    elements: context.watch<AppointmentProvider>().appointmentsFinished,
    reverse: true,
    groupBy: (Appointment element) => element.suggestedDate!.returnDatetimeFormattedForGrouping(),
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
        name: element.name ?? '',
        day: element.suggestedDate != null ? element.suggestedDate!.returnDateDayForHomeCard() : '',
        month: element.suggestedDate != null ? element.suggestedDate!.returnDateMonthForHomeCard() : '',
        phone: element.phone ?? '',
        time: element.suggestedTime != null ? element.suggestedTime!.returnTimeForHomeCard() : '',
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
