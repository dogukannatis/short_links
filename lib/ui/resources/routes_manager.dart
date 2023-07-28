import 'package:flutter/material.dart';
import 'package:short_links/ui/pages/admin/admin_panel_page.dart';
import 'package:short_links/ui/pages/admin/manage_links_page.dart';
import 'package:short_links/ui/pages/admin/manage_users_page.dart';
import 'package:short_links/ui/pages/home_page.dart';
import 'package:short_links/ui/pages/link_shortener_page.dart';
import 'package:short_links/ui/pages/login_page.dart';
import 'package:short_links/ui/pages/my_links_page.dart';
import 'package:short_links/ui/pages/register_page.dart';
import 'package:short_links/ui/pages/user_home_page.dart';
import 'package:short_links/ui/pages/what_is_short_links_page.dart';

class Routes {
  static const String homePageRoute = "/";
  static const String whatIsShortLinksPageRoute = "/whatIsShortLink";
  static const String login = "/login";
  static const String register = "/register";
  static const String userHomePage = "/userHomePage";
  static const String myLinks = "/myLinks";
  static const String linkShortener = "/linkShortener";
  static const String adminPanelPage = "/adminPanel";
  static const String manageUsers = "/manageUsers";
  static const String manageLinks = "/manageLinks";
  static const String userDetails = "/userDetails";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch(routeSettings.name){
      case Routes.homePageRoute:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case Routes.whatIsShortLinksPageRoute:
        return MaterialPageRoute(builder: (_) => const WhatIsShortLinksPage());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case Routes.register:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case Routes.userHomePage:
        return MaterialPageRoute(builder: (_) => const UserHomePage());
      case Routes.linkShortener:
        return MaterialPageRoute(builder: (_) => const LinkShortenerPage());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> getUserRoute(RouteSettings routeSettings) {
    switch(routeSettings.name){
      case Routes.homePageRoute:
        return MaterialPageRoute(builder: (_) => const UserHomePage());
      case Routes.whatIsShortLinksPageRoute:
        return MaterialPageRoute(builder: (_) => const WhatIsShortLinksPage());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case Routes.register:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case Routes.userHomePage:
        return MaterialPageRoute(builder: (_) => const UserHomePage());
      case Routes.myLinks:
        return MaterialPageRoute(builder: (_) => const MyLinksPage());
      case Routes.linkShortener:
        return MaterialPageRoute(builder: (_) => const LinkShortenerPage());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> getAdminRoute(RouteSettings routeSettings) {
    switch(routeSettings.name){
      case Routes.homePageRoute:
        return MaterialPageRoute(builder: (_) => const UserHomePage());
      case Routes.whatIsShortLinksPageRoute:
        return MaterialPageRoute(builder: (_) => const WhatIsShortLinksPage());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case Routes.register:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case Routes.userHomePage:
        return MaterialPageRoute(builder: (_) => const UserHomePage());
      case Routes.myLinks:
        return MaterialPageRoute(builder: (_) => const MyLinksPage());
      case Routes.linkShortener:
        return MaterialPageRoute(builder: (_) => const LinkShortenerPage());
      case Routes.adminPanelPage:
        return MaterialPageRoute(builder: (_) => const AdminPanelPage());
      case Routes.manageUsers:
        return MaterialPageRoute(builder: (_) => const ManageUsersPage());
      case Routes.manageLinks:
        return MaterialPageRoute(builder: (_) => const ManageLinksPage());
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