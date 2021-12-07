import 'package:flutter/material.dart';
import 'package:flutter_ws2812/providers/led_provider.dart';
import 'package:provider/provider.dart';

class OpenPainter extends CustomPainter {
  Color color = Colors.black;
  OpenPainter(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    //a circle
    canvas.drawCircle(Offset(10, 10), 10, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class LedWidget extends StatelessWidget {
  LedWidget({Key? key, required this.color}) : super(key: key);
  Color color = Colors.black;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      child: CustomPaint(
        painter: OpenPainter(color),
      ),
    );
  }
}
