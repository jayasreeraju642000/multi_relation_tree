import 'package:flutter/material.dart';

void drawNode(Canvas canvas, Offset position, String text) {
  Paint nodePaint = Paint()
    ..color = Colors.blue
    ..strokeWidth = 2.0
    ..style = PaintingStyle.fill;

  TextPainter textPainter = TextPainter(
    text: TextSpan(
        text: text,
        style: const TextStyle(fontSize: 12.0, color: Colors.black)),
    textDirection: TextDirection.ltr,
  )..layout();

  textPainter.paint(canvas, position - const Offset(20, 25));
  canvas.drawRect(
      Rect.fromCenter(center: position, width: 100, height: 20), nodePaint);
}
