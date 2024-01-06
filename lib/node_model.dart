// import 'dart:convert';

// class NodeModel {
//   int? id;
//   int? parentId;
//   String? name;
//   int? level;
//   int? relationID;
//   double dx;
//   double dy;
//   NodeModel({
//     this.id,
//     this.parentId,
//     this.name,
//     this.level,
//     this.relationID,
//     this.dx = 0.0,
//     this.dy = 0.0,
//   });

//   NodeModel copyWith({
//     int? id,
//     int? parentId,
//     String? name,
//     int? level,
//     int? relationID,
//     double? dx,
//     double? dy,
//   }) {
//     return NodeModel(
//       id: id ?? this.id,
//       parentId: parentId ?? this.parentId,
//       name: name ?? this.name,
//       level: level ?? this.level,
//       relationID: relationID ?? this.relationID,
//       dx: dx ?? this.dx,
//       dy: dy ?? this.dy,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'parentId': parentId,
//       'name': name,
//       'level': level,
//       'relationID': relationID,
//       'dx': dx,
//       'dy': dy,
//     };
//   }

//   factory NodeModel.fromMap(Map<String, dynamic> map) {
//     return NodeModel(
//       id: map['id'] != null ? map['id'] as int : null,
//       parentId: map['parentId'] != null ? map['parentId'] as int : null,
//       name: map['name'] != null ? map['name'] as String : null,
//       level: map['level'] != null ? map['level'] as int : null,
//       relationID: map['relationID'] != null ? map['relationID'] as int : null,
//       dx: map['dx'] ?? 0.0,
//       dy: map['dy'] ?? 0.0,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory NodeModel.fromJson(String source) =>
//       NodeModel.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() {
//     return 'NodeModel(id: $id, parentId: $parentId, name: $name, level: $level, relationID: $relationID, dx: $dx, dy: $dy)';
//   }

//   @override
//   bool operator ==(covariant NodeModel other) {
//     if (identical(this, other)) return true;

//     return other.id == id &&
//         other.parentId == parentId &&
//         other.name == name &&
//         other.level == level &&
//         other.relationID == relationID &&
//         other.dx == dx &&
//         other.dy == dy;
//   }

//   @override
//   int get hashCode {
//     return id.hashCode ^
//         parentId.hashCode ^
//         name.hashCode ^
//         level.hashCode ^
//         relationID.hashCode ^
//         dx.hashCode ^
//         dy.hashCode;
//   }
// }
// part of multi_relation_tree;
// class NodeData {
//   int? id;
//   List<int> parentId = [];
//   List<int> partnersId = [];
//   int? level;
//   String? name;
//   int? relationId;
//   bool visited = false;

//   NodeData(
//       {this.id,
//       this.parentId = const <int>[],
//       this.partnersId = const <int>[],
//       this.level,
//       this.name,
//       this.relationId,
//       this.visited = false});

//   NodeData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     parentId = json['parentId'] ?? <int>[];
//     partnersId = json['partnersId'] ?? <int>[];
//     level = json['level'];
//     name = json['name'];
//     relationId = json['relationId'];
//     visited = json['visited'] ?? false;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['parentId'] = parentId;
//     data['partnersId'] = partnersId;
//     data['level'] = level;
//     data['name'] = name;
//     data['relationId'] = relationId;
//     data['visited'] = visited;
//     return data;
//   }

  

// }
