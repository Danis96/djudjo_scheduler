import 'package:djudjo_scheduler/app/models/appointment_model.dart';
import 'package:djudjo_scheduler/app/providers/appointment_provider/appointment_provider.dart';
import 'package:djudjo_scheduler/app/utils/language/language_strings.dart';
import 'package:djudjo_scheduler/generated/assets.dart';
import 'package:djudjo_scheduler/widgets/dialogs/simple_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../../../routing/routes.dart';
import '../../../theme/color_helper.dart';
import '../../../widgets/app_bars/common_app_bar.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }
}

PreferredSizeWidget _buildAppBar(BuildContext context) => commonAppBar(
      context,
      color: ColorHelper.white.color,
      icon: Icons.arrow_back_ios,
      leadingIconColor: ColorHelper.black.color,
      title: Language.not_app_bar_title,
      titleColor: ColorHelper.black.color,
    );

Widget _buildBody(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: context.watch<AppointmentProvider>().appointmentsNotConfirmed.isNotEmpty
        ? _buildNotificationBox(context)
        : Container(height: MediaQuery.of(context).size.height / 1.4, child: Center(child: _buildEmptyState(context))),
  );
}

Widget _buildNotificationBox(BuildContext context, {bool showIcon = true}) {
  return Column(
    children: <Widget>[
      const SizedBox(height: 50),
      Container(
        height: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(Language.not_headline_title, style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 20)),
                GestureDetector(
                  child: const Icon(Icons.info_outline),
                  onTap: () => _showInfoDialog(context),
                )
              ],
            ),
            const Divider(),
            const SizedBox(height: 10),
            RichText(
              text: TextSpan(children: <TextSpan>[
                TextSpan(text: Language.not_headline_sub1, style: TextStyle(color: Colors.black.withOpacity(0.8))),
                TextSpan(
                  text: '${context.watch<AppointmentProvider>().appointmentsNotConfirmed.length}',
                  style: TextStyle(color: Colors.black.withOpacity(0.8), fontWeight: FontWeight.bold, fontSize: 20),
                ),
                TextSpan(text: Language.not_headline_sub2, style: TextStyle(color: Colors.black.withOpacity(0.8))),
              ]),
            ),
          ],
        ),
      ),
      if (showIcon)
        GestureDetector(
          onTap: () {
            context.read<AppointmentProvider>().setShowUnConfirmedList();
          },
          child: Icon(context.watch<AppointmentProvider>().showUnConfirmedList ? Icons.arrow_drop_down : Icons.arrow_drop_up),
        ),
      const Divider(),
      if (context.watch<AppointmentProvider>().showUnConfirmedList) _buildNotificationsList(context)
    ],
  );
}

void _showInfoDialog(BuildContext context) {
  customSimpleDialog(context,
      buttonText: Language.common_ok,
      contentWidget: Container(
        height: 140,
        child: Column(
          children: <Widget>[
            Image.asset(Assets.assetsInfo, height: 60),
            const Divider(),
            const SizedBox(height: 10),
            const Text(Language.not_info_content),
          ],
        ),
      ));
}

Widget _buildNotificationsList(BuildContext context) {
  return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: context.watch<AppointmentProvider>().appointmentsNotConfirmed.length,
      itemBuilder: (BuildContext context, int index) {
        final Appointment app = context.read<AppointmentProvider>().appointmentsNotConfirmed[index];
        return Slidable(
          key: UniqueKey(),
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            dismissible: DismissiblePane(onDismissed: () {
              context.read<AppointmentProvider>().deleteAppointment(app.id!);
            }),
            children: <Widget>[
              SlidableAction(
                onPressed: (BuildContext context) {
                  context.read<AppointmentProvider>().deleteAppointment(app.id!);
                },
                backgroundColor: const Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: Language.not_delete_slide,
              ),
            ],
          ),
          child: _buildNotificationItem(context, app),
        );
      });
}

Widget _buildNotificationItem(BuildContext context, Appointment appointment) {
  return GestureDetector(
    onTap: () {
      context.read<AppointmentProvider>().setAppointmentDetails(appointment);
      context.read<AppointmentProvider>().clearControllersEdit();
      context.read<AppointmentProvider>().setDataForEdit();
      Navigator.of(context).pushNamed(EditAppointment, arguments: context.read<AppointmentProvider>());
    },
    child: Card(
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: ColorHelper.black.color.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(Assets.assetsQuestionMark, height: 60),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(appointment.name ?? '',
                    maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 20)),
                const SizedBox(height: 5),
                Text(appointment.phone ?? '', overflow: TextOverflow.ellipsis),
                const SizedBox(height: 5),
                Text(appointment.email ?? '', overflow: TextOverflow.ellipsis),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildEmptyState(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Image.asset(Assets.assetsEmptyNot, width: 70),
      const SizedBox(height: 10),
      const Text(Language.not_empty_state),
    ],
  );
}
