import 'package:flutter/material.dart';

List<Offset> getPossibleNodePosition(
    int nodeCount,
    double maxSpace,
    double nodeWidth,
    double nodeHeight,
    int level,
    double currentVerticalLevel) {
  double dy =
      currentVerticalLevel + ((level < 0) ? 50 : (level == 0 ? 150 : 250));

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
