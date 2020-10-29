import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:group_app/widgets/layouts/slider_layout.dart';
import 'package:group_app/widgets/custom_font.dart';

class MainPage extends StatefulWidget {
  @override
  MainPageState createState() {
    return new MainPageState();
  }
}
class MainPageState extends State<MainPage> {
  int _selectedTabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('GroupApp!'),
        trailingActions: <Widget>[
          PlatformIconButton(
            padding: EdgeInsets.zero,
            icon: Icon(context.platformIcons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: PlatformText('EZ'),
      bottomNavBar: PlatformNavBar(
        currentIndex: _selectedTabIndex,
        itemChanged: (index) => setState(
          () {
          _selectedTabIndex = index;
          },
        ),
        items: [
          BottomNavigationBarItem(
            label: 'Flag',
            icon: PlatformWidget(
              cupertino: (_, __) => Icon(CupertinoIcons.flag),
              material: (_, __) => Icon(Icons.flag),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Book',
            icon: PlatformWidget(
              cupertino: (_, __) => Icon(CupertinoIcons.book),
              material: (_, __) => Icon(Icons.book),
            ),
          ),
        ],
      ),
      iosContentPadding: true,
      iosContentBottomPadding: true,
    );
  }
}

