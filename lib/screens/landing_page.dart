import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_app/widgets/layouts/slider_layout.dart';
import 'package:group_app/widgets/custom_font.dart';

class LandingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: onBordingBody(),
    );
  }

  Widget onBordingBody() => Container(
    child: SliderLayoutView(),
  );
}