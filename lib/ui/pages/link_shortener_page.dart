import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:short_links/ui/widgets/menu/user_menu_bar.dart';
import 'package:short_links/ui/widgets/menu/user_menu_drawer.dart';

class LinkShortenerPage extends ConsumerStatefulWidget {
  const LinkShortenerPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _LinkShortenerPageState();
}

class _LinkShortenerPageState extends ConsumerState<LinkShortenerPage> {

  bool isMobile = false;


  @override
  Widget build(BuildContext context) {
    isMobile = MediaQuery.of(context).size.width > 700 ? false : true;

    return Scaffold(
      appBar: UserMenuBar(isMobile: isMobile, appBar: AppBar(),),
      drawer: isMobile ? const UserMenuDrawer() : null,
    );
  }
}
