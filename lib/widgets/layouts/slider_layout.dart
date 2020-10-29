import 'dart:async';
import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth_ui/firebase_auth_ui.dart';
import 'package:firebase_auth_ui/providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_app/constants/constants.dart';
import 'package:group_app/models/slider.dart';
import 'package:group_app/screens/landing_page.dart';
import 'package:group_app/widgets/slide_dots.dart';
import 'package:group_app/widgets/slide_items/slide_item.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SliderLayoutView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SliderLayoutViewState();
}

class _SliderLayoutViewState extends State<SliderLayoutView> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    _currentPage = index;
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context){
    return topSliderLayout();
  }

  Widget topSliderLayout() => Container(
    child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            PageView.builder(
              scrollDirection: Axis.horizontal,
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemCount: sliderArrayList.length,
              itemBuilder: (ctx, i){
                return SlideItem(i);
              },
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                  Offstage(
                    child: Padding(
                        padding: EdgeInsets.only(left: 15.0, bottom: 15.0),
                        child: PlatformButton(
                          onPressed: () {login();},
                          child:PlatformText(tr("SKIP")),
                          materialFlat: (_, __) => MaterialFlatButtonData(),
                          cupertino: (_, __) => CupertinoButtonData(),
                        ),
                      ),
                    offstage:  _currentPage + 1 == sliderArrayList.length,
                  ),
                  Offstage(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          for (int i = 0; i < sliderArrayList.length; i++)
                            if (i == _currentPage)
                              SlideDots(true)
                            else
                              SlideDots(false)
                        ],
                      ),
                    offstage:  _currentPage + 1 == sliderArrayList.length,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 15.0, bottom: 15.0),
                    child: PlatformButton(
                      onPressed: (){
                        if(_pageController.page.round() + 1 == sliderArrayList.length)
                          login();
                        else
                          _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeInExpo);
                      },
                      child:  _currentPage + 1 == sliderArrayList.length ? PlatformText(tr("GET_STARTED")) : PlatformText(tr("NEXT")),
                      material: (_, __) => MaterialRaisedButtonData(),
                      cupertino: (_, __) => CupertinoButtonData(),
                    ),
                  ),
                ]
            )

          ],
        )),
  );
  void login() async{
    FirebaseAuthUi.instance()
        .launchAuth(
      [
        AuthProvider.email(), // Login/Sign up with Email and password
        AuthProvider.google(), // Login with Google
      ],
      tosUrl: "https://my-terms-url", // Optional
      privacyPolicyUrl: "https://my-privacy-policy", // Optional,

    )
        .then((firebaseUser) => Navigator.pushReplacementNamed(context, "/"))
        .catchError((error) => print("Error $error"));
  }

}