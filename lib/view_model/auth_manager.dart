import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:short_links/models/user.dart';

import 'package:short_links/view_model/user_manager.dart';

import '../locator.dart';


enum AuthState {loggedIn, loggedOut}

final authManagerProvider = StateNotifierProvider<AuthManager, AuthState>((ref) {
  return AuthManager(AuthState.loggedOut,ref);
});

class AuthManager extends StateNotifier<AuthState>{
  Ref ref;

  AuthManager(AuthState state,this.ref) : super(state) {
    listenAuthState();
  }


  Future<void> listenAuthState() async {
    /*
    User? user = ref.watch(userManagerProvider);

    if(user != null){
      state = AuthState.loggedIn;
    }else{
      state = AuthState.loggedOut;
    }
     */

  }





}