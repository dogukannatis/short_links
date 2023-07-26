
class User {

  final String id;
  String? email;
  String? username;
  String? token;
  bool? isAdmin;
  bool? isEmailVerified;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    required this.id,
    this.email,
    this.username,
    this.token,
    this.isAdmin,
    this.isEmailVerified,
    this.createdAt,
    this.updatedAt
  });

  Map<String, dynamic> toMap() {
    return {
      "_id"        : id,
      "email"     : email,
      "username"  : username,
      "isAdmin"  : isAdmin,
      "isEmailVerified": isEmailVerified,
    };
  }

  User.fromMap(Map<String, dynamic> map):
        id = map["_id"],
        email = map["email"],
        username = map["username"],
        isAdmin = map["isAdmin"],
        isEmailVerified = map["isEmailVerified"],
        createdAt = map["createdAt"],
        updatedAt = map["updatedAt"];

  @override
  String toString() {
    return 'User{id: $id, email: $email, username: $username, token: $token, isAdmin: $isAdmin, isEmailVerified: $isEmailVerified, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}