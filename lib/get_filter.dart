  import 'package:multi_relation_tree/node_model.dart';

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
