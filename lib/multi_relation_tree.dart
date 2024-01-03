library multi_relation_tree;

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


List<Map<String, dynamic>> menus = [
  {
    "id": 1,
    "parentId": 1,
    'level': 0,
    "name": "Jayasree",
    'relationID': 0,
    'fam': false,
  },
  {
    "id": 2,
    "parentId": 1,
    "name": "Ranjith",
    'level': 0,
    'relationID': 1,
    'fam': false,
  },
  {
    "id": 3,
    "parentId": 1,
    "name": "Sreejith",
    'level': 1,
    'relationID': 2,
    'fam': false,
  },
  {
    "id": 4,
    "parentId": 1,
    "name": "Sreeraj",
    'level': 1,
    'relationID': 2,
    'fam': false,
  },
  {
    "id": 5,
    "parentId": 1,
    'level': -1,
    "name": "Raju K B",
    'relationID': 3,
    'fam': false,
  },
  {
    "id": 6,
    "parentId": 1,
    'level': -1,
    "name": "Bindu Raju",
    'relationID': 3,
    'fam': false,
  },
  {
    "id": 7,
    "parentId": 2,
    "name": "Mayadevi",
    'level': -1,
    'relationID': 3,
    'fam': false,
  },
  {
    "id": 8,
    "parentId": 2,
    "name": "Sasidharan",
    'level': -1,
    'relationID': 3,
    'fam': false,
  },
  {
    "id": 9,
    "parentId": 5,
    "name": "Balakrishnan",
    'level': -2,
    'relationID': 3,
    'fam': false,
  },
  {
    "id": 10,
    "parentId": 5,
    "name": "Mallika",
    'level': -2,
    'relationID': 3,
    'fam': false,
  },
  {
    "id": 11,
    "parentId": 9,
    "name": "Valsala",
    'level': -1,
    'relationID': 2,
    'fam': false,
  },
  {
    "id": 12,
    "parentId": 9,
    "name": "Girija",
    'level': -1,
    'relationID': 2,
    'fam': false,
  },
  {
    "id": 13,
    "parentId": 9,
    "name": "Sudha",
    'level': -1,
    'relationID': 2,
    'fam': false,
  },
  {
    "id": 14,
    "parentId": 9,
    "name": "Sobha",
    'level': -1,
    'relationID': 2,
    'fam': false,
  },
  {
    "id": 15,
    "parentId": 9,
    "name": "Gopi",
    'level': -1,
    'relationID': 2,
    'fam': false,
  },
];

List<int> nodeOrderMap = [];

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    ////debugPrint("Traverse menu started");
    traverseNode(menus[0]['id']);
    // //debugPrint("Ordered node map ${nodeOrderMap}");
    calculatePositionLevels();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

List<Map<String, dynamic>> getConnectedNodeList(int id) {
  var nodeList = menus
      .where((element) => element['parentId'] == id && element['fam'] == false)
      .toList();
  if (nodeList.isNotEmpty) {
    nodeList.removeWhere((element) => element['id'] == id);
    nodeList.sort((a, b) => a['level'].compareTo(b['level']));
  }

  return nodeList;
}

List<int> nodeMap = [];

void markNodeVisited(int id) {
  int index = menus.indexWhere((element) => element['id'] == id);

  if (index != -1) {
    menus[index]['fam'] = true;
  }
}

int getNextNode() {
  nodeMap.removeLast();
  if (nodeMap.isEmpty) {
    return -1;
  }
  return nodeMap.last;
}

void traverseNode(int id) {
  debugPrint("Inside traverse node for ${id}");
  //1. Push current node
  if (!nodeMap.contains(id)) {
    nodeMap.add(id);
  }
  debugPrint("Element in node $nodeMap");
  //2. Get list of node connected to current node.
  final itemList = getConnectedNodeList(id);
  debugPrint( itemList.toString());
  if (itemList.isEmpty) {
    markNodeVisited(id);
    debugPrint("Node fam $id");
    nodeOrderMap.add(id);
    int nodeID = getNextNode();
    debugPrint("Next node $nodeID");
    if (nodeID == -1) {
      debugPrint("Returning");
      return;
    }
    traverseNode(nodeID);
  } else {
    traverseNode(itemList[0]['id']);
  }
}

List<Map<int, dynamic>> drawMap = [];
List<dynamic> fam = [];
List<dynamic> childNodes = [];

int x = 0;

Map<int, List<int>> levels1 = {};
Map<int, int> xCoordinates = {};

List<dynamic> getFamily(int nodeID) {
  int index = menus.indexWhere((element) => element['id'] == nodeID);
  if (index != -1) {
    int parentID = menus[index]['parentId'];
    int relationID = menus[index]['relationID'];
    if (relationID == 3) {
      return menus
          .where((element) =>
              element['parentId'] == parentID &&
              element['relationID'] == relationID)
          .map((e) => e['id'])
          .toList();
    } else if (relationID == 2) {
      return [];
    } else {
      return menus
          .where((element) =>
              (element['parentId'] == parentID) &&
                  (element['relationID'] == 0) ||
              (element['relationID'] == 1))
          .map((e) => e['id'])
          .toList();
    }
  }
  return [];
}

List<int> getChild(int nodeID1, int nodeID2) {
  // //debugPrint("Nodes $nodeID1 $nodeID2");
  //1. Get relationID and if it is 3 then find the common parent id of both
  int indexID1 = menus.indexWhere((element) => element['id'] == nodeID1);
  int indexID2 = menus.indexWhere((element) => element['id'] == nodeID2);

  int relationID1 = menus[indexID1]['relationID'];
  int relationID2 = menus[indexID2]['relationID'];

  // //debugPrint("Relation $relationID2 $relationID1");

  if ((relationID1 == 3) && (relationID2 == 3)) {
    // //debugPrint("Relation id same");
    int parentID1 = menus[indexID1]['parentId'];
    int parentID2 = menus[indexID2]['parentId'];

    if (parentID1 == parentID2) {
      // //debugPrint("Parent same ");
      final item = menus
          .where((element) => element['id'] == parentID1)
          .map((e) => e['id'] as int)
          .toList();
      // //debugPrint("Child $item");
      return item;
    } else {
      return [];
    }
  } else if (((relationID1 == 1) || (relationID1 == 0)) &&
      ((relationID2 == 1) || (relationID2 == 0))) {
    final item = menus
        .where((element) => (((element['parentId'] == nodeID1) ||
                (element['parentId'] == nodeID2)) &&
            (element['relationID'] == 2)))
        .map((e) => e['id'] as int)
        .toList();

    // //debugPrint("Child $item");
    return item;
  }
  return [];
}

int allocateXCoordinates(int nodeID, int startX) {
  var family = getFamily(nodeID);

  if (family.isEmpty) {
    //debugPrint("No family for $nodeID");
  } else {
    if (fam.contains(family)) {
      //debugPrint("Family already exists $family");
    } else {
      //debugPrint("Family not exists $family");
      fam.addAll(family);
    }
  }
  // if(fam.contains(nodeID))
  // {
  //   //debugPrint("Node ID $nodeID already fam");
  //   return startX;
  // }

  // x = startX;
  // xCoordinates[nodeID] = startX;
  // fam.add(nodeID);

  // int index = menus.indexWhere((element) => element['id'] == nodeID);
  // if(index != -1)
  // {
  //   int childNodeID = menus[index]['parentId'];
  //   startX = allocateXCoordinates(childNodeID, startX + 1);
  // }

  return startX;
}

int MakeLevelCorrect(int nodeID, int level) {
  int index = menus.indexWhere((element) => element['id'] == nodeID);
  if (menus[index]['relationID'] == 3) {
    return -level;
  }

  return level;
}

int GetLevelFromRoot(int nodeID) {
  int index = menus.indexWhere(
      (element) => element['id'] == nodeID && element['relationID'] != 1);
  int parentID = -1;
  if (index == -1) {
    fam.clear();
    return 0;
  }

  parentID = menus[index]['parentId'];

  if ((fam.contains(nodeID)) || (nodeID == parentID)) {
    fam.clear();
    return 0;
  } else {
    // fam.add(nodeID);
    return 1 + GetLevelFromRoot(parentID);
  }
}

void UpdateCoordinate() {}

Map<List<int>, List<int>> familyMap = {};

void calculatePositionLevels() {
  for (var nodeID in nodeOrderMap) {
    int level = GetLevelFromRoot(nodeID);
    level = MakeLevelCorrect(nodeID, level);
    //debugPrint("Node ID $nodeID Level $level");
  }

  int startX = 0;
  for (var node in nodeOrderMap) {
    startX = allocateXCoordinates(node, startX + 1);
  }
  fam = fam.toSet().toList();
  //debugPrint(fam);

  int parentLength = fam.length;
  for (int listIndex = 0; listIndex < parentLength; listIndex += 2) {
    //debugPrint("ListIndex ${fam[listIndex]}, ${fam[listIndex+1]}");
    var childList = getChild(fam[listIndex], fam[listIndex + 1]);
    //debugPrint("ChildList $childList");
    if (!childList.isEmpty) {
      List<int> temp = [fam[listIndex], fam[listIndex + 1]];
      familyMap[temp] = childList;
    }
  }

  debugPrint(familyMap.toString());
}
