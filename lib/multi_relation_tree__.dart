library multi_relation_tree;



import 'dart:core';

import 'package:flutter/material.dart';
import 'package:multi_relation_tree/calculate_layout.dart';
import 'package:multi_relation_tree/data.dart';
import 'package:multi_relation_tree/draw_nodes.dart';
import 'package:multi_relation_tree/node_model.dart';

class MultiRelationTree extends StatelessWidget {
  const MultiRelationTree({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.only(left: 100),
        child: CustomPaint(
          painter: MyPainter(),
        ),
      ),
    );
  }
}

const nodeWidth = 100.0;
const nodeGapX = 100.0;
const nodeGapY = 100.0;
const nodeHeight = 20.0;

class MyPainter extends CustomPainter {
  static Offset familyStartPosition = const Offset(50, 50);
  Paint edgePaint = Paint()
    ..color = Colors.black
    ..strokeWidth = 2.0;
  var menus = data.map((e) => NodeModel.fromMap(e)).toList();
  Map<int, Map<int, int>> idBasedLevelNodesCount = {};

  @override
  void paint(Canvas canvas, Size size) {
    NodeModel currentNode =
        menus.firstWhere((element) => element.id == element.parentId);
    addFamily(currentNode.parentId, currentNode.level);
    print(idBasedLevelNodesCount);
    double currentNodeLevel = 25.0;
    for (var parentId in idBasedLevelNodesCount.keys) {
      var tempList =
          menus.where((element) => element.parentId == parentId).toList();
      var currentNodeData =
          menus.firstWhere((element) => element.id == parentId);
      currentNodeLevel = (currentNodeData.level ?? 0) < 0
          ? currentNodeLevel - 50
          : (currentNodeData.level ?? 0) > 0
              ? currentNodeLevel + 50
              : currentNodeLevel;
      calculateLayout(tempList, currentNodeLevel, currentNodeData.dx);
    }
    for (int i = 0; i < menus.length; i++) {
      drawNode(
          canvas, Offset(menus[i].dx, menus[i].dy), menus[i].name as String);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  addFamily(
    int? parentId,
    int? level,
  ) {
    List<NodeModel> temp =
        menus.where((element) => element.parentId == parentId).toList();

    int levelZero = temp.where((element) => element.level == 0).length;
    int levelParents = temp.where((element) => element.level == -1).length;
    int levelChild = temp.where((element) => element.level == 1).length;
    if (levelZero != 0 || levelParents != 0 || levelChild != 0) {
      if (idBasedLevelNodesCount.keys.contains(parentId)) {
        return;
      } else {
        idBasedLevelNodesCount.addEntries({
          parentId ?? 0: {0: levelZero, -1: levelParents, 1: levelChild}
        }.entries);
      }
    }
    for (int i = 0; i < temp.length; i++) {
      if ((temp[i].level ?? 0) < 0) {
        temp[i].dy -= 50;
      }
      addFamily(
        temp[i].id,
        temp[i].level,
      );
    }
  }
}


// library multi_relation_tree;

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

// import 'dart:core';

// import 'package:flutter/material.dart';
// import 'package:multi_relation_tree/draw_edges.dart';
// import 'package:multi_relation_tree/draw_nodes.dart';

// class MultiRelationTree extends StatelessWidget {
//   const MultiRelationTree({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       painter: MyPainter(),
//     );
//   }
// }

// enum Relation { self, married, child, parent }

// class MyPainter extends CustomPainter {
//   var position = const Offset(0, 50);
//   @override
//   void paint(Canvas canvas, Size size) {
//     const double horizontalDistance = 100.0;

//     var menus = [
//       {
//         "id": 1,
//         "parentId": 1,
//         "name": "father",
//         'level': 0,
//         'relationID': 0,
//       },
//       {
//         "id": 2,
//         "parentId": 1,
//         "name": "mother",
//         'level': 0,
//         'relationID': 1,
//       },
//       {
//         "id": 3,
//         "parentId": 1,
//         "name": "child1",
//         'level': 1,
//         'relationID': 2,
//       },
//       {
//         "id": 4,
//         "parentId": 1,
//         "name": "child2",
//         'level': 1,
//         'relationID': 2,
//       },
//       {
//         "id": 4,
//         "parentId": 1,
//         "name": "child3",
//         'level': 1,
//         'relationID': 2,
//       },
//     ];
//     double dx = 0;
//     double dy = 50;
//     int previousLevel = 0;
//     CalculateLayout(menus);
//     for (int i = 0; i < menus.length; i++) {
//       if (menus[i]["level"] as int != previousLevel) {
//         previousLevel = menus[i]["level"] as int ;
//         dx = 0;
//         dy += 100;
//       }
//       drawNode(canvas, Offset(dx, dy), menus[i]["name"] as String);
//       dx += 150;
      
//     }


    

//     // // Draw nodes
//     // drawNode(
//     //     canvas, Offset(size.width / 2 - horizontalDistance, 150), "Father");
//     // drawNode(
//     //     canvas, Offset(size.width / 2 + horizontalDistance, 150), "Mother");
//     // drawNode(canvas, Offset(size.width / 2 - 50 - horizontalDistance, 250),
//     //     "Child1");
//     // drawNode(canvas, Offset(size.width / 2, 250), "Child2");
//     // drawNode(canvas, Offset(size.width / 2 + 50 + horizontalDistance, 250),
//     //     "Child3");

//     // // // Draw edges
//     // drawHorizontalEdge(
//     //     canvas,
//     //     Offset(size.width / 2 - horizontalDistance / 2, 150),
//     //     Offset(size.width / 2 + horizontalDistance / 2, 150));
//     // Paint childVerticalPaint = Paint()
//     //   ..color = Colors.red
//     //   ..style = PaintingStyle.stroke
//     //   ..strokeWidth = 3;
//     // canvas.drawLine(
//     //     Offset((size.width / 2 - 50 - horizontalDistance), 200),
//     //     Offset((size.width / 2 - 50 - horizontalDistance), 240),
//     //     childVerticalPaint);
//     // canvas.drawLine(Offset((size.width / 2), 200),
//     //     Offset((size.width / 2), 240), childVerticalPaint);
//     // canvas.drawLine(
//     //     Offset((size.width / 2 + 50 + horizontalDistance), 200),
//     //     Offset((size.width / 2 + 50 + horizontalDistance), 240),
//     //     childVerticalPaint);
//     // canvas.drawLine(
//     //     Offset((size.width / 2 - 50 - horizontalDistance), 200),
//     //     Offset((size.width / 2 + 50 + horizontalDistance), 200),
//     //     childVerticalPaint);
//     // canvas.drawLine(Offset((size.width / 2), 200), Offset(size.width / 2, 150),
//     //     childVerticalPaint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }

// void getPossibleNodePosition(int nodeCount, int maxSpace, int nodeWidth, int nodeHeight)
//   {
//     if(nodeCount == 1)
//     {
//       double dx = (maxSpace - nodeWidth) / 2;
//       print("Position $dx");
//     }
//     else{
//       for(int i = 1; i <= nodeCount; i++)
//       {
//         double dx = (((i - 1) / (nodeCount - 1)) * (maxSpace - nodeWidth));
//         print("Position $dx");
//     }
//     }
//   }

//   List<int> getUniqueRelation(List<Map<String, Object>> menus)
//   {
//     Set<int> uniqueRelation = Set<int>();

//     menus.forEach((item){
//       uniqueRelation.add(item['relationID'] as int);
//     });

//     return uniqueRelation.toList();
//   }

//   List<Map<String, dynamic>> filterRelation(int relation, List<Map<String, dynamic>> menus)
//   {
//    return menus.where((element) => element['relationID'] == relation).toList();
//   }

//  Map<int, Map<String, dynamic>>layoutMap = {};

//   void CalculateLayout(List<Map<String, Object>> menus)
//   {
//     final nodeWidth = 100;
//     final nodeGapX = 100;
//     final nodeHeight = 20;
//     final nodeGapY = 100;

//      Map<int, int> tempLayout = {};
//     //1. Get unique relation IDs.
//     final uniqueRelation = getUniqueRelation(menus);

//     //2. Get filtered data and iterate over relation.
//     for(var relation in uniqueRelation)
//     {
//       var filteredRelation = filterRelation(relation, menus);
//       print("Relation $relation Count ${filteredRelation.length}");
//       tempLayout[relation] = filteredRelation.length;
//     }

//     //3. Sort from bottom to top 
//     List<MapEntry<int, int>> sortedLayoutEntries = tempLayout.entries.toList() ..sort((a, b) => b.value.compareTo(a.value));

//     //4. Calculate position of nodes
//     int maxSpaceX = ((sortedLayoutEntries.first.value * nodeWidth) + ((sortedLayoutEntries.first.value - 1) * nodeGapX));
//     int maxSpaceY = ((sortedLayoutEntries.first.key * nodeHeight) + ((sortedLayoutEntries.first.key - 1) * nodeGapY));
//   print("MaxSpace $maxSpaceY $maxSpaceX");
//     for(var item in sortedLayoutEntries)
//     {
//       if(item.key == 0)
//       {
//         print("Parent");
//         // handle key 1 also
//         getPossibleNodePosition(2, maxSpaceX, nodeWidth, nodeHeight);
//       }
//       if(item.key == 1)
//       {
//         // key already handled
//         continue;
//       }
//       else
//       {
//         print("Child");
//         getPossibleNodePosition(item.value, maxSpaceX, nodeWidth, nodeHeight);
//       }
//     }
//   }
// }
