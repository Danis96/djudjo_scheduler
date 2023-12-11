import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/appointment_provider/appointment_provider.dart';


class AppointmentImageSliderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _imgSlider(context);
  }
}

Widget _imgSlider(BuildContext context) =>
    FanCarouselImageSlider(imagesLink: context.watch<AppointmentProvider>().assetsForSlider, isAssets: true);
