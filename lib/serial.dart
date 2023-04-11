import 'package:flutter_serial_port_api/flutter_serial_port_api.dart';
import 'dart:async';
import 'dart:typed_data';
import 'package:stream_transform/stream_transform.dart';
import 'package:wall_pulley_serial_port/instruct.dart';

class SerialUtils {
  SerialPort? _serialPort;
  bool _isListener = false;

  final debounceTransformer = StreamTransformer<Uint8List, dynamic>.fromBind(
      (s) => s.transform(debounceBuffer(const Duration(milliseconds: 10))));

  /// 初始化串口    deviceName:串口名  baudrate:端口号
  void initState(String deviceName, int baudrate) {
    _getSerialList(deviceName, baudrate);
  }

  _getSerialList(String deviceName, int baudrate) async {
    await FlutterSerialPortApi.listDevices().then((value) async {
      Device theDevice = Device(deviceName, deviceName);
      _serialPort =
          await FlutterSerialPortApi.createSerialPort(theDevice, baudrate);
    });
  }

  /// 判断串口是否已连接
  Future<bool?> isConnected() async {
    if (_serialPort?.isConnected == true) {
      return true;
    } else {
      return false;
    }
  }

  ///打开串口
  Future<bool?> openPort() async {
    return await _serialPort?.open();
  }

  ///关闭串口
  Future<bool?> closePort() async {
    return await _serialPort?.close();
  }

  ///监听数据返回
  void initListener(
      Function(bool isPlay) isPlay,
      Function(double lbs) lbs,
      Function(int right, int left) wt,
      Function(int seconds) seconds,
      Function(int calories) calories,
      Function(int left, int right) count) {
    _isListener = true;
    _serialPort?.receiveStream.transform(debounceTransformer).listen((event) {
      String recvData = _formatReceivedData(event);
      if (_isListener) {
        List<String> data = [];
        for (var i = 0; i < recvData.length - 2; i++) {
          if (i % 2 == 0) {
            String a = recvData.substring(i, i + 2);
            data.add(a);
          }
        }
        if (data[0] == "A2" && data[1] == "61") {
          if (data[2] == "01") {
            isPlay(true);
          } else {
            isPlay(false);
          }
          lbs(((int.parse(data[4], radix: 16) * 256 +
                      int.parse(data[5], radix: 16)) /
                  10)
              .toDouble());
          wt(int.parse(data[8], radix: 16), int.parse(data[9], radix: 16));
          seconds(int.parse(data[10], radix: 16) * 256 +
              int.parse(data[11], radix: 16));
          calories(int.parse(data[12], radix: 16) * 256 +
              int.parse(data[13], radix: 16));
          count(
              int.parse(data[14], radix: 16) * 256 +
                  int.parse(data[15], radix: 16),
              int.parse(data[16], radix: 16) * 256 +
                  int.parse(data[17], radix: 16));
        }
      }
    });
  }

  ///关闭数据监听
  void closeListener() {
    _isListener = false;
  }

  ///发送数据
  void _initSend(String writData) {
    _serialPort?.write(Uint8List.fromList(_hexToUnits(writData)));
  }

  List<int> _hexToUnits(String hexStr, {int combine = 2}) {
    hexStr = hexStr.replaceAll(" ", "");
    List<int> hexUnits = [];
    for (int i = 0; i < hexStr.length; i += combine) {
      hexUnits.add(_hexToInt(hexStr.substring(i, i + combine)));
    }
    return hexUnits;
  }

  int _hexToInt(String hex) {
    return int.parse(hex, radix: 16);
  }

  String _formatReceivedData(recv) {
    return recv
        .map((List<int> char) => char.map((c) => _intToHex(c)).join())
        .join();
  }

  String _intToHex(int i, {int pad = 2}) {
    return i.toRadixString(16).padLeft(pad, '0').toUpperCase();
  }

  void changeLBs(double lbs) {
    var a = (lbs - 0.5) * 10;
    if (a > 255) {
      _initSend("026303020${a.toInt().toRadixString(16)}0003");
    } else {
      _initSend("0263030200${a.toInt().toRadixString(16)}0003");
    }
  }

  ///开始
  void play() {
    _initSend(PLAY);
  }

  ///暂停
  void suspend() {
    _initSend(SUSPEND);
  }

  ///结束
  void end() {
    _initSend(END);
  }

  ///查询
  void inquire() {
    _initSend(INQUIRE);
  }
}
