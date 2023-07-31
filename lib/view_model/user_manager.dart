import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:short_links/models/user.dart';
import 'package:short_links/services/api.dart';


enum UserManagerState {idle, busy}

final userManagerProvider = StateNotifierProvider<UserManager, UserManagerState>((ref) {
  return UserManager(UserManagerState.idle);
});

class UserManager extends StateNotifier<UserManagerState>{

  UserManager(UserManagerState state) : super(state){
    getMyDate();
  }

  Api api = Api();

  User? user;

  List<User> userList = [];
  int page = 0;
  bool hasMoreUsers = true;

  Future<void> checkTokenAndSignin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? email = prefs.getString("email");
    String? password = prefs.getString("password");
    String? token = prefs.getString("token");

    if(email != null && password != null && token != null){
      try{
        await signin(email: email, password: password);
      }catch(e){
        debugPrint("Error: $e");
      }
    }else{
      debugPrint("User credentials not found. Login required");
    }


  }

  Future<void> getMyDate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString("token");

    if(token == null){
      return;
    }


    try{
      state = UserManagerState.busy;
      user = await api.getMyData(token: token);
      if(user == null){
        debugPrint("Token is invalid. Login required.");
      }
    }finally{
      state = UserManagerState.idle;
    }

  }

  Future<List<User>> getAllUsers({bool refresh = false}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString("token");

    if(token == null){
      debugPrint("Token is invalid. Login required.");
      return [];
    }


    try{
      state = UserManagerState.busy;
      if(refresh){
        page = 0;
        hasMoreUsers = true;
      }

      if(hasMoreUsers == false){
        return userList;
      }

      Map result = await api.getAllUsers(token: token, page: page);
      page++;
      userList.addAll(result["users"]);

      if(result["users"].length < 20){
        hasMoreUsers = false;
      }

      return userList;

    }finally{
      state = UserManagerState.idle;
    }

  }


  Future<void> signin({required String email, required String password}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try{
      state = UserManagerState.busy;
      user = await api.signin(email: email, password: password);
      if(user != null){
       await prefs.setString("token", user!.token!);
      }
    }finally{
      state = UserManagerState.idle;
    }

  }

  Future<bool> register({required String email, required String username, required String password}) async {
   try{
     state = UserManagerState.busy;
     return await api.register(email: email, username: username, password: password);
   }finally{
     state = UserManagerState.idle;
   }
  }

  Future<void> signOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    state = UserManagerState.busy;
    await prefs.remove("token");
    user = null;
    state = UserManagerState.idle;

    debugPrint("User credentials removed");
  }


  Future<bool> updateUser({required String username, required String userID}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString("token");

    if(token == null){
      return false;
    }

    try{
      state = UserManagerState.busy;
      bool result = await api.updateUser(username: username, userID: userID, token: token);
      if(result){
        userList.where((element) => element.id == userID).first.username = username;
      }
      return result;
    }finally{
      state = UserManagerState.idle;
    }
  }


  Future<bool> deleteUser({required String userID}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString("token");

    if(token == null){
      return false;
    }

    try{
      state = UserManagerState.busy;
      bool result = await api.deleteUser(token: token, userID: userID);
      if(result){
        userList.removeWhere((element) => element.id == userID);
      }
      return result;
    }finally{
      state = UserManagerState.idle;
    }
  }


}