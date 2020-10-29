import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
class Slider {
  final String sliderImageUrl;
  final String sliderHeading;
  final String sliderSubHeading;

  Slider(
      {@required this.sliderImageUrl,
        @required this.sliderHeading,
        @required this.sliderSubHeading});
}

var sliderArrayList = [
  Slider(
      sliderImageUrl: 'assets/images/slider_1.png',
      sliderHeading: tr("SLIDER_HEADING_1"),
      sliderSubHeading: tr("SLIDER_DESC")),
  Slider(
      sliderImageUrl: 'assets/images/slider_2.png',
      sliderHeading: tr("SLIDER_HEADING_2"),
      sliderSubHeading: tr("SLIDER_DESC")),
  Slider(
      sliderImageUrl: 'assets/images/slider_3.png',
      sliderHeading: tr("SLIDER_HEADING_3"),
      sliderSubHeading: tr("SLIDER_DESC")),
];