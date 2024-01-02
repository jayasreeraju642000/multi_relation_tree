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
    addFamily(currentNode.parentId, currentNode.level, Offset.zero);
    double currentNodeLevel = 50.0;
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
      debugPrint(menus[i].dy.toString());
      drawNode(
          canvas, Offset(menus[i].dx, menus[i].dy), menus[i].name as String);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  addFamily(int? parentId, int? level, Offset offset) {
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
      addFamily(temp[i].id, temp[i].level, offset);
    }
  }
}
