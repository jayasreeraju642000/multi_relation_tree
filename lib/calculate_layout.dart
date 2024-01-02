import 'package:flutter/material.dart';
import 'package:multi_relation_tree/get_filter.dart';
import 'package:multi_relation_tree/get_possible_relations.dart';
import 'package:multi_relation_tree/multi_relation_tree.dart';
import 'package:multi_relation_tree/node_model.dart';

void calculateLayout(List<NodeModel> menus, double currentVerticalLevel,
    double currentHorizontalLevel) {
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
  double maxSpaceX = ((sortedLayoutEntries.first.value * nodeWidth) +
          ((sortedLayoutEntries.first.value - 1) * nodeGapX)) +
      currentHorizontalLevel;
  double maxSpaceY = ((sortedLayoutEntries.first.key * nodeHeight) +
      ((sortedLayoutEntries.first.key - 1) * nodeGapY));
  debugPrint("MaxSpace $maxSpaceY $maxSpaceX");
  for (var item in sortedLayoutEntries) {
    debugPrint(item.key.toString());

    if (item.key < 0) {
      debugPrint("Level -1");

      List<Offset> parentNodeOffsets = (getPossibleNodePosition(item.value,
          maxSpaceX, nodeWidth, nodeHeight, -1, currentVerticalLevel));
      List<NodeModel> parentNodes = filterRelation(item.key, menus);
      for (int i = 0; i < parentNodes.length; i++) {
        menus.where((e) => e == parentNodes[i]).first
          ..dx = parentNodeOffsets[i].dx
          ..dy = parentNodeOffsets[i].dy;
      }
      // handle key 1 also
    } else if (item.key == 0) {
      debugPrint("Level 0");
      List<Offset> parentNodeOffsets = (getPossibleNodePosition(item.value,
          maxSpaceX, nodeWidth, nodeHeight, 0, currentVerticalLevel));
      List<NodeModel> parentNodes = filterRelation(item.key, menus);
      for (int i = 0; i < parentNodes.length; i++) {
        menus.where((e) => e == parentNodes[i]).first
          ..dx = parentNodeOffsets[i].dx
          ..dy = parentNodeOffsets[i].dy;
      }
    } else {
      debugPrint("Level 1");
      List<Offset> parentNodeOffsets = (getPossibleNodePosition(item.value,
          maxSpaceX, nodeWidth, nodeHeight, 1, currentVerticalLevel));
      List<NodeModel> parentNodes = filterRelation(item.key, menus);
      for (int i = 0; i < parentNodes.length; i++) {
        menus.where((e) => e == parentNodes[i]).first
          ..dx = parentNodeOffsets[i].dx
          ..dy = parentNodeOffsets[i].dy;
      }
    }
  }
}
