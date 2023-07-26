
class Link {

  final String id;
  String? originalLink;
  String? refLink;
  bool? belongsTo;
  int? click;
  DateTime? createdAt;
  DateTime? updatedAt;

  Link({
    required this.id,
    this.originalLink,
    this.refLink,
    this.belongsTo,
    this.createdAt,
    this.updatedAt
  });

  Map<String, dynamic> toMap() {
    return {
      "id"        : id,
      "originalLink"     : originalLink,
      "refLink"  : refLink,
      "belongsTo"  : belongsTo,
    };
  }

  Link.fromMap(Map<String, dynamic> map):
        id = map["id"],
        originalLink = map["originalLink"],
        refLink = map["refLink"],
        belongsTo = map["belongsTo"],
        createdAt = map["createdAt"],
        updatedAt = map["updatedAt"];

  @override
  String toString() {
    return 'Link{id: $id, originalLink: $originalLink, refLink: $refLink, belongsTo: $belongsTo, click: $click, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}