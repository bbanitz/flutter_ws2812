import 'package:flutter/material.dart';

class LedInfos {
  LedInfos(this.numero, this.posX, this.posY);
  int? numero;
  int? posX;
  int? posY;
  Color color = Colors.black;

  Map<String, dynamic> toJson() {
    return {
      'numero': numero,
      'posX': posX,
      'posY': posY,
      'color': color.value.toRadixString(16),
    };
  }
}
