library multi_relation_tree;

import 'package:flutter/material.dart';

/// A Calculator.
class MultiRelationTree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CustomPaint(
      painter: MyPainter(),
    );
  }

  /// Returns [value] plus 1.
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double horizontalDistance = 100.0;
    final double verticalDistance = 50.0;

    // Draw nodes
    drawNode(
        canvas, Offset(size.width / 2 - horizontalDistance, 150), "Father");
    drawNode(
        canvas, Offset(size.width / 2 + horizontalDistance, 150), "Mother");
    drawNode(canvas, Offset(size.width / 2, 250), "Child");

    // Draw edges
    drawHorizontalEdge(canvas, Offset(size.width / 2 - horizontalDistance, 150),
        Offset(size.width / 2 + horizontalDistance, 150));
    drawVerticalEdge(
        canvas, Offset(size.width / 2, 150), Offset(size.width / 2, 250));
  }

  void drawNode(Canvas canvas, Offset position, String text) {
    Paint nodePaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0
      ..style = PaintingStyle.fill;

    TextPainter textPainter = TextPainter(
      text: TextSpan(
          text: text, style: TextStyle(fontSize: 12.0, color: Colors.red)),
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(canvas, position - Offset(20, 25));
    canvas.drawRect(
        Rect.fromPoints(position, position + Offset(50, 25)), nodePaint);
  }

  void drawHorizontalEdge(Canvas canvas, Offset start, Offset end) {
    Paint edgePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0;

    canvas.drawLine(start, end, edgePaint);
  }

  void drawVerticalEdge(Canvas canvas, Offset start, Offset end) {
    Paint edgePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0;

    canvas.drawLine(start, Offset(end.dx, start.dy), edgePaint);
    canvas.drawLine(Offset(end.dx, start.dy), end, edgePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
