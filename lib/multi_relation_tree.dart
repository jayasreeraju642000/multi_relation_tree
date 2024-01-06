library multi_relation_tree;

import 'dart:core';

import 'package:flutter/material.dart';
import 'package:multi_relation_tree/data.dart';

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

class MyPainter extends CustomPainter {
  List<NodeData> nodeList = sample.map((e) => NodeData.fromMap(e)).toList();
  List<int> visitedNodeIds = [];
  List<NodeData> visitedNodeList = [];
  @override
  void paint(Canvas canvas, Size size) {
    traverseNode(nodeList[0]);
    print(visitedNodeList.map((e) => e.id));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  void traverseNode(NodeData node) {
    print('####################${node.name}################');

    if (!visitedNodeList.contains(node)) {
      visitedNodeList.add(node);
      // print('${node.name} visited');
    }
    NodeData? nextNode = getNextNode(node);
    print("next node: ${nextNode?.name}");
    if (nextNode != null) {
      
      traverseNode(nextNode);
    } else {
      node.visited = true;
      visitedNodeIds.add(node.id ?? -1);
      // NodeData? nextdata = nextNodeMethod();
      // print("******************  ${nextdata?.name}");
      // if (nextdata != null) {
      //   traverseNode(nextdata);
      // }
      return;
    }
  }

  NodeData? nextNodeMethod() {
    visitedNodeList.removeLast();
    if (visitedNodeList.isEmpty) {
      return null;
    }
    return visitedNodeList.last;
  }

  NodeData? getNextNode(NodeData node) {
    print("in next node function    ${node.name}");
    node.relatedData?.sort(
      (a, b) => (a.relationId ?? -1).compareTo(b.relationId ?? -1),
    );
    List<int> relatedUsers =
        node.relatedData?.map((e) => e.relatedUserId ?? -1).toList() ?? [];
    print(relatedUsers);
    var nodeNotVisitedId=relatedUsers
            .indexWhere((element) => !visitedNodeIds.contains(element)) ;
    
    if (nodeNotVisitedId!=
        -1) {
      int index = nodeList.indexWhere((nodeItem) =>
          nodeItem.id ==
          relatedUsers
              .firstWhere((element) => !visitedNodeIds.contains(element)));
      if (index != -1) {
        // return nodeList.firstWhere((nodeItem) =>
        //     nodeItem.id ==
        //     relatedUsers
        //         .firstWhere((element) => !visitedNodeIds.contains(element)));
        return nodeList[index];
      }
    }
    return null;
  }
}
