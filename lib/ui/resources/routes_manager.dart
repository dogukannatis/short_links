import 'package:flutter/material.dart';
import 'package:short_links/ui/pages/home_page.dart';
import 'package:short_links/ui/pages/what_is_short_links_page.dart';

class Routes {
  static const String homePageRoute = "/";
  static const String whatIsShortLinksPageRoute = "/whatIsShortLink";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch(routeSettings.name){
      case Routes.homePageRoute:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case Routes.whatIsShortLinksPageRoute:
        return MaterialPageRoute(builder: (_) => const WhatIsShortLinksPage());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute(){
    return MaterialPageRoute(builder: (_){
      return Scaffold(
        appBar: AppBar(
          title: const Text("Route not found!"),
        ),
        body: const Center(child: Text("Route can not be found.")),
      );
    });
  }

}