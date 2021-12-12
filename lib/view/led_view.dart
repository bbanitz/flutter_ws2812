import 'package:flutter/material.dart';
import 'package:flutter_ws2812/providers/led_provider.dart';
import 'package:provider/provider.dart';

import 'led_widget.dart';

class Led extends StatelessWidget {
  const Led({Key? key, required this.index}) : super(key: key);
  final int index;
  //LedView({index:this.index};)
  @override
  Widget build(BuildContext context) {
    if (Provider.of<LedProvider>(context).ledInfos[index].numero! > -1) {
      return Container(
        color: Colors.black,
        height: 20,
        width: 20,
        child: LedWidget(
            color: Provider.of<LedProvider>(context).ledInfos[index].color),
      );
    } else {
      return Container(
        width: 20,
        height: 20,
      );
    }
  }
}
