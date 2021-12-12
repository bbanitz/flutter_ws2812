import 'package:flutter/material.dart';
//import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_ws2812/view/led_view.dart';
import 'package:flutter_ws2812/view/led_widget.dart';
import 'package:provider/provider.dart';
import '../model/led_infos.dart';
import '../providers/led_provider.dart';
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';

class LedArray extends StatefulWidget {
  const LedArray({Key? key}) : super(key: key);
  @override
  State<LedArray> createState() => _LedArrayState();
}

class _LedArrayState extends State<LedArray> {
  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color(0xff443a49);
  bool picker = false;
  void changeColor(Color color) {
    Provider.of<LedProvider>(context, listen: false).setPickerColor(color);
  }

  Widget ledBuilder(int index) {
    //print('index $index x:${Provider.of<LedProvider>(context, listen: false).ledInfos[index].posX} y:${Provider.of<LedProvider>(context, listen: false).ledInfos[index].posY}');
    return InkWell(
      onTap: () {
        if (Provider.of<LedProvider>(context, listen: false)
                .ledInfos[index]
                .numero ==
            -1) {
          Provider.of<LedProvider>(context, listen: false)
                  .ledInfos[index]
                  .numero =
              Provider.of<LedProvider>(context, listen: false).currentIndex++;
        }
        Provider.of<LedProvider>(context, listen: false).setColor(index,
            Provider.of<LedProvider>(context, listen: false).pickerColor);
      },
      child: Card(
        //color: Colors.blue,
        margin: const EdgeInsets.all(1),
        /*
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        */
        //onPressed: () {},
        child: Container(
          color: Colors.green,
          width: 20,
          height: 20,
          child: Led(index: index),
        ),
      ),
    );
  }

  Widget rowBuilder(int base) {
    List<Widget> elements = [];
    for (int i = 0; i < Provider.of<LedProvider>(context).colCount; i++) {
      elements.add(Expanded(
          child: Center(
              child: ledBuilder(
                  i + base * Provider.of<LedProvider>(context).colCount))));
    }
    return Row(
      children: elements,
    );
  }

  Widget colBuilder() {
    List<Widget> elements = [];
    for (int i = 0; i < Provider.of<LedProvider>(context).rowCount; i++) {
      elements.add(rowBuilder(i));
    }
    return Column(children: elements);
  }

  @override
  Widget build(BuildContext context) {
    return colBuilder();
  }
}
