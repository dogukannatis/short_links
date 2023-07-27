import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:short_links/models/link.dart';
import 'package:short_links/services/api.dart';


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

  Future<Link> convertLink({required String originalLink, required String token}) async {

    try{
      await Future.delayed(const Duration(microseconds: 100));
      state = LinkManagerState.busy;
      return await api.convertLink(originalLink: originalLink, token: token);
    }finally{
      state = LinkManagerState.idle;
    }

  }

  Future<bool> deleteMyLink({required String id, required String token}) async {

    try{
      await Future.delayed(const Duration(microseconds: 100));
      state = LinkManagerState.busy;
      return await api.deleteMyLink(id: id, token: token);
    }finally{
      state = LinkManagerState.idle;
    }

  }





}