import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wall_pulley_serial_port/wall_pulley_serial_port_method_channel.dart';

void main() {
  MethodChannelWallPulleySerialPort platform = MethodChannelWallPulleySerialPort();
  const MethodChannel channel = MethodChannel('wall_pulley_serial_port');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
