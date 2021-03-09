import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';

enum DeviceType {
  PHONE,
  TABLET,
  DESKTOP,
  WEB,
}

DeviceType get deviceType {
  if (kIsWeb) {
    return DeviceType.WEB;
  } else if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
    return DeviceType.DESKTOP;
  } else if (_isTablet) {
    return DeviceType.TABLET;
  } else {
    return DeviceType.PHONE;
  }
}

// I took this check from here: https://pub.dev/packages/flutter_device_type
bool get _isTablet {
  final pixelRatio = ui.window.devicePixelRatio;
  final width = ui.window.physicalSize.width;
  final height = ui.window.physicalSize.height;
  return (pixelRatio < 2 && (width >= 1000 || height >= 1000)) ||
      (pixelRatio == 2 && (width >= 1920 || height >= 1920));
}
