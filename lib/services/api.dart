
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:short_links/models/link.dart';
import 'package:short_links/models/statistics.dart';
import 'package:short_links/models/user.dart';

class Api {

  static const String baseUrl = "https://linkshortener-3ff2c6c98bd6.herokuapp.com/api"; // "http://localhost:3000/api";
  static const String usersApiUrl = "$baseUrl/users";
  static const String linksApiUrl = "$baseUrl/links";
  static const String statisticsApiUrl = "$baseUrl/statistics/";

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


    try{
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
    } on DioException catch(e){
      if(e.type == DioExceptionType.connectionError){
        throw "Please check your connection and try again.";
      }else{
        throw "An error occured. Please try again.";
      }
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

  Future<Map<String, dynamic>> getAllLinks({required String token, int? page = 1}) async {
    debugPrint("getAllLinks");
    List<Link> list = [];

    debugPrint("page : $page");


    final response = await dio.get("$linksApiUrl/getAllLinks", queryParameters: {
      "page" : page
    },options: Options(headers: {"authorization": "Bearer $token"}));


    debugPrint("response: $response");

    if(response.statusCode == 200){
      debugPrint("Data: ${response.data}");


      for(var i = 0; i < response.data["links"].length; i++){
        list.add(Link.fromMap(response.data["links"][i]));
      }

      return {
        "page" : response.data["page"],
        "links" : list
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

  Future<bool> deleteLink({String? token, required String id}) async {
    debugPrint("deleteLink");


    debugPrint("link id $id");
    final response = await dio.delete("$linksApiUrl/delete/$id",
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

  Future<Statistics> getStatistics() async {
    debugPrint("getStatistics");


    final response = await dio.get("$statisticsApiUrl/getAll");
    debugPrint("response: $response");


    if(response.statusCode == 200){
      debugPrint("Data: ${response.data}");

      return Statistics.fromMap(response.data);

    }else{
      debugPrint("Hata: ${response.statusCode} ${response.statusMessage}");
      throw "${response.statusCode}";
    }
  }


}