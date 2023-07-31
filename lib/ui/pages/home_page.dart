import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:short_links/models/statistics.dart';
import 'package:short_links/ui/resources/color_manager.dart';
import 'package:short_links/ui/resources/routes_manager.dart';
import 'package:short_links/ui/resources/string_manager.dart';
import 'package:short_links/ui/widgets/menu/menu_drawer.dart';
import 'package:short_links/ui/widgets/menu/menu_app_bar.dart';
import 'package:short_links/ui/widgets/statistic_widget.dart';
import 'package:short_links/view_model/link_manager.dart';


class HomePage extends ConsumerStatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {

  bool isMobile = false;

  Statistics? statistics;



  @override
  void initState() {
    super.initState();
    _getStatistics();
  }

  Future<void> _getStatistics() async {
    final linkManager = ref.read(linkManagerProvider.notifier);
    statistics = await linkManager.getStatistics();
    setState(() {

    });

  }

  @override
  Widget build(BuildContext context) {

    isMobile = MediaQuery.of(context).size.width > 700 ? false : true;


    return Scaffold(
      appBar: MenuAppBar(isMobile: isMobile, appBar: AppBar(),),
        drawer: isMobile ? const MenuDrawer() : null,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Center(
            child: Column(
              children: [
                _buildHeaderSection(),
                const SizedBox(height: 10),
                _buildBodySection(context)
              ],
            )
          ),
        ),
      ),
    );
  }

  SizedBox _buildBodySection(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: Container(
        color: ColorManager.backgroundAlternateColor,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                StatisticWidget(headerString: statistics?.totalUsers.toString() ?? "-", bodyString: "Users",),
                const SizedBox(width: 60,),
                StatisticWidget(headerString: statistics?.totalLinks.toString() ?? "-", bodyString: "Links",),
              ],
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 24),
                  foregroundColor: Colors.black
              ),
              onPressed: (){
                Navigator.pushReplacementNamed(context, Routes.register);
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(AppStrings.homePagePromotionalButtonText),
              ),
            )
          ],
        ),
      ),
    );
  }

  Row _buildHeaderSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Flexible(
          child: Column(
            children: [
              Text(AppStrings.homePageTitle, style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold, letterSpacing: 3),),
              SizedBox(height: 10,),
              Text(AppStrings.homePageBodyText, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w200, letterSpacing: 3),),
            ],
          ),
        ),
        Flexible(
          child: Image.asset("assets/url_1.jpg", height: 400,),
        )
      ],
    );
  }


}



/*
FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Text(AppStrings.homePageTitle, style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold, letterSpacing: 3),),
                            SizedBox(width: 50,),
                          ],
                        ),
                        Text(AppStrings.homePageBodyText, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w200, letterSpacing: 3),),
                      ],
                    ),
                  ),
                  Image.asset("assets/url_1.jpg", height: 300,)
                ],
              ),
            ),
 */

