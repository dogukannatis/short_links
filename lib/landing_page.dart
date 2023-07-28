import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:short_links/ui/pages/home_page.dart";
import "package:short_links/ui/pages/user_home_page.dart";
import "package:short_links/ui/theme/theme.dart";
import "package:short_links/view_model/user_manager.dart";

import "ui/resources/routes_manager.dart";

class LandingPage extends ConsumerStatefulWidget {
  const LandingPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _LandingPageState();
}

class _LandingPageState extends ConsumerState<LandingPage> {



  @override
  Widget build(BuildContext context) {

    ref.watch(userManagerProvider);
    final user = ref.read(userManagerProvider.notifier).user;
    debugPrint("Landing Page");
    debugPrint("user: $user");

    if(user != null){
      if(user.isAdmin == true){
        return MaterialApp(
          title: 'Short Links',
          theme: lightTheme,
          home: const UserHomePage(),
          initialRoute: Routes.userHomePage,
          onGenerateRoute: RouteGenerator.getAdminRoute,
        );
      }else{
        return MaterialApp(
          title: 'Short Links',
          theme: lightTheme,
          home: const UserHomePage(),
          initialRoute: Routes.userHomePage,
          onGenerateRoute: RouteGenerator.getUserRoute,
        );
      }
    }else{
      return MaterialApp(
        title: 'Short Links',
        theme: lightTheme,
        home: const HomePage(),
        initialRoute: Routes.homePageRoute,
        onGenerateRoute: RouteGenerator.getRoute,
      );
    }
  }
}
