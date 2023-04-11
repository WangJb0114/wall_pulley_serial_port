import 'package:flutter_test/flutter_test.dart';
import 'package:wall_pulley_serial_port/wall_pulley_serial_port.dart';
import 'package:wall_pulley_serial_port/wall_pulley_serial_port_platform_interface.dart';
import 'package:wall_pulley_serial_port/wall_pulley_serial_port_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockWallPulleySerialPortPlatform
    with MockPlatformInterfaceMixin
    implements WallPulleySerialPortPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final WallPulleySerialPortPlatform initialPlatform = WallPulleySerialPortPlatform.instance;

  test('$MethodChannelWallPulleySerialPort is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelWallPulleySerialPort>());
  });

  test('getPlatformVersion', () async {
    WallPulleySerialPort wallPulleySerialPortPlugin = WallPulleySerialPort();
    MockWallPulleySerialPortPlatform fakePlatform = MockWallPulleySerialPortPlatform();
    WallPulleySerialPortPlatform.instance = fakePlatform;

    expect(await wallPulleySerialPortPlugin.getPlatformVersion(), '42');
  });
}
