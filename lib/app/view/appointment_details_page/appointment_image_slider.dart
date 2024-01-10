import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:djudjo_scheduler/app/utils/language/language_strings.dart';
import 'package:djudjo_scheduler/generated/assets.dart';
import 'package:djudjo_scheduler/theme/color_helper.dart';
import 'package:djudjo_scheduler/widgets/dialogs/simple_dialog.dart';
import 'package:djudjo_scheduler/widgets/loaders/loader_app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widgets/image_slider/custom_image_slider.dart';
import '../../../widgets/snackbar/custom_snackbar.dart';
import '../../providers/appointment_provider/appointment_provider.dart';

class AppointmentImageSliderPage extends StatefulWidget {
  @override
  State<AppointmentImageSliderPage> createState() => _AppointmentImageSliderPageState();
}

class _AppointmentImageSliderPageState extends State<AppointmentImageSliderPage> {
  @override
  Widget build(BuildContext context) {
    return context.watch<AppointmentProvider>().assetsForSlider.isNotEmpty
        ? _imgSlider(context)
        : Center(child: Image.asset(Assets.assetsImgEmpty, width: 100));
  }

  Widget _imgSlider(BuildContext context) => CustomCarouselImageSlider(
        imagesLink: context.watch<AppointmentProvider>().assetsForSlider,
        isAssets: false,
        onIndexChanged: (int currentIndex) {
          print('Current Index: $currentIndex');
          context.read<AppointmentProvider>().setCurrentSliderIndex(currentIndex);
        },
        initalPageIndex: 0,
        indicatorActiveColor: ColorHelper.black.color,
        expandedCloseChild: _closeAndDelete(context),
      );

  Widget _closeAndDelete(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Expanded(child: Icon(Icons.arrow_back, size: 30)),
          Expanded(
            child: IconButton(
              onPressed: () async {
                customLoaderCircleWhite(context: context);
                await context.read<AppointmentProvider>().deleteImage().then((String? error) {
                  Navigator.of(context).pop();
                  if (error != null) {
                    customSimpleDialog(context, title: Language.common_error, buttonText: Language.common_ok, content: error);
                  } else {
                    setState(() {});
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(customSnackBar(
                        snackBarTitle: Language.ana_success_title,
                        snackBarMessage: Language.ana_success_subtitle,
                        snackBarContentType: ContentType.success,
                      ));
                  }
                });
              },
              icon: Icon(Icons.delete, size: 30, color: ColorHelper.towerRed.color),
            ),
          ),
        ],
      ),
    );
  }
}
