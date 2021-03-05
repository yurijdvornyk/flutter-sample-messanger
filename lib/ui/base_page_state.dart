import 'package:flutter/material.dart';
import 'package:sample_messanger/device_type_utils.dart';

abstract class BasePageState<W extends StatefulWidget> extends State<W> {
  Widget buildPhoneState(BuildContext context) => Container();
  Widget buildTabletState(BuildContext context) => Container();
  Widget buildWebState(BuildContext context) => Container();
  Widget buildDesktopState(BuildContext context) => Container();

  @override
  Widget build(BuildContext context) {
    switch (deviceType) {
      case DeviceType.PHONE:
        return buildPhoneState(context);
      case DeviceType.TABLET:
        return buildTabletState(context);
      case DeviceType.DESKTOP:
        return buildDesktopState(context);
      case DeviceType.WEB:
        return buildWebState(context);
      default:
        return Container();
    }
  }
}
