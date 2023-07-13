import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:short_links/ui/resources/color_manager.dart';
import 'package:short_links/ui/resources/string_manager.dart';
import 'package:short_links/ui/widgets/home_menu_drawer.dart';
import 'package:short_links/ui/widgets/menu_app_bar.dart';
import 'package:short_links/ui/widgets/statistic_widget.dart';


class HomePage extends ConsumerStatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {

  bool isMobile = false;

  @override
  Widget build(BuildContext context) {

    isMobile = MediaQuery.of(context).size.width > 700 ? false : true;



    return Scaffold(
      appBar: MenuAppBar(isMobile: isMobile, appBar: AppBar(),),
        drawer: isMobile ? const HomeMenuDrawer() : null,
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
            const Row(
              children: [
                StatisticWidget(headerString: "300", bodyString: "Users",),
                SizedBox(width: 60,),
                StatisticWidget(headerString: "1300", bodyString: "Links",),
              ],
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 24),
                  foregroundColor: Colors.black
              ),
              onPressed: (){

              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(AppStrings.homePagePromotionalButtonText),
              ),
            )

            /*
                      StatisticCircleWidget(headerString: "300", bodyString: "Users",),
                      StatisticCircleWidget(headerString: "1250", bodyString: "Links",),
                      StatisticCircleWidget(headerString: "2", bodyString: "Years Experience",),
                       */
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

