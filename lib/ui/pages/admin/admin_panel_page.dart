import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:short_links/ui/resources/routes_manager.dart';
import 'package:short_links/ui/resources/string_manager.dart';
import 'package:short_links/ui/widgets/CustomButton.dart';
import 'package:short_links/ui/widgets/menu/user_menu_bar.dart';
import 'package:short_links/ui/widgets/menu/user_menu_drawer.dart';
import 'package:short_links/ui/widgets/statistic_widget.dart';

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
      body: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                StatisticCard(title: "Users", value: "100",),
                StatisticCard(title: "Links", value: "230",),
              ],
            ),
          ],
        ),
      ),

    );
  }



}

class StatisticCard extends StatelessWidget {
  final String title;
  final String value;

  const StatisticCard({
    super.key, required this.title, required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Text("340", style: TextStyle(fontWeight: FontWeight.bold),),
            Text("Link"),
          ],
        ),
      ),
    );
  }


  Widget _getManagementButton(BuildContext context) {
    return Column(
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
    );
  }



}

