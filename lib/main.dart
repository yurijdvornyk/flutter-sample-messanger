import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:sample_messanger/ui/conversations_page.dart';

import 'device_type_util.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MessangerApp());
}

class MessangerApp extends StatelessWidget {
  Brightness? get _brightness =>
      SchedulerBinding.instance?.window.platformBrightness;

  static const _PRIMARY_COLOR = const Color(0xff6a1b9a);
  static const _ACCENT_COLOR = const Color(0xffff8f00);

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: setOrientation(),
        initialData: null,
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) =>
            snapshot.hasData
                ? MaterialApp(
                    title: 'Sample Messanger',
                    home: ConversationsPage(),
                    theme: ThemeData(
                      brightness: _brightness,
                      primaryColor: _PRIMARY_COLOR,
                      accentColor: _ACCENT_COLOR,
                      accentColorBrightness: _brightness,
                      iconTheme: IconThemeData(color: _ACCENT_COLOR),
                      accentIconTheme: Brightness.dark == _brightness
                          ? IconThemeData(color: _ACCENT_COLOR)
                          : IconThemeData(color: _PRIMARY_COLOR),
                    ),
                  )
                : Container(),
      );

  Future<bool> setOrientation() async {
    final orientation = deviceType == DeviceType.PHONE
        ? Orientation.portrait
        : deviceType == DeviceType.TABLET
            ? Orientation.landscape
            : null;

    if (Orientation.portrait == orientation) {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    } else if (Orientation.landscape == orientation) {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }
    return true;
  }
}
