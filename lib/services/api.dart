
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:short_links/models/link.dart';
import 'package:short_links/models/user.dart';

class Api {

  static const String baseUrl = "http://localhost:3000/api";
  static const String usersApiUrl = "$baseUrl/users";
  static const String linksApiUrl = "$baseUrl/links";

  final dio = Dio();


  Future<User> signin({required String email, required String password}) async {

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
    dio.options.headers["wwwAuthenticateHeader"] = token;

    final response = await dio.post("$linksApiUrl/getMyLinks", data: {
      "token" : token
    });


    debugPrint("response: $response");

    if(response.statusCode == 200){
      debugPrint("Data: ${response.data}");

      return response.data;

    }else{
      debugPrint("Hata: ${response.statusCode} ${response.statusMessage}");
      throw "${response.statusCode}";
    }

  }



}