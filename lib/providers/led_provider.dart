import 'package:flutter/material.dart';
import 'package:flutter_ws2812/model/led_infos.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class LedProvider with ChangeNotifier {
  int colCount = 16;
  int rowCount = 8;
  int currentIndex = 0;
  Color pickerColor = Colors.red;
  List<LedInfos> ledInfos = [];
  LedProvider() {
    initLedInfos();
  }

  initLedInfos() {
    ledInfos = [];
    for (int y = 0; y < rowCount; y++) {
      for (int x = 0; x < colCount; x++) {
        ledInfos.add(LedInfos(-1, x, y));
        //print('x:$x y:$y');
      }
    }
  }

  setPickerColor(Color color) {
    pickerColor = color;
    notifyListeners();
  }

  setColor(int index, Color color) {
    ledInfos[index].color = color;
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
      if (element.numero != -1) {
        if (!first) {
          ledInfosStr += ',';
        } else {
          first = false;
        }
        ledInfosStr += element.toJson().toString();
      }
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
