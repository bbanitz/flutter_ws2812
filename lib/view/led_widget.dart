import 'package:flutter/material.dart';
import 'package:flutter_ws2812/providers/led_provider.dart';
import 'package:provider/provider.dart';

class OpenPainter extends CustomPainter {
  Color color = Colors.black;
  BoxConstraints constrain;
  OpenPainter(this.color, this.constrain);
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    //a circle

    canvas.drawCircle(Offset(constrain.maxWidth / 2, constrain.maxHeight / 2),
        constrain.maxWidth / 2, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class LedWidget extends StatelessWidget {
  LedWidget({Key? key, required this.color}) : super(key: key);
  Color color = Colors.black;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constrain) {
        return CustomPaint(painter: OpenPainter(color, constrain));
      },
    );
  }
}
