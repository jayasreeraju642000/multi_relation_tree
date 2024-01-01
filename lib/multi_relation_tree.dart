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

import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';

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
  static const nodeWidth = 100;
  static const nodeGapX = 100;
  static const nodeGapY = 100;
  static const nodeHeight = 20;
  static Offset familyStartPosition = const Offset(50, 50);
  Paint edgePaint = Paint()
    ..color = Colors.black
    ..strokeWidth = 2.0;
  var menus = [
    {
      "id": 1,
      "parentId": 1,
      'level': 0,
      "name": "Jayasree",
      'relationID': 0,
    },
    {
      "id": 2,
      "parentId": 1,
      "name": "Ranjith",
      'level': 0,
      'relationID': 1,
    },
    {
      "id": 3,
      "parentId": 1,
      "name": "Sreejith",
      'level': 1,
      'relationID': 2,
    },
    {
      "id": 4,
      "parentId": 1,
      "name": "Sreeraj",
      'level': 1,
      'relationID': 2,
    },
    {
      "id": 5,
      "parentId": 1,
      'level': -1,
      "name": "Raju K B",
      'relationID': 3,
    },
    {
      "id": 6,
      "parentId": 1,
      'level': -1,
      "name": "Bindu Raju",
      'relationID': 3,
    },
    {
      "id": 7,
      "parentId": 2,
      "name": "Mayadevi",
      'level': -1,
      'relationID': 1,
    },
    {
      "id": 8,
      "parentId": 2,
      "name": "Sasidharan",
      'level': -1,
      'relationID': 1,
    },
    {
      "id": 9,
      "parentId": 5,
      "name": "Balakrishnan",
      'level': -1,
      'relationID': 1,
    },
    {
      "id": 10,
      "parentId": 5,
      "name": "Mallika",
      'level': -1,
      'relationID': 1,
    },
  ].map((e) => NodeModel.fromMap(e)).toList();

  @override
  void paint(Canvas canvas, Size size) {
    calculateLayout(menus);
    NodeModel currentNode =
        menus.firstWhere((element) => element.id == element.parentId);
    addFamily(currentNode.parentId, currentNode.level, Offset.zero);
    // for (int i = 0; i < menus.length; i++) {
    //   debugPrint(menus[i].dy.toString());
    //   drawNode(
    //       canvas, Offset(menus[i].dx, menus[i].dy), menus[i].name as String);
    // }

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

  List<Offset> getPossibleNodePosition(
    int nodeCount,
    int maxSpace,
    int nodeWidth,
    int nodeHeight,
    int level,
  ) {
    double dy = (level < 0) ? 50 : (level == 0 ? 150 : 250);

    if (nodeCount == 1) {
      double dx = (maxSpace - nodeWidth) / 2;

      debugPrint("Position $dx");
      return [Offset(dx, dy)];
    } else {
      List<Offset> offsetList = [];
      for (int i = 1; i <= nodeCount; i++) {
        double dx = (((i - 1) / (nodeCount - 1)) * (maxSpace - nodeWidth));
        offsetList.add(Offset(dx, dy));
        debugPrint("Position $dx");
      }
      return offsetList;
    }
  }

  List<int> getUniqueRelation(List<NodeModel> menus) {
    Set<int> uniqueRelation = <int>{};
    menus.sort(
      (a, b) => a.level!.compareTo(b.level!),
    );
    for (var item in menus) {
      uniqueRelation.add(item.level as int);
    }

    return uniqueRelation.toList();
  }

  List<NodeModel> filterRelation(int relation, List<NodeModel> menus) {
    return menus.where((element) => element.level == relation).toList();
  }

  Map<int, Map<String, dynamic>> layoutMap = {};

  void calculateLayout(List<NodeModel> menus) {
    const nodeWidth = 100;
    const nodeGapX = 100;
    const nodeHeight = 20;
    const nodeGapY = 100;

    Map<int, int> tempLayout = {};
    //1. Get unique relation IDs.
    final uniqueRelation = getUniqueRelation(menus);

    //2. Get filtered data and iterate over relation.
    for (var relation in uniqueRelation) {
      var filteredRelation = filterRelation(relation, menus);
      debugPrint("Relation $relation Count ${filteredRelation.length}");
      tempLayout[relation] = filteredRelation.length;
    }

    //3. Sort from top to bottom
    List<MapEntry<int, int>> sortedLayoutEntries = tempLayout.entries.toList();
    sortedLayoutEntries.sort((a, b) => a.value.compareTo(b.value));

    //4. Calculate position of nodes
    int maxSpaceX = ((sortedLayoutEntries.first.value * nodeWidth) +
        ((sortedLayoutEntries.first.value - 1) * nodeGapX));
    int maxSpaceY = ((sortedLayoutEntries.first.key * nodeHeight) +
        ((sortedLayoutEntries.first.key - 1) * nodeGapY));
    debugPrint("MaxSpace $maxSpaceY $maxSpaceX");
    for (var item in sortedLayoutEntries) {
      debugPrint(item.key.toString());

      if (item.key < 0) {
        debugPrint("grand");

        List<Offset> parentNodeOffsets = (getPossibleNodePosition(
            item.value, maxSpaceX, nodeWidth, nodeHeight, -1));
        List<NodeModel> parentNodes = filterRelation(item.key, menus);
        for (int i = 0; i < parentNodes.length; i++) {
          menus.where((e) => e == parentNodes[i]).first
            ..dx = parentNodeOffsets[i].dx
            ..dy = parentNodeOffsets[i].dy;
        }
        // handle key 1 also
      } else if (item.key == 0) {
        debugPrint("Parent");
        List<Offset> parentNodeOffsets = (getPossibleNodePosition(
            item.value, maxSpaceX, nodeWidth, nodeHeight, 0));
        List<NodeModel> parentNodes = filterRelation(item.key, menus);
        for (int i = 0; i < parentNodes.length; i++) {
          menus.where((e) => e == parentNodes[i]).first
            ..dx = parentNodeOffsets[i].dx
            ..dy = parentNodeOffsets[i].dy;
        }
      } else {
        debugPrint("Child");
        List<Offset> parentNodeOffsets = (getPossibleNodePosition(
            item.value, maxSpaceX, nodeWidth, nodeHeight, 1));
        List<NodeModel> parentNodes = filterRelation(item.key, menus);
        for (int i = 0; i < parentNodes.length; i++) {
          menus.where((e) => e == parentNodes[i]).first
            ..dx = parentNodeOffsets[i].dx
            ..dy = parentNodeOffsets[i].dy;
        }
      }
    }
  }

  startBuilding() {}

  // To add generation based on level
  addFamily(int? parentId, int? level, Offset offset) {
    List<NodeModel> temp =
        menus.where((element) => element.parentId == parentId).toList();

    int levelZero = temp.where((element) => element.level == 0).length;
    int levelParents = temp.where((element) => element.level == -1).length;
    int levelChild = temp.where((element) => element.level == 1).length;

print('parents : $levelParents\nchild : $levelChild\npartner:  $levelParents\n ' );
    // 1. find maximum space

    print(temp);
  }

  Offset findParent(
    int? parentId,
  ) {
    return Offset(0, 0);
  }
}

class NodeModel {
  int? id;
  int? parentId;
  String? name;
  int? level;
  int? relationID;
  double dx;
  double dy;
  NodeModel({
    this.id,
    this.parentId,
    this.name,
    this.level,
    this.relationID,
    this.dx = 0.0,
    this.dy = 0.0,
  });

  NodeModel copyWith({
    int? id,
    int? parentId,
    String? name,
    int? level,
    int? relationID,
    double? dx,
    double? dy,
  }) {
    return NodeModel(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      name: name ?? this.name,
      level: level ?? this.level,
      relationID: relationID ?? this.relationID,
      dx: dx ?? this.dx,
      dy: dy ?? this.dy,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'parentId': parentId,
      'name': name,
      'level': level,
      'relationID': relationID,
      'dx': dx,
      'dy': dy,
    };
  }

  factory NodeModel.fromMap(Map<String, dynamic> map) {
    return NodeModel(
      id: map['id'] != null ? map['id'] as int : null,
      parentId: map['parentId'] != null ? map['parentId'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      level: map['level'] != null ? map['level'] as int : null,
      relationID: map['relationID'] != null ? map['relationID'] as int : null,
      dx: map['dx'] ?? 0.0,
      dy: map['dy'] ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory NodeModel.fromJson(String source) =>
      NodeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NodeModel(id: $id, parentId: $parentId, name: $name, level: $level, relationID: $relationID, dx: $dx, dy: $dy)';
  }

  @override
  bool operator ==(covariant NodeModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.parentId == parentId &&
        other.name == name &&
        other.level == level &&
        other.relationID == relationID &&
        other.dx == dx &&
        other.dy == dy;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        parentId.hashCode ^
        name.hashCode ^
        level.hashCode ^
        relationID.hashCode ^
        dx.hashCode ^
        dy.hashCode;
  }
}
