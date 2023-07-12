import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:short_links/ui/widgets/home_menu_drawer.dart';
import 'package:short_links/ui/widgets/menu_app_bar.dart';

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
      drawer: isMobile ? const HomeMenuDrawer() : null,
      body: const Center(
          child: Text("explanation page")
      ),
    );
  }
}
