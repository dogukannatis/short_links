
class Statistics {
  int? totalUsers;
  int? totalLinks;

  Statistics({
    this.totalUsers,
    this.totalLinks,
  });

  Map<String, dynamic> toMap() {
    return {
      "totalUsers"     : totalUsers,
      "totalLinks"  : totalLinks,
    };
  }

  Statistics.fromMap(Map<String, dynamic> map):
        totalUsers = map["users"],
        totalLinks = map["links"];

  @override
  String toString() {
    return 'Statistics{totalUsers: $totalUsers, totalLinks: $totalLinks}';
  }
}