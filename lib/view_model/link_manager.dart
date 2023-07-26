import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:short_links/models/link.dart';
import 'package:short_links/models/user.dart';
import 'package:short_links/services/api.dart';

import '../locator.dart';


enum LinkManagerState {idle, busy}

final linkManagerProvider = StateNotifierProvider<LinkManager, LinkManagerState>((ref) {
  return LinkManager(LinkManagerState.idle);
});

class LinkManager extends StateNotifier<LinkManagerState>{

  LinkManager(LinkManagerState state) : super(state);

  Api api = Api();

  Future<List<Link>> getMyLinks({required String token}) async {

    try{
      await Future.delayed(const Duration(microseconds: 100));
      state = LinkManagerState.busy;
      return await api.getMyLinks(token: token);
    }finally{
      state = LinkManagerState.idle;
    }

  }





}