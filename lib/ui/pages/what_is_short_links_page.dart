import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:short_links/ui/resources/color_manager.dart';
import 'package:short_links/ui/resources/string_manager.dart';
import 'package:short_links/ui/widgets/card_widget.dart';
import 'package:short_links/ui/widgets/menu/menu_drawer.dart';
import 'package:short_links/ui/widgets/menu/menu_app_bar.dart';

class WhatIsShortLinksPage extends ConsumerStatefulWidget {
  const WhatIsShortLinksPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _WhatIsShortLinksPageState();
}

class _WhatIsShortLinksPageState extends ConsumerState<WhatIsShortLinksPage> {


  bool isMobile = false;

  @override
  Widget build(BuildContext context) {
    isMobile = MediaQuery.of(context).size.width > 700 ? false : true;


    return Scaffold(
      appBar: MenuAppBar(isMobile: isMobile, appBar: AppBar(),),
      drawer: isMobile ? const MenuDrawer() : null,
      body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildHeaderSection(),
                const SizedBox(height: 20,),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: Container(
                    color: ColorManager.backgroundAlternateColor,
                    child: const Center(
                        child: Text(AppStrings.whatIsPageFeaturesTitle, style: TextStyle(fontSize: 21, letterSpacing: 3),)
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: CardWidget(title: "Url Shortener", body: "Cut your links via using our url shortener service",),
                    )),
                    Flexible(child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: CardWidget(title: "No Limit", body: "You can use the service as free without any limitations",),
                    )),
                    Flexible(child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: CardWidget(title: "Trace", body: "Trace and share your links easily",),
                    )),
                  ],
                )
              ],
            ),
          ),


      ),
    );
  }

  Padding _buildHeaderSection() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          const Flexible(
            child: Column(
              children: [
                Text(AppStrings.whatIsPageTitle, style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold, letterSpacing: 3),),
                SizedBox(height: 10,),
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(AppStrings.explanationText, style: TextStyle(fontSize: 18, letterSpacing: 3), textAlign: TextAlign.center,),
                )
              ],
            ),
          ),
          Flexible(
            child: Image.asset("assets/link.jpg", height: 400,),
          )
        ],
      ),
    );
  }
}