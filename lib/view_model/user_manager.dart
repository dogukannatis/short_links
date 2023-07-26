import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:short_links/models/user.dart';
import 'package:short_links/services/api.dart';

import '../locator.dart';


enum UserManagerState {idle, busy}

final userManagerProvider = StateNotifierProvider<UserManager, UserManagerState>((ref) {
  return UserManager(UserManagerState.idle);
});

class UserManager extends StateNotifier<UserManagerState>{

  UserManager(UserManagerState state) : super(state);

  Api api = Api();

  User? user;

  Future<void> signin({required String email, required String password}) async {

    try{
      state = UserManagerState.busy;
      user = await api.signin(email: email, password: password);
    }finally{
      state = UserManagerState.idle;
    }

  }

  Future<bool> register({required String email, required String username, required String password}) async {
    return await api.register(email: email, username: username, password: password);
  }

  void signOut() {
    state = UserManagerState.busy;
    user = null;
    state = UserManagerState.idle;
  }





}