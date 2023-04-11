// @dart=2.9

import 'package:flutter/material.dart';
import 'package:wall_pulley_serial_port/serial.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _serialUtils = SerialUtils();

  @override
  void initState() {
    super.initState();
  }

  /// _serialUtils 串口工具类
  ///
  /// 需要先调用initState(deviceName,baudrate)方法初始化串口才能打开串口，否则会串口打开失败
  ///
  /// openPort() 打开串口
  /// closePort() 关闭串口
  /// initListener(...) 数据监听
  /// closeListener() 关闭数据监听
  /// isConnected() return  判断是否已连接串口
  /// play() 开始
  /// suspend() 暂停
  /// end() 结束
  /// changeLBs(double) 修改阻力
  /// inquire() 查询
  ///
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  //初始化串口并连接
                  _serialUtils.initState("/dev/ttyAS2", 115200);
                },
                child: const Text('初始化串口')),
            ElevatedButton(
                onPressed: () {
                  //初始化串口并连接
                  _serialUtils.openPort();
                },
                child: const Text('打开串口')),
            ElevatedButton(
                onPressed: () {
                  //初始化串口并连接
                  _serialUtils.closePort();
                },
                child: const Text('关闭串口')),
            ElevatedButton(
                onPressed: () {
                  initListener();
                },
                child: const Text('打开监听')),
            ElevatedButton(
                onPressed: () {
                  _serialUtils.closeListener();
                },
                child: const Text('关闭监听')),
            ElevatedButton(
                onPressed: () {
                  _serialUtils.play();
                },
                child: const Text('开始')),
            ElevatedButton(
                onPressed: () {
                  _serialUtils.suspend();
                },
                child: const Text('暂停')),
            ElevatedButton(
                onPressed: () {
                  _serialUtils.end();
                },
                child: const Text('停止')),
            ElevatedButton(
                onPressed: () {
                  _serialUtils.changeLBs(2.5);
                },
                child: const Text('修改阻力')),
            ElevatedButton(
                onPressed: () {
                  _serialUtils.inquire();
                },
                child: const Text('查询')),
          ],
        ),
      ),
    );
  }

  ///各项数据返回接口
  void initListener() {
    _serialUtils.initListener(
        (isPlay) => null,
        (lbs) => null,
        (right, left) => null,
        (seconds) => null,
        (calories) => null,
        (left, right) => null);
  }
}
