import 'package:flutter/material.dart';
import 'package:multi_relation_tree/get_filter.dart';
import 'package:multi_relation_tree/get_possible_relations.dart';
import 'package:multi_relation_tree/node_model.dart';
const nodeWidth = 100.0;
const nodeGapX = 100.0;
const nodeGapY = 100.0;
const nodeHeight = 20.0;
void calculateLayout(List<NodeModel> menuList, double currentVerticalLevel,
    double currentHorizontalLevel) {
  debugPrint(
      "**********************  ${menuList.first.parentId} *********************");

  Map<int, int> tempLayout = {};
  //1. Get unique relation IDs.
  final uniqueRelation = getUniqueRelation(menuList);

  //2. Get filtered data and iterate over relation.
  for (var relation in uniqueRelation) {
    var filteredRelation = filterRelation(relation, menuList);
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
    if (item.key < 0) {
      debugPrint("Level -1");

      List<Offset> parentNodeOffsets = (getPossibleNodePosition(item.value,
          maxSpaceX, nodeWidth, nodeHeight, -1, currentVerticalLevel));
      List<NodeModel> parentNodes = filterRelation(item.key, menuList);
      for (int i = 0; i < parentNodes.length; i++) {
        menuList.where((e) => e == parentNodes[i]).first
          ..dx = parentNodeOffsets[i].dx
          ..dy = parentNodeOffsets[i].dy;
      }
      // handle key 1 also
    } else if (item.key == 0) {
      debugPrint("Level 0 ");
      List<Offset> parentNodeOffsets = (getPossibleNodePosition(item.value,
          maxSpaceX, nodeWidth, nodeHeight, 0, currentVerticalLevel));
      List<NodeModel> parentNodes = filterRelation(item.key, menuList);
      for (int i = 0; i < parentNodes.length; i++) {
        menuList.where((e) => e == parentNodes[i]).first
          ..dx = parentNodeOffsets[i].dx
          ..dy = parentNodeOffsets[i].dy;
      }
    } else {
      debugPrint("Level 1");
      List<Offset> parentNodeOffsets = (getPossibleNodePosition(item.value,
          maxSpaceX, nodeWidth, nodeHeight, 1, currentVerticalLevel));
      List<NodeModel> parentNodes = filterRelation(item.key, menuList);
      for (int i = 0; i < parentNodes.length; i++) {
        menuList.where((e) => e == parentNodes[i]).first
          ..dx = parentNodeOffsets[i].dx
          ..dy = parentNodeOffsets[i].dy;
      }
    }
  }
  debugPrint(
      "**********************  ${menuList.first.parentId} *********************");
}
