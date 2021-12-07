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
    return Container(
      color: Colors.black,
      height: 20,
      width: 20,
      child: InkWell(
        onTap: () {
          Provider.of<LedProvider>(context, listen: false).setColor(index,
              Provider.of<LedProvider>(context, listen: false).pickerColor);
        },
        child: LedWidget(
            color: Provider.of<LedProvider>(context).getLedInfos(index).color),
      ),
    );
  }
}
