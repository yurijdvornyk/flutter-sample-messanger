import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sample_messanger/ui/conversations_page.dart';

import 'device_type_utils.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: setOrientation(),
        initialData: null,
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) =>
            snapshot.hasData
                ? Container()
                : MaterialApp(
                    title: 'Sample Messanger',
                    theme: ThemeData(
                      primarySwatch: Colors.blue,
                    ),
                    home: ConversationsPage(),
                  ));
  }

  Future<void> setOrientation() async {
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
  }
}
