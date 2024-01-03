// library multi_relation_tree;



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

List<Map<String, dynamic>> menus = [
      {
      "id": 1,
      "parentId": 1,
      'level': 0,
      "name": "Jayasree",
      'relationID': 0,
      'visited' : false,
    },
    {
      "id": 2,
      "parentId": 1,
      "name": "Ranjith",
      'level': 0,
      'relationID': 1,
      'visited' : false,
    },
    {
      "id": 3,
      "parentId": 1,
      "name": "child1",
      'level': 1,
      'relationID': 2,
      'visited' : false,
    },
    {
      "id": 4,
      "parentId": 1,
      "name": "chil2",
      'level': 1,
      'relationID': 2,
      'visited' : false,
    },
    {
      "id": 5,
      "parentId": 1,
      'level': -1,
      "name": "Raju K B",
      'relationID': 3,
      'visited' : false,
    },
    {
      "id": 6,
      "parentId": 1,
      'level': -1,
      "name": "Bindu Raju",
      'relationID': 3,
      'visited' : false,
    },
    {
      "id": 7,
      "parentId": 2,
      "name": "Mayadevi",
      'level': -1,
      'relationID': 3,
      'visited' : false,
    },
    {
      "id": 8,
      "parentId": 2,
      "name": "Sasidharan",
      'level': -1,
      'relationID': 3,
      'visited' : false,
    },
    {
      "id": 9,
      "parentId": 5,
      "name": "Balakrishnan",
      'level': -1,
      'relationID': 3,
      'visited' : false,
    },
    {
      "id": 10,
      "parentId": 5,
      "name": "Mallika",
      'level': -1,
      'relationID': 3,
      'visited' : false,
    },
    ];   

List<int> nodeOrderMap = [];

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    //print("Traverse menu started");
    traverseNode(menus[0]['id']);
    // print("Ordered node map ${nodeOrderMap}");
    calculatePositionLevels();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

}

List<Map<String, dynamic>> getConnectedNodeList(int id)
{
  var nodeList = menus.where((element) => element['parentId'] == id  && element['visited'] == false).toList();
  if(nodeList.isNotEmpty)
  {
    nodeList.removeWhere((element) => element['id'] == id);
    nodeList.sort((a, b) => a['level'].compareTo(b['level']));
  }

  return nodeList;
}

List<int> nodeMap = [];


void markNodeVisited(int id)
{
  int index = menus.indexWhere((element) => element['id'] == id);

  if(index != -1)
  {
    menus[index]['visited'] = true;
  }
}

int getNextNode()
{ nodeMap.removeLast();
  if(nodeMap.isEmpty)
  {
    return -1;
  }
  return nodeMap.last;
}

void traverseNode(int id)
{
  //print("Inside traverse node for ${id}");
  //1. Push current node
  if(!nodeMap.contains(id))
  {
    nodeMap.add(id);
  }
  //print("Element in node $nodeMap");
  //2. Get list of node connected to current node.
  final itemList = getConnectedNodeList(id);
  if(itemList.isEmpty)
  {
    markNodeVisited(id);
    //print("Node visited $id");
    nodeOrderMap.add(id);
    int nodeID = getNextNode();
    //print("Next node $nodeID");
    if(nodeID == -1)
    {
      //print("Returning");
      return;
    }
    traverseNode(nodeID);
  }
  else
  {
    traverseNode(itemList[0]['id']);
  }
 
}

List<Map<int, dynamic>> drawMap = [];
Set<int> visited = {};

int x = 0;

Map<int, List<int>> levels1={};
Map <int, int> xCoordinates = {};

int allocateXCoordinates(int nodeID, int startX)
{
  if(visited.contains(nodeID))
  {
    print("Node ID $nodeID already visited");
    return startX;
  }

  x = startX;
  xCoordinates[nodeID] = startX;
  visited.add(nodeID);

  int index = menus.indexWhere((element) => element['id'] == nodeID);
  if(index != -1)
  {
    int childNodeID = menus[index]['parentId'];
    startX = allocateXCoordinates(childNodeID, startX + 1);
  }

  return startX;
}

int makeLevelCorrect(int nodeID, int level)
{
  int index = menus.indexWhere((element) => element['id'] == nodeID);
  if( menus[index]['relationID'] == 3)
  {
    return -level;
  }

  return level;
}

int getLevelFromRoot(int nodeID)
{
  int index = menus.indexWhere((element) => element['id'] == nodeID && element['relationID'] != 1);
  int parentID = -1;
  if(index == -1)
  {
    visited.clear();
    return 0;
  }

  parentID = menus[index]['parentId'];

  if((visited.contains(nodeID)) || (nodeID == parentID) )
  {
    visited.clear();
    return 0;
  }
  else
  {
    visited.add(nodeID);
    return 1 + getLevelFromRoot(parentID);
  }
}

void calculatePositionLevels()
{
  // for(var nodeID in nodeOrderMap)
  // {
  //   int level = GetLevelFromRoot(nodeID);
  //   level = MakeLevelCorrect(nodeID, level);
  //   print("Node ID $nodeID Level $level");
  // }

int startX = 0; 
for(var node in nodeOrderMap)
{
  startX = allocateXCoordinates(node, startX + 1);
}

  print(xCoordinates);
}