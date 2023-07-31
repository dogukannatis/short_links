import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:short_links/models/statistics.dart';
import 'package:short_links/ui/resources/routes_manager.dart';
import 'package:short_links/ui/resources/string_manager.dart';
import 'package:short_links/ui/widgets/CustomButton.dart';
import 'package:short_links/ui/widgets/menu/user_menu_bar.dart';
import 'package:short_links/ui/widgets/menu/user_menu_drawer.dart';
import 'package:short_links/view_model/link_manager.dart';

class AdminPanelPage extends ConsumerStatefulWidget {
  const AdminPanelPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _AdminPanelPageState();
}

class _AdminPanelPageState extends ConsumerState<AdminPanelPage> {


  bool isMobile = false;

  bool isLoading = false;

  Statistics? statistics;



  @override
  void initState() {
    super.initState();
    _getStatistics();
  }

  Future<void> _getStatistics() async {
    final linkManager = ref.read(linkManagerProvider.notifier);
    setState(() {
      isLoading = true;
    });
    statistics = await linkManager.getStatistics();
    setState(() {
      isLoading = false;
    });

  }



  @override
  Widget build(BuildContext context) {
    isMobile = MediaQuery.of(context).size.width > 700 ? false : true;



    return Scaffold(
      appBar: UserMenuBar(isMobile: isMobile, appBar: AppBar(),),
      drawer: isMobile ? const UserMenuDrawer() : null,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Row(
              children: [
                Expanded(
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Center(child: Text(AppStrings.adminPanel, style: TextStyle(fontSize: 32, letterSpacing: 3),)),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(child: StatisticCard(title: "Users", value: statistics?.totalUsers.toString() ?? "-",)),
                const SizedBox(width: 10,),
                Expanded(child: StatisticCard(title: "Links", value: statistics?.totalLinks.toString() ?? "-",)),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: CustomButton(
                    onPressed: (){
                      Navigator.pushReplacementNamed(context, Routes.manageUsers);
                    },
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.people),
                        SizedBox(width: 10,),
                        Text(AppStrings.manageUsers),
                        SizedBox(width: 10,),
                        Icon(Icons.open_in_new_outlined),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: CustomButton(
                    onPressed: (){
                      Navigator.pushReplacementNamed(context, Routes.manageLinks);
                    },
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.link),
                        SizedBox(width: 10,),
                        Text(AppStrings.manageLinks),
                        SizedBox(width: 10,),
                        Icon(Icons.open_in_new_outlined),
                      ],
                    ),
                  ),
                ),
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
    super.key, required this.title, required this.value
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(width: 5,),
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
              ],
            ),
            Text(value, style: const TextStyle(fontSize: 18),),
          ],
        ),
      ),
    );
  }



}

