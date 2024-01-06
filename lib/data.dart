// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

var sample = [
  {
    "id": 1,
    "level": 0,
    "name": "Jayasree",
    "relatedData": [
      {"relatedUserId": 5, "relationId": 1},
      {"relatedUserId": 6, "relationId": 1},
      {"relatedUserId": 2, "relationId": 2},
    ],
    "visited": false,
  },
  {
    "id": 2,
    "name": "Ranjith",
    "relatedData": [
      {"relatedUserId": 7, "relationId": 1},
      {"relatedUserId": 8, "relationId": 1},
      {"relatedUserId": 1, "relationId": 2},
    ],
    "level": 0,
    "visited": false,
  },
  {
    "id": 3,
    "name": "Sreejith",
    "relatedData": [
      {"relatedUserId": 1, "relationId": 1},
      {"relatedUserId": 2, "relationId": 1},
    ],
    "level": 1,
    "visited": false,
  },
  {
    "id": 4,
    "name": "Sreeraj",
    "relatedData": [
      {"relatedUserId": 1, "relationId": 1},
      {"relatedUserId": 2, "relationId": 1},
    ],
    "level": 1,
    "visited": false,
  },
  {
    "id": 5,
    "level": -1,
    "relatedData": [
      {"relatedUserId": 1, "relationId": 3},
      {"relatedUserId": 6, "relationId": 2},
      {"relatedUserId": 9, "relationId": 1},
      {"relatedUserId": 10, "relationId": 1},
    ],
    "name": "Raju K B",
    "visited": false,
  },
  {
    "id": 6,
    "level": -1,
    "relatedData": [
      {"relatedUserId": 5, "relationId": 2},
      {"relatedUserId": 1, "relationId": 3},
    ],
    "name": "Bindu Raju",
    "visited": false,
  },
  {
    "id": 7,
    "name": "Mayadevi",
    "relatedData": [
      {"relatedUserId": 2, "relationId": 3},
      {"relatedUserId": 8, "relationId": 2},
    ],
    "level": -1,
    "visited": false,
  },
  {
    "id": 8,
    "name": "Sasidharan",
    "relatedData": [
      {"relatedUserId": 2, "relationId": 3},
      {"relatedUserId": 7, "relationId": 2},
    ],
    "level": -1,
    "visited": false,
  },
  {
    "id": 9,
    "name": "Balakrishnan",
    "relatedData": [
      {"relatedUserId": 10, "relationId": 2},
      {"relatedUserId": 5, "relationId": 3},
      {"relatedUserId": 11, "relationId": 3},
      {"relatedUserId": 12, "relationId": 3},
      {"relatedUserId": 13, "relationId": 3},
      {"relatedUserId": 14, "relationId": 3},
      {"relatedUserId": 15, "relationId": 3},
    ],
    "level": -2,
    "visited": false,
  },
  {
    "id": 10,
    "name": "Mallika",
    "relatedData": [
      {"relatedUserId": 5, "relationId": 3},
      {"relatedUserId": 9, "relationId": 2},
      {"relatedUserId": 11, "relationId": 3},
      {"relatedUserId": 12, "relationId": 3},
      {"relatedUserId": 13, "relationId": 3},
      {"relatedUserId": 14, "relationId": 3},
      {"relatedUserId": 15, "relationId": 3},
    ],
    "level": -2,
    "visited": false,
  },
  {
    "id": 11,
    "name": "Valsala",
    "level": -1,
    "relatedData": [
      {"relatedUserId": 9, "relationId": 1},
      {"relatedUserId": 10, "relationId": 1},
    ],
    "visited": false,
  },
  {
    "id": 12,
    "name": "Girija",
    "level": -1,
    "relatedData": [
      {"relatedUserId": 9, "relationId": 1},
      {"relatedUserId": 10, "relationId": 1},
    ],
    "visited": false,
  },
  {
    "id": 13,
    "name": "Sudha",
    "level": -1,
    "relatedData": [
      {"relatedUserId": 9, "relationId": 1},
      {"relatedUserId": 10, "relationId": 1},
    ],
    "visited": false,
  },
  {
    "id": 14,
    "name": "Sobha",
    "level": -1,
    "relatedData": [
      {"relatedUserId": 9, "relationId": 1},
      {"relatedUserId": 10, "relationId": 1},
    ],
    "visited": false,
  },
  {
    "id": 15,
    "name": "Gopi",
    "level": -1,
    "relatedData": [
      {"relatedUserId": 9, "relationId": 1},
      {"relatedUserId": 10, "relationId": 1},
    ],
    "visited": false,
  },
];

class NodeData {
  int? id;
  int? level;
  String? name;
  List<RelatedData>? relatedData;
  bool? visited;
  NodeData({
    this.id,
    this.level,
    this.name,
    this.relatedData,
    this.visited,
  });

  NodeData copyWith({
    int? id,
    int? level,
    String? name,
    List<RelatedData>? relatedData,
    bool? visited,
  }) {
    return NodeData(
      id: id ?? this.id,
      level: level ?? this.level,
      name: name ?? this.name,
      relatedData: relatedData ?? this.relatedData,
      visited: visited ?? this.visited,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'level': level,
      'name': name,
      'relatedData': relatedData?.map((x) => x.toMap()).toList(),
      'visited': visited,
    };
  }

  factory NodeData.fromMap(Map<String, dynamic> map) {
    return NodeData(
      id: map['id'] != null ? map['id'] as int : null,
      level: map['level'] != null ? map['level'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      relatedData: map['relatedData'] != null
          ? List<RelatedData>.from(
              (map['relatedData']).map<RelatedData?>(
                (x) => RelatedData.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      visited: map['visited'] != null ? map['visited'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NodeData.fromJson(String source) =>
      NodeData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NodeData(id: $id, level: $level, name: $name, relatedData: $relatedData, visited: $visited)';
  }

  @override
  bool operator ==(covariant NodeData other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.level == level &&
        other.name == name &&
        listEquals(other.relatedData, relatedData) &&
        other.visited == visited;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        level.hashCode ^
        name.hashCode ^
        relatedData.hashCode ^
        visited.hashCode;
  }
}

class RelatedData {
  int? relatedUserId;
  int? relationId;
  RelatedData({
    this.relatedUserId,
    this.relationId,
  });

  RelatedData copyWith({
    int? relatedUserId,
    int? relationId,
  }) {
    return RelatedData(
      relatedUserId: relatedUserId ?? this.relatedUserId,
      relationId: relationId ?? this.relationId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'relatedUserId': relatedUserId,
      'relationId': relationId,
    };
  }

  factory RelatedData.fromMap(Map<String, dynamic> map) {
    return RelatedData(
      relatedUserId:
          map['relatedUserId'] != null ? map['relatedUserId'] as int : null,
      relationId: map['relationId'] != null ? map['relationId'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RelatedData.fromJson(String source) =>
      RelatedData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'RelatedData(relatedUserId: $relatedUserId, relationId: $relationId)';

  @override
  bool operator ==(covariant RelatedData other) {
    if (identical(this, other)) return true;

    return other.relatedUserId == relatedUserId &&
        other.relationId == relationId;
  }

  @override
  int get hashCode => relatedUserId.hashCode ^ relationId.hashCode;
}
