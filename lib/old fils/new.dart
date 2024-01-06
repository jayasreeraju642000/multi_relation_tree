// library multi_relation_tree;

// import 'dart:core';

// import 'package:flutter/material.dart';
// import 'package:multi_relation_tree/data.dart';
// import 'package:multi_relation_tree/multi_relation_tree.dart';


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

// class MyPainter extends CustomPainter {
//   List<NodeData> nodeList = sample.map((e) => NodeData.fromJson(e)).toList();
//   List<int> visitedNode = [];
//   List<NodeData> duplicateNodeList = [];
//   @override
//   void paint(Canvas canvas, Size size) {
//     for (var node in nodeList) {
//       traverseNode(node);
//     }
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }

//   void traverseNode(NodeData node) {
//     if (!duplicateNodeList.contains(node)) {
//       duplicateNodeList.add(node);
//     }
//     if(isParentVisited(nodeList,node).isNotEmpty){
      
//     }
//   }


//   List<int> isParentVisited(List<NodeData> nodes,NodeData currentNode) {
//     List<int> notVisitedNodes = [];
//     for (int parent in currentNode.parentId) {
//       int index = nodes
//           .indexWhere((element) =>( element.id == parent) && !element.visited);
//       if (index != -1) {
//         notVisitedNodes.add(parent);
//       }
//     }
//     return notVisitedNodes;
//   }

//   List<int> isPartnersVisited(List<NodeData> nodes,NodeData currentNode) {
//     List<int> notVisitedNodes = [];
//     for (int partner in currentNode.partnersId) {
//       int index = nodes
//           .indexWhere((element) =>( element.id == partner) && !element.visited);
//       if (index != -1) {
//         notVisitedNodes.add(partner);
//       }
//     }
//     return notVisitedNodes;
//   }
// }
