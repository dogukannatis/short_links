import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:short_links/ui/resources/routes_manager.dart';
import 'package:short_links/ui/resources/string_manager.dart';
import 'package:short_links/ui/widgets/CustomButton.dart';
import 'package:short_links/ui/widgets/menu/user_menu_bar.dart';
import 'package:short_links/ui/widgets/menu/user_menu_drawer.dart';

class AdminPanelPage extends ConsumerStatefulWidget {
  const AdminPanelPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _AdminPanelPageState();
}

class _AdminPanelPageState extends ConsumerState<AdminPanelPage> {


  bool isMobile = false;

  @override
  Widget build(BuildContext context) {
    isMobile = MediaQuery.of(context).size.width > 700 ? false : true;


    return Scaffold(
      appBar: UserMenuBar(isMobile: isMobile, appBar: AppBar(),),
      drawer: isMobile ? const UserMenuDrawer() : null,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButton(
              width: 200,
              onPressed: (){
                Navigator.pushReplacementNamed(context, Routes.manageUsers);
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.people),
                  SizedBox(width: 10,),
                  Text(AppStrings.manageUsers),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            CustomButton(
              width: 200,
              onPressed: (){
                Navigator.pushReplacementNamed(context, Routes.manageLinks);
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.link),
                  SizedBox(width: 10,),
                  Text(AppStrings.manageLinks),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }

  Widget _manageLinks() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Manage Links", style: TextStyle(fontSize: 32, letterSpacing: 3),),
          const Divider(thickness: 2,),

        ],
      ),
    );
  }

  Widget _manageUsers() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Manage Users", style: TextStyle(fontSize: 32, letterSpacing: 3),),
          const Divider(thickness: 2,),

        ],
      ),
    );
  }


}
