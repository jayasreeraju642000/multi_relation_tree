
import 'package:flutter/material.dart';

List<Map<String, dynamic>> nodes = [];
List keys = [];
Map<int, List<Map<String, dynamic>>> menuList = {
  1: [
    {
      "id": 1,
      "parentId": null,
      "name": "father",
      'level': 0,
      'relationID': 0,
      "visited": false
    },
    {
      "id": 2,
      "parentId": 1,
      "name": "mother",
      'level': 0,
      'relationID': 1,
      "visited": false
    },
    {
      "id": 3,
      "parentId": 1,
      "name": "child1",
      'level': 1,
      'relationID': 2,
      "visited": false
    },
    {
      "id": 4,
      "parentId": 1,
      "name": "child2",
      'level': 1,
      'relationID': 2,
      "visited": false
    },
    {
      "id": 5,
      "parentId": 1,
      "name": "child3",
      'level': 1,
      'relationID': 2,
      "visited": false
    },
  ]
};
traversNode(
    {required List<Map<String, dynamic>> menu,
    required Canvas canvas,
    Offset position = Offset.zero}) {
  for (var menuItem in menu) {
    drawNode(canvas, Offset(position.dx+50, position.dy), menuItem["name"]);
    // graph.addNode(Node.Id(menuItem));

    keys.add(menuItem["id"] ?? 0);
    if (menuList.keys.contains(menuItem["id"])) {
      if (!menuItem["visited"]) {
        traversNode(
            menu: menuList[menuItem["id"]]!,
            canvas: canvas,
            position: position);
        menuItem['visited'] = true;

        if (keys.isNotEmpty &&
            keys.contains(menuItem['id']) &&
            menuItem['visited']) {
          // Node parentNode = nodes
          //     .where(
          //       (node) =>
          //           (node.key!.value as MenuModel).menuMId == menuItem.parentId,
          //     )
          //     .first;
          // // (menus
          // //     .where((element) => element.menuMId == menuItem.parentId)
          // //     .first);
          // Node child = nodes
          //     .where(
          //       (node) =>
          //           (node.key!.value as MenuModel).menuMId == menuItem.menuMId,
          //     )
          //     .first;
          // // graph.getNodeUsingId(menuItem);

          // graph.addEdge(parentNode, child,
          //     paint: Paint()
          //       ..color = (parentNode.key!.value as MenuModel).menuMId == 0
          //           ? Colors.transparent
          //           : Colors.pink);

          keys.removeLast();
        }
      }
    } else {
      // // if (menuItem.parentId != 0) {
      // // Node parentNode = graph.getNodeUsingId(menus
      // //     .where((element) => element.menuMId == menuItem.parentId)
      // //     .first);
      // // Node child = graph.getNodeUsingId(menuItem);
      // // graph.addEdge(parentNode, child);
      // Node parentNode = nodes
      //     .where(
      //       (node) =>
      //           (node.key!.value as MenuModel).menuMId == menuItem.parentId,
      //     )
      //     .first;
      // Node child = nodes
      //     .where(
      //       (node) =>
      //           (node.key!.value as MenuModel).menuMId == menuItem.menuMId,
      //     )
      //     .first;

      // graph.addEdge(parentNode, child,
      //     paint: Paint()
      //       ..color = (parentNode.key!.value as MenuModel).menuMId == 0
      //           ? Colors.transparent
      //           : Colors.pink);
      // // }
      menuItem['visited'] = true;
      if (keys.isNotEmpty && menuItem['visited']) {
        keys.removeLast();
      }
    }
  }
}

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

void drawHorizontalEdge(Canvas canvas, Offset start, Offset end) {
  Paint edgePaint = Paint()
    ..color = Colors.black
    ..strokeWidth = 2.0;

  canvas.drawLine(start, end, edgePaint);
}

traverseEdge({
  required Canvas canvas,
}) {
  Map<int, Map<String, dynamic>> nodeMap = {};
  for (var node in nodes) {
    if (nodeMap.keys.contains(node["level"])) {
      (nodeMap[node["level"]] as List<Map<String, dynamic>>).add(node);
    } else {
      nodeMap.addEntries({node["level"] as int: node}.entries);
    }
  }
 
}
