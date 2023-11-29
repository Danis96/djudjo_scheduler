import 'package:djudjo_scheduler/app/providers/appointment_provider/appointment_provider.dart';
import 'package:djudjo_scheduler/app/utils/language_strings.dart';
import 'package:djudjo_scheduler/app/utils/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/color_helper.dart';

class AppointmentInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const SizedBox(height: 30),
          _buildHeadline(context),
          _buildMandatoryInfoSegment(context),
          const Padding(padding: EdgeInsets.symmetric(horizontal: 24), child: Divider()),
          const SizedBox(height: 20),
          _buildOptionalInfoSegment(context),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}

Widget _buildHeadline(BuildContext context) {
  return const Column(
    children: <Widget>[
      Text(Language.ad_info_headline, style: TextStyle(fontSize: 24)),
      Padding(padding: EdgeInsets.symmetric(horizontal: 50), child: Divider()),
    ],
  );
}

Widget _buildMandatoryInfoSegment(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 10),
        _buildDescription(context),
        const SizedBox(height: 20),
        _buildInfoTile(context, context.watch<AppointmentProvider>().returnGenderImage(),
            context.watch<AppointmentProvider>().appointmentDetails.name ?? ''),
        _buildInfoTile(context, 'assets/email.png', context.watch<AppointmentProvider>().appointmentDetails.email ?? '',
            onTap: () => context.read<AppointmentProvider>().appointmentDetails.email!.emailTo()),
        _buildInfoTile(context, 'assets/phone.png', context.watch<AppointmentProvider>().appointmentDetails.phone ?? '',
            onTap: () => context.read<AppointmentProvider>().appointmentDetails.phone!.makePhoneCall()),
        _buildInfoTile(context, 'assets/time.png', context.watch<AppointmentProvider>().appointmentDetails.suggestedTime ?? ''),
        _buildInfoTile(context, 'assets/calendar.png', context.watch<AppointmentProvider>().appointmentDetails.suggestedDate ?? ''),
      ],
    ),
  );
}

Widget _buildOptionalInfoSegment(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildInfoTile(context, 'assets/size.png', context.watch<AppointmentProvider>().appointmentDetails.size ?? '', title: 'Size'),
        _buildInfoTile(context, 'assets/tattoo.png', context.watch<AppointmentProvider>().appointmentDetails.placement ?? '',
            title: 'Placement'),
        _buildInfoTile(
            context, 'assets/finished.png', context.watch<AppointmentProvider>().appointmentDetails.appointmentFinished.toString(),
            title: 'Appointment finished'),
        _buildInfoTile(
            context, 'assets/check-green.png', context.watch<AppointmentProvider>().appointmentDetails.appointmentConfirmed.toString(),
            title: 'Appointment approved'),
      ],
    ),
  );
}

Widget _buildDescription(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(Language.ad_info_description, style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 20)),
      const SizedBox(height: 10),
      Text(context.watch<AppointmentProvider>().appointmentDetails.description ?? ''),
    ],
  );
}

Widget _buildInfoTile(BuildContext context, String icon, String data, {String title = '', Function? onTap}) {
  return GestureDetector(
    onTap: () {
      if (onTap != null) {
        onTap();
      }
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          if (title.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[Text(title), const Divider()]),
            )
          else
            const SizedBox(),
          Row(
            children: <Widget>[
              Image.asset(icon, width: 50),
              const SizedBox(width: 5),
              Text(data, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: ColorHelper.black.color.withOpacity(0.7))),
            ],
          ),
        ],
      ),
    ),
  );
}
