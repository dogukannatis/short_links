
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:short_links/models/link.dart';
import 'package:short_links/models/user.dart';

class Api {

  static const String baseUrl = "http://localhost:3000/api";
  static const String usersApiUrl = "$baseUrl/users";
  static const String linksApiUrl = "$baseUrl/links";

  final dio = Dio();


  Future<User> getMyData({required String token}) async {
    debugPrint("GetMyData");

    final response = await dio.get("$usersApiUrl/me", options: Options(headers: {"authorization": "Bearer $token"}));
    debugPrint("response: $response");


    if(response.statusCode == 200){
      debugPrint("Data: ${response.data}");

      User user = User.fromMap(response.data);
      user.token = token;

      debugPrint(user.toString());
      return user;

    }else{
      debugPrint("Hata: ${response.statusCode} ${response.statusMessage}");
      throw "response code: ${response.statusCode}";
    }

  }


  Future<User> signin({required String email, required String password}) async {
    debugPrint("signin");

    final response = await dio.post("$usersApiUrl/signin", data: {
      "email" : email,
      "password" : password
    });
    debugPrint("response: $response");


    if(response.statusCode == 200){
      debugPrint("Data: ${response.data}");



      User user = User.fromMap(response.data["user"]);
      user.token = response.data["token"];

      debugPrint(user.toString());
      return user;

    }else{
      debugPrint("Hata: ${response.statusCode} ${response.statusMessage}");
      throw "response code: ${response.statusCode}";
    }

  }

  Future<bool> register({required String email, required String username, required String password}) async {
    debugPrint("register");


    final response = await dio.post("$usersApiUrl/saveUser", data: {
      "email" : email,
      "username" : username,
      "password" : password
    });
    debugPrint("response: $response");


    if(response.statusCode == 200){
      debugPrint("Data: ${response.data}");

      return true;

    }else{
      debugPrint("Hata: ${response.statusCode} ${response.statusMessage}");
      throw "${response.statusCode}";
    }

  }

  Future<List<Link>> getMyLinks({required String token}) async {
    debugPrint("GetMyLinks");
    List<Link> list = [];


    final response = await dio.get("$linksApiUrl/getMyLinks", data: {
      "token" : token
    },options: Options(headers: {"authorization": "Bearer $token"}));


    debugPrint("response: $response");

    if(response.statusCode == 200){
      debugPrint("Data: ${response.data}");


      for(var i = 0; i < response.data.length; i++){
        list.add(Link.fromMap(response.data[i]));
      }

      return list;

    }else{
      debugPrint("Hata: ${response.statusCode} ${response.statusMessage}");
      throw "${response.statusCode}";
    }

  }

  Future<Map<String, dynamic>> getAllUsers({required String token, int? page = 1}) async {
    debugPrint("getAllUsers");
    List<User> list = [];

    debugPrint("page : $page");


    final response = await dio.get("$usersApiUrl/getAllUsers", queryParameters: {
      "page" : page
    },options: Options(headers: {"authorization": "Bearer $token"}));


    debugPrint("response: $response");

    if(response.statusCode == 200){
      debugPrint("Data: ${response.data}");


      for(var i = 0; i < response.data["users"].length; i++){
        list.add(User.fromMap(response.data["users"][i]));
      }

      return {
        "page" : response.data["page"],
        "users" : list
      };

    }else{
      debugPrint("Hata: ${response.statusCode} ${response.statusMessage}");
      throw "${response.statusCode}";
    }

  }

  Future<Link> convertLink({required String originalLink, required String token}) async {
    debugPrint("convertLink");


    final response = await dio.post("$linksApiUrl/add", data: {
      "original_link" : originalLink
    },options: Options(headers: {"authorization": "Bearer $token"}));


    debugPrint("response: $response");

    if(response.statusCode == 200){
      debugPrint("Data: ${response.data}");

      return Link.fromMap(response.data);

    }else{
      debugPrint("Hata: ${response.statusCode} ${response.statusMessage}");
      throw "${response.statusCode}";
    }

  }

  Future<bool> deleteMyLink({required String id, required String token}) async {
    debugPrint("deleteMyLink");


    final response = await dio.delete("$linksApiUrl/deleteMyLink/$id",
        options: Options(headers: {"authorization": "Bearer $token"}));


    debugPrint("response: $response");

    if(response.statusCode == 200){
      debugPrint("Data: ${response.data}");

      return true;

    }else{
      debugPrint("Hata: ${response.statusCode} ${response.statusMessage}");
      throw "${response.statusCode}";
    }

  }

  Future<bool> updateUser({required String token, required String username, required String userID}) async {
    debugPrint("updateUser");


    final response = await dio.patch("$usersApiUrl/updateUser/$userID", data: {
      "username" : username,
    },options: Options(headers: {"authorization": "Bearer $token"}));
    debugPrint("response: $response");


    if(response.statusCode == 200){
      debugPrint("Data: ${response.data}");

      return true;

    }else{
      debugPrint("Hata: ${response.statusCode} ${response.statusMessage}");
      throw "${response.statusCode}";
    }

  }

  Future<bool> deleteUser({String? token, required String userID}) async {
    debugPrint("deleteUser");


    debugPrint("user id $userID");
    final response = await dio.delete("$usersApiUrl/id/$userID",
        options: Options(headers: {"authorization": "Bearer $token"}));
    debugPrint("response: $response");


    if(response.statusCode == 200){
      debugPrint("Data: ${response.data}");

      return true;

    }else{
      debugPrint("Hata: ${response.statusCode} ${response.statusMessage}");
      throw "${response.statusCode}";
    }
  }


}