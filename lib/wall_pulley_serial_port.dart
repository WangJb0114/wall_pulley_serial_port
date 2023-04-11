
import 'wall_pulley_serial_port_platform_interface.dart';

class WallPulleySerialPort {
  Future<String?> getPlatformVersion() {
    return WallPulleySerialPortPlatform.instance.getPlatformVersion();
  }
}
