import 'package:flutter/material.dart';

void drawHorizontalEdge(Canvas canvas, Offset start, Offset end) {
  Paint edgePaint = Paint()
    ..color = Colors.black
    ..strokeWidth = 2.0;

  canvas.drawLine(start, end, edgePaint);
}
