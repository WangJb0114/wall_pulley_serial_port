import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'wall_pulley_serial_port_platform_interface.dart';

/// An implementation of [WallPulleySerialPortPlatform] that uses method channels.
class MethodChannelWallPulleySerialPort extends WallPulleySerialPortPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('wall_pulley_serial_port');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
