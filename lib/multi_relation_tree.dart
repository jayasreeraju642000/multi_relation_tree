library multi_relation_tree;

// import 'package:flutter/material.dart';

// class MultiRelationTree extends StatelessWidget {
//   const MultiRelationTree({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       painter: MyPainter(),
//     );
//   }

// }

// class MyPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     const double horizontalDistance = 100.0;

//     // Draw nodes
//     drawNode(
//         canvas, Offset(size.width / 2 - horizontalDistance, 150), "Father");
//     drawNode(
//         canvas, Offset(size.width / 2 + horizontalDistance, 150), "Mother");
//     drawNode(canvas, Offset(size.width / 2, 250), "Child");

//     // Draw edges
//     drawHorizontalEdge(canvas, Offset(size.width / 2 - horizontalDistance, 150),
//         Offset(size.width / 2 + horizontalDistance, 150));
//     drawVerticalEdge(
//         canvas, Offset(size.width / 2, 150), Offset(size.width / 2, 250));
//   }

//   void drawNode(Canvas canvas, Offset position, String text) {
//     Paint nodePaint = Paint()
//       ..color = Colors.blue
//       ..strokeWidth = 2.0
//       ..style = PaintingStyle.fill;

//     TextPainter textPainter = TextPainter(
//       text: TextSpan(
//           text: text, style: TextStyle(fontSize: 12.0, color: Colors.red)),
//       textDirection: TextDirection.ltr,
//     )..layout();

//     textPainter.paint(canvas, position - Offset(20, 25));
//     canvas.drawRect(
//         Rect.fromPoints(position, position + Offset(50, 25)), nodePaint);
//   }

//   void drawHorizontalEdge(Canvas canvas, Offset start, Offset end) {
//     Paint edgePaint = Paint()
//       ..color = Colors.black
//       ..strokeWidth = 2.0;

//     canvas.drawLine(start, end, edgePaint);
//   }

//   void drawVerticalEdge(Canvas canvas, Offset start, Offset end) {
//     Paint edgePaint = Paint()
//       ..color = Colors.black
//       ..strokeWidth = 2.0;

//     canvas.drawLine(start, Offset(end.dx, start.dy), edgePaint);
//     canvas.drawLine(Offset(end.dx, start.dy), end, edgePaint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }

import 'package:flutter/material.dart';
import 'package:multi_relation_tree/traverse_node.dart';

class MultiRelationTree extends StatelessWidget {
  const MultiRelationTree({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyPainter(),
    );
  }
}

enum Relation { self, married, child, parent }

class MyPainter extends CustomPainter {
  var position = const Offset(0, 50);
  @override
  void paint(Canvas canvas, Size size) {
    const double horizontalDistance = 100.0;

    var menus = [
      {
        "id": 1,
        "parentId": 1,
        "name": "father",
        'level': 0,
        'relationID': 0,
      },
      {
        "id": 2,
        "parentId": 1,
        "name": "mother",
        'level': 0,
        'relationID': 1,
      },
      {
        "id": 3,
        "parentId": 1,
        "name": "child1",
        'level': 1,
        'relationID': 2,
      },
      {
        "id": 4,
        "parentId": 1,
        "name": "child2",
        'level': 1,
        'relationID': 2,
      },
      {
        "id": 4,
        "parentId": 1,
        "name": "child3",
        'level': 1,
        'relationID': 2,
      },
    ];
    double dx = 0;
    double dy = 50;
    for (int i = 0; i < menus.length; i++) {
      if (menus[i]["level"] as int == 1) {
        dy += 50;
      }
      drawNode(canvas, Offset(dx, dy), menus[i]["name"] as String);
      dx += 150;
      
    }

    // Draw nodes
    // drawNode(
    //     canvas, Offset(size.width / 2 - horizontalDistance, 150), "Father");
    // drawNode(
    //     canvas, Offset(size.width / 2 + horizontalDistance, 150), "Mother");
    // drawNode(canvas, Offset(size.width / 2 - 50 - horizontalDistance, 250),
    //     "Child1");
    // drawNode(canvas, Offset(size.width / 2, 250), "Child2");
    // drawNode(canvas, Offset(size.width / 2 + 50 + horizontalDistance, 250),
    //     "Child3");

    // // // Draw edges
    // drawHorizontalEdge(
    //     canvas,
    //     Offset(size.width / 2 - horizontalDistance / 2, 150),
    //     Offset(size.width / 2 + horizontalDistance / 2, 150));
    // Paint childVerticalPaint = Paint()
    //   ..color = Colors.red
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = 3;
    // canvas.drawLine(
    //     Offset((size.width / 2 - 50 - horizontalDistance), 200),
    //     Offset((size.width / 2 - 50 - horizontalDistance), 240),
    //     childVerticalPaint);
    // canvas.drawLine(Offset((size.width / 2), 200),
    //     Offset((size.width / 2), 240), childVerticalPaint);
    // canvas.drawLine(
    //     Offset((size.width / 2 + 50 + horizontalDistance), 200),
    //     Offset((size.width / 2 + 50 + horizontalDistance), 240),
    //     childVerticalPaint);
    // canvas.drawLine(
    //     Offset((size.width / 2 - 50 - horizontalDistance), 200),
    //     Offset((size.width / 2 + 50 + horizontalDistance), 200),
    //     childVerticalPaint);
    // canvas.drawLine(Offset((size.width / 2), 200), Offset(size.width / 2, 150),
    //     childVerticalPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
