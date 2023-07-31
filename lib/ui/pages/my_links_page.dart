import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:short_links/models/link.dart';
import 'package:short_links/ui/resources/constants_manager.dart';
import 'package:short_links/ui/resources/routes_manager.dart';
import 'package:short_links/ui/resources/string_manager.dart';
import 'package:short_links/ui/widgets/CustomButton.dart';
import 'package:short_links/ui/widgets/CustomDialog.dart';
import 'package:short_links/ui/widgets/menu/user_menu_bar.dart';
import 'package:short_links/ui/widgets/menu/user_menu_drawer.dart';
import 'package:short_links/view_model/link_manager.dart';
import 'package:short_links/view_model/user_manager.dart';
import 'package:url_launcher/url_launcher.dart';

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
    debugPrint("userManager.user!.token: ${userManager.user!.token}");
    linkList = await linkManager.getMyLinks(token: userManager.user!.token!);
  }


  @override
  Widget build(BuildContext context) {
    isMobile = MediaQuery.of(context).size.width > 700 ? false : true;

    final linkManagerState = ref.watch(linkManagerProvider);

    return Scaffold(
      appBar: UserMenuBar(isMobile: isMobile, appBar: AppBar(),),
      drawer: isMobile ? const UserMenuDrawer() : null,
      body: linkManagerState == LinkManagerState.busy ? const Center(
        child: CircularProgressIndicator(),
      ) : linkList.isEmpty ? Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(AppStrings.youHaveNotAnyLinkRecords, style: TextStyle(fontSize: 32, letterSpacing: 3),),
            const SizedBox(height: 10,),
            CustomButton(
              width: 200,
              onPressed: (){
                Navigator.pushReplacementNamed(context, Routes.linkShortener);
              }, child: const Text(AppStrings.letsAddALink),
            )
          ],
        ),
      ) :
      SingleChildScrollView(
        child: Column(
          children: [
            const Text("My Links", style: TextStyle(fontSize: 32, letterSpacing: 3),),
            ListView.builder(
              shrinkWrap: true,
              itemCount: linkList.length,
              itemBuilder: (context, index){
                final link = linkList[index];
                return ListTile(
                  onTap: () async {
                    debugPrint("link: ${AppConstants.shortUrl}${link.refLink}");
                    if (!await launchUrl(Uri.parse("${AppConstants.shortUrl}${link.refLink}"))) {
                      throw Exception('Could not launch ${AppConstants.shortUrl}${link.refLink}');
                    }
                  },
                  title: Text("${AppConstants.shortUrl}${link.refLink}"),
                  subtitle: Text("${link.originalLink}"),
                  trailing: Text("${link.click} clicks"),
                  leading: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: (){

                      CustomDialog(
                        title: "Delete",
                        description: "Do you want to delete url?",
                        cancelButton: "Cancel",
                        acceptButton: "Delete",
                        acceptFunction: () => deleteLink(linkList[index].id),
                      ).show(context);


                    },
                  ),
                );
              },
            ),
          ],
        ),
      )
    );
  }

  Future<void> deleteLink(id) async {
    final linkManager = ref.read(linkManagerProvider.notifier);
    final userManager = ref.read(userManagerProvider.notifier);

    try{
      bool result = await linkManager.deleteMyLink(id: id, token: userManager.user!.token!);
      if(result){
        linkList.removeWhere((element) => element.id == id);
        setState(() {

        });
      }
    }catch(e, str){
      debugPrint("Error deleteLink: $e $str");
      const CustomDialog(
        title: "Error",
        description: "Something went wrong. Please try again.",
        acceptButton: "Close",
      ).show(context);
    }

  }

}
