
class Link {
  final String id;
  String? originalLink;
  String? refLink;
  String? belongsTo;
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
      "originalLink"     : originalLink,
      "refLink"  : refLink,
      "belongsTo"  : belongsTo,
    };
  }

  Link.fromMap(Map<String, dynamic> map):
        id = map["_id"],
        originalLink = map["original_link"],
        refLink = map["link_ref"],
        belongsTo = map["belongs_to"],
        click = map["click"];


  @override
  String toString() {
    return 'Link{id: $id, originalLink: $originalLink, refLink: $refLink, belongsTo: $belongsTo, click: $click, createdAt: $createdAt, updatedAt: $updatedAt}';
  }

}