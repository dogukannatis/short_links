import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:short_links/ui/resources/routes_manager.dart';
import 'package:short_links/ui/resources/string_manager.dart';
import 'package:short_links/ui/widgets/CustomButton.dart';
import 'package:short_links/ui/widgets/menu/user_menu_bar.dart';
import 'package:short_links/ui/widgets/menu/user_menu_drawer.dart';
import 'package:short_links/view_model/user_manager.dart';

class UserHomePage extends ConsumerStatefulWidget {
  const UserHomePage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _UserHomePageState();
}

class _UserHomePageState extends ConsumerState<UserHomePage> {

  bool isMobile = false;

  @override
  Widget build(BuildContext context) {
    isMobile = MediaQuery.of(context).size.width > 700 ? false : true;

    final userManager = ref.read(userManagerProvider.notifier);

    return Scaffold(
      appBar: UserMenuBar(isMobile: isMobile, appBar: AppBar(),),
      drawer: isMobile ? const UserMenuDrawer() : null,
      body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("${AppStrings.welcome} ${userManager.user!.username}", style: const TextStyle(fontSize: 32, letterSpacing: 3),),
              const SizedBox(height: 10,),
              CustomButton(
                width: 200,
                onPressed: (){
                  Navigator.pushReplacementNamed(context, Routes.myLinks);
                },
               child: const Text(AppStrings.letsManageYourLinks),
              )
            ],
          )
      ),
    );
  }
}
