import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:short_links/models/link.dart';
import 'package:short_links/ui/widgets/menu/user_menu_bar.dart';
import 'package:short_links/ui/widgets/menu/user_menu_drawer.dart';
import 'package:short_links/view_model/link_manager.dart';
import 'package:short_links/view_model/user_manager.dart';

class MyLinksPage extends ConsumerStatefulWidget {
  const MyLinksPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _MyLinksPageState();
}

class _MyLinksPageState extends ConsumerState<MyLinksPage> {

  bool isMobile = false;

  List<Link> linkList = [];

  @override
  void initState() {
    super.initState();
    _getLinks();
  }

  Future<void> _getLinks() async {
    final linkManager = ref.read(linkManagerProvider.notifier);
    final userManager = ref.read(userManagerProvider.notifier);
    linkList = await linkManager.getMyLinks(token: userManager.user!.token!);
  }


  @override
  Widget build(BuildContext context) {
    isMobile = MediaQuery.of(context).size.width > 700 ? false : true;

    final linkManagerState = ref.read(linkManagerProvider);

    return Scaffold(
      appBar: UserMenuBar(isMobile: isMobile, appBar: AppBar(),),
      drawer: isMobile ? const UserMenuDrawer() : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text("My Links"),
            linkManagerState == LinkManagerState.busy ? const Center(
              child: CircularProgressIndicator(),
            ) : linkList.isEmpty ? const Text("List is empty") :
                ListView.builder(
                  itemCount: linkList.length,
                  itemBuilder: (context, index){
                    final link = linkList[index];
                    return ListTile(
                      title: Text("${link.originalLink}"),
                      subtitle: Text("${link.refLink}"),
                      trailing: Text("${link.click} clicks"),
                    );
                  },
                )
          ],
        ),
      ),
    );
  }
}
