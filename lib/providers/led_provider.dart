import 'package:flutter/material.dart';
import 'package:flutter_ws2812/model/led_infos.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class LedProvider with ChangeNotifier {
  int colCount = 9 * 8;
  int rowCount = 16;
  Color pickerColor = Colors.red;
  List<LedInfos> ledInfos = [];
  LedProvider() {
    initLedInfos();
  }

  initLedInfos() {
    ledInfos = [];
    for (int i = 0; i < colCount * rowCount; i++) {
      ledInfos.add(LedInfos(i));
    }
  }

  LedInfos getLedInfos(int index) {
    return ledInfos[index - 1];
  }

  setPickerColor(Color color) {
    pickerColor = color;
    notifyListeners();
  }

  setColor(int index, Color color) {
    getLedInfos(index).color = color;
    notifyListeners();
  }

  setLedInfos(int index, LedInfos infos) {
    ledInfos[index - 1] = infos;
    notifyListeners();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  String ledInfosToJson() {
    String ledInfosStr = '[';
    bool first = true;
    for (var element in ledInfos) {
      if (!first) {
        ledInfosStr += ',';
      } else {
        first = false;
      }
      ledInfosStr += element.toJson().toString();
    }
    ledInfosStr += ']';
    print(ledInfosStr);
    _localPath.then((value) {
      print(value);
      File file = File(value + '/test.txt');
      file.create();
      file.writeAsString(ledInfosStr);
    });
    return ledInfosStr;
  }
}
