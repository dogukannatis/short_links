import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:short_links/ui/pages/home_page.dart';
import 'package:short_links/ui/theme/theme.dart';

import 'ui/resources/routes_manager.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Short Links',
      theme: lightTheme,
      home: const HomePage(),
      initialRoute: Routes.homePageRoute,
      onGenerateRoute: RouteGenerator.getRoute,
    );
  }
}

