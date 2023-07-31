import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:short_links/models/link.dart';
import 'package:short_links/models/statistics.dart';
import 'package:short_links/services/api.dart';


enum LinkManagerState {idle, busy}

final linkManagerProvider = StateNotifierProvider<LinkManager, LinkManagerState>((ref) {
  return LinkManager(LinkManagerState.idle);
});

class LinkManager extends StateNotifier<LinkManagerState>{

  LinkManager(LinkManagerState state) : super(state);

  Api api = Api();

  List<Link> linkList = [];
  int page = 0;
  bool hasMoreLinks = true;


  Future<List<Link>> getMyLinks({required String token}) async {

    try{
      await Future.delayed(const Duration(microseconds: 100));
      state = LinkManagerState.busy;
      return await api.getMyLinks(token: token);
    }finally{
      state = LinkManagerState.idle;
    }

  }


  Future<List<Link>> getAllLinks({bool refresh = false}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString("token");

    if(token == null){
      debugPrint("Token is invalid. Login required.");
      return [];
    }


    try{
      state = LinkManagerState.busy;
      if(refresh){
        page = 0;
        hasMoreLinks = true;
      }

      if(hasMoreLinks == false){
        return linkList;
      }

      Map result = await api.getAllLinks(token: token, page: page);
      page++;
      linkList.addAll(result["links"]);

      if(result["links"].length < 20){
        hasMoreLinks = false;
      }

      return linkList;

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

  Future<bool> deleteLink({required String id}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString("token");

    if(token == null){
      return false;
    }

    try{
      state = LinkManagerState.busy;
      bool result = await api.deleteLink(token: token, id: id);
      if(result){
        linkList.removeWhere((element) => element.id == id);
      }
      return result;
    }finally{
      state = LinkManagerState.idle;
    }
  }

  Future<Statistics> getStatistics() async {
    /*
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString("token");

    if(token == null){
     throw "User credentials are not valid. Please signin again.";
    }
     */

    try{
      return await api.getStatistics();
    }finally{
      state = LinkManagerState.idle;
    }

  }





}