import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'wall_pulley_serial_port_method_channel.dart';

abstract class WallPulleySerialPortPlatform extends PlatformInterface {
  /// Constructs a WallPulleySerialPortPlatform.
  WallPulleySerialPortPlatform() : super(token: _token);

  static final Object _token = Object();

  static WallPulleySerialPortPlatform _instance = MethodChannelWallPulleySerialPort();

  /// The default instance of [WallPulleySerialPortPlatform] to use.
  ///
  /// Defaults to [MethodChannelWallPulleySerialPort].
  static WallPulleySerialPortPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [WallPulleySerialPortPlatform] when
  /// they register themselves.
  static set instance(WallPulleySerialPortPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
