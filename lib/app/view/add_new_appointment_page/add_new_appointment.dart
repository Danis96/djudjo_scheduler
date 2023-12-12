import 'package:djudjo_scheduler/app/providers/appointment_provider/appointment_provider.dart';
import 'package:djudjo_scheduler/app/utils/extensions/string_extensions.dart';
import 'package:djudjo_scheduler/widgets/buttons/common_button.dart';
import 'package:djudjo_scheduler/widgets/custom_picker/custom_picker.dart';
import 'package:djudjo_scheduler/widgets/dialogs/simple_dialog.dart';
import 'package:djudjo_scheduler/widgets/favorite_heart/favorite_heart.dart';
import 'package:djudjo_scheduler/widgets/loaders/loader_app_dialog.dart';
import 'package:djudjo_scheduler/widgets/modal_sheet/custom_modal_sheet.dart';
import 'package:djudjo_scheduler/widgets/switches/switch_with_title_description.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:time_range/time_range.dart';

import '../../../routing/routes.dart';
import '../../../theme/color_helper.dart';
import '../../../widgets/app_bars/common_app_bar.dart';
import '../../../widgets/text_fields/custom_text_form_field.dart';
import '../../utils/language/language_strings.dart';

class NewAppointmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(context), body: _buildBody(context), bottomNavigationBar: _buildBottomBar(context));
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) => commonAppBar(
        context,
        color: ColorHelper.white.color,
        icon: Icons.arrow_back_ios,
        leadingIconColor: ColorHelper.black.color,
        onLeadingTap: () => Navigator.of(context).pop(),
        action: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: FavoriteHeart(
              onTap: () => context.read<AppointmentProvider>().setIsFavorite(),
              isSelected: context.watch<AppointmentProvider>().isFavorite),
        ),
      );

  Widget _buildBody(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        const SizedBox(height: 20),
        _buildHeadline(context),
        const SizedBox(height: 20),
        _buildForm(context),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildHeadline(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            Language.ana_headline,
            style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 24, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildIsFinishedSwitch(context),
          const SizedBox(height: 20),
          _buildMandatoryFields(context),
          _buildOptionalFields(context),
        ],
      ),
    );
  }

  Widget _buildMandatoryFields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(Language.ana_mandatory_title, style: Theme.of(context).textTheme.displayMedium),
        ),
        _buildDivider(context),
        const SizedBox(height: 10),
        _buildNameField(context),
        _buildPhoneField(context),
        _buildEmailField(context),
        _buildTimeField(context),
        const SizedBox(height: 30),
        _buildDateField(context),
      ],
    );
  }

  Widget _buildOptionalFields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(Language.ana_optional_title, style: Theme.of(context).textTheme.displayMedium),
        ),
        _buildDivider(context),
        const SizedBox(height: 10),
        _buildGenderRadio(context),
        const SizedBox(height: 10),
        _buildPlacementField(context),
        _buildSizeField(context),
        _buildDescriptionField(context),
        const SizedBox(height: 30),
        _buildUploadImg(context),
      ],
    );
  }

  Widget _buildGenderRadio(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            Language.ana_gender_title,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          RadioGroup<String>.builder(
            groupValue: context.watch<AppointmentProvider>().genderValue,
            onChanged: (String? value) {
              context.read<AppointmentProvider>().setChosenGender(value!);
            },
            items: context.read<AppointmentProvider>().genders,
            itemBuilder: (String item) => RadioButtonBuilder<dynamic>(item),
            fillColor: ColorHelper.towerBronze.color,
            direction: Axis.horizontal,
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(BuildContext context) => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: SizedBox(width: 100, child: Divider()),
      );

  Widget _buildNameField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomTextFormField(
        controller: context.read<AppointmentProvider>().nameController,
        hintText: Language.ana_name_hint,
        key: const Key('ana_name'),
        onFieldSubmitted: (String? s) {
          FocusScope.of(context).nextFocus();
        },
      ),
    );
  }

  Widget _buildPhoneField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomTextFormField(
        controller: context.read<AppointmentProvider>().phoneController,
        hintText: Language.ana_phone_hint,
        inputFormatters: <TextInputFormatter>[context.read<AppointmentProvider>().maskFormatterPhone],
        keyboardType: TextInputType.phone,
        key: const Key('ana_phone'),
        onFieldSubmitted: (String? s) {
          FocusScope.of(context).nextFocus();
        },
      ),
    );
  }

  Widget _buildEmailField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomTextFormField(
        controller: context.read<AppointmentProvider>().emailController,
        hintText: Language.ana_email_hint,
        keyboardType: TextInputType.emailAddress,
        key: const Key('ana_email'),
        onFieldSubmitted: (String? s) {
          FocusScope.of(context).nextFocus();
        },
      ),
    );
  }

  final TextStyle _timeRangeStyle = TextStyle(fontSize: 18, color: ColorHelper.black.color);

  Widget _buildTimeField(BuildContext context) {
    return TimeRange(
        fromTitle: Text(Language.ana_from_time, style: _timeRangeStyle),
        toTitle: Text(Language.ana_to_time, style: _timeRangeStyle),
        titlePadding: 24,
        textStyle: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black87),
        activeTextStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        borderColor: ColorHelper.black.color,
        backgroundColor: Colors.transparent,
        activeBackgroundColor: ColorHelper.towerBronze.color,
        firstTime: context.read<AppointmentProvider>().firstTime,
        lastTime: context.read<AppointmentProvider>().lastTime,
        timeStep: 10,
        timeBlock: 30,
        alwaysUse24HourFormat: true,
        onRangeCompleted: (TimeRangeResult? range) {
          if (range != null) {
            final String _start = range.start.toString().returnSplittedTime();
            final String _end = range.end.toString().returnSplittedTime();
            context.read<AppointmentProvider>().timeController.text = _start + '-' + _end;
          }
        });
  }

  Widget _buildDateField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomTextFormField(
        controller: context.read<AppointmentProvider>().dateController,
        hintText: Language.ana_date_hint,
        icon: const Icon(Icons.calendar_today_rounded),
        readOnly: true,
        onTap: () => showDateRangeModal(context),
        key: const Key('ana_date'),
        onFieldSubmitted: (String? s) {
          FocusScope.of(context).nextFocus();
        },
      ),
    );
  }

  Widget _buildPlacementField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomTextFormField(
        controller: context.read<AppointmentProvider>().placementController,
        hintText: Language.ana_placement_hint,
        key: const Key('ana_placement'),
      ),
    );
  }

  Widget _buildSizeField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomCmPicker(
        heightController: context.read<AppointmentProvider>().sizeController,
        hint: Language.ana_size_hint,
        onFieldSubmitted: (String? s) {
          FocusScope.of(context).nextFocus();
        },
      ),
    );
  }

  Widget _buildDescriptionField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomTextFormField(
        controller: context.read<AppointmentProvider>().descriptionController,
        hintText: Language.ana_description_hint,
        type: TextFieldType.textAreaType,
        key: const Key('ana_description'),
        onFieldSubmitted: (String? s) {
          FocusScope.of(context).nextFocus();
        },
      ),
    );
  }

  Widget _buildIsFinishedSwitch(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomSwitchWithTitleDescription(
        onChanged: (bool value) {
          context.read<AppointmentProvider>().setAppointmentFinished(value);
          if (context.read<AppointmentProvider>().isSelectedDateInPast()) {
            customSimpleDialog(
              context,
              buttonText: Language.common_ok,
              title: Language.ana_past_date_issue,
              content: Language.ana_past_content,
            );
          }
        },
        showIconAndTitle: false,
        removePadding: true,
        switchBool: context.watch<AppointmentProvider>().isSelectedDateInPast() || context.watch<AppointmentProvider>().appointmentFinished,
        switchActiveColor: ColorHelper.black.color,
        subTitle: Language.ana_manually_finished,
      ),
    );
  }

  Widget _buildUploadImg(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('upload img to Google drive');
        context.read<AppointmentProvider>().setImageToController('Set text');
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: <Widget>[
            Image.asset('assets/ic_img_upload.png', height: 50),
            const Text(Language.ana_img),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 15),
      child: CommonButton(
        onPressed: () {
          customLoaderCircleWhite(context: context);
          context.read<AppointmentProvider>().addAppointment().then((String? error) {
            Navigator.of(context).pop();
            if (error != null) {
              customSimpleDialog(context, title: Language.common_error, content: error, buttonText: Language.common_ok);
            } else {
              context.read<AppointmentProvider>().clearControllers();
              showSuccessModal(context);
            }
          });
        },
        buttonTitle: Language.ana_button,
      ),
    );
  }

  void showDateRangeModal(BuildContext context) {
    showModalBottomSheet<dynamic>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: (BuildContext ctx) {
        return ListenableProvider<AppointmentProvider>.value(
          value: context.read<AppointmentProvider>(),
          child: CustomModalSheet(
            title: Language.ana_choose_date,
            bodyWidget: SfDateRangePicker(
              view: DateRangePickerView.month,
              navigationMode: DateRangePickerNavigationMode.snap,
              selectionMode: DateRangePickerSelectionMode.range,
              endRangeSelectionColor: ColorHelper.black.color,
              rangeSelectionColor: ColorHelper.towerBronze.color.withOpacity(0.5),
              selectionColor: ColorHelper.towerBronze.color,
              todayHighlightColor: ColorHelper.towerBronze.color,
              selectionShape: DateRangePickerSelectionShape.rectangle,
              monthCellStyle: DateRangePickerMonthCellStyle(todayTextStyle: TextStyle(color: ColorHelper.towerBronze.color)),
              monthViewSettings: const DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) =>
                  context.read<AppointmentProvider>().setFormattedDateRange(args),
              controller: context.read<AppointmentProvider>().dateRangePickerController,
            ),
            bottomWidget: const SizedBox(),
          ),
        );
      },
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
        return ListenableProvider<AppointmentProvider>.value(
          value: context.read<AppointmentProvider>(),
          child: CustomModalSheet(
            height: 400,
            title: Language.ana_success_title,
            onClosePressed: () => Navigator.of(context).pushNamed(Home),
            bodyWidget: Container(
                child: Column(
              children: <Widget>[
                Image.asset('assets/success.png', height: MediaQuery.of(context).size.height / 3),
                const SizedBox(height: 30),
                Text(Language.ana_success_subtitle,
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(fontWeight: FontWeight.w400, fontSize: 18)),
              ],
            )),
            bottomWidget: CommonButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Home);
              },
              buttonTitle: Language.common_ok,
            ),
          ),
        );
      },
    );
  }
}
