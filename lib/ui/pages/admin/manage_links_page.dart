import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:short_links/models/link.dart';
import 'package:short_links/ui/resources/constants_manager.dart';
import 'package:short_links/ui/resources/string_manager.dart';
import 'package:short_links/ui/widgets/CustomDialog.dart';
import 'package:short_links/ui/widgets/menu/user_menu_bar.dart';
import 'package:short_links/ui/widgets/menu/user_menu_drawer.dart';
import 'package:short_links/view_model/link_manager.dart';
import 'package:url_launcher/url_launcher.dart';


class ManageLinksPage extends ConsumerStatefulWidget {
  const ManageLinksPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ManageLinksPageState();
}

class _ManageLinksPageState extends ConsumerState<ManageLinksPage> {

  final ScrollController _scrollController = ScrollController();

  bool isMobile = false;
  bool isLoading = false;
  bool isDeleting = false;
  bool isRefreshLoading = false;

  @override
  void initState() {
    super.initState();
    _setScrollController();
    _getLinks(true);
  }

  Future<void> _setScrollController() async {

    _scrollController.addListener(() async {
      if(_scrollController.position.atEdge){
        if(_scrollController.position.pixels == 0){
          debugPrint("scroll başı");
        }else if(isRefreshLoading == false){
          debugPrint("scroll aşağıda veriler getiriliyor");

          setState(() {
            isRefreshLoading = true;
          });

          await _getLinks(false);

          setState(() {
            isRefreshLoading = false;
          });

        }
      }
    });


  }

  Future<void> _getLinks(bool refresh) async {
    final linkManager = ref.read(linkManagerProvider.notifier);

    if(refresh){
      setState(() {
        isLoading = true;
      });
    }
    try{
      await linkManager.getAllLinks(refresh: refresh);
    }catch(e,str){
      debugPrint("HATA: $e $str");
      CustomDialog(
        title: "Error",
        description: "Error: $e",
        acceptButton: "Close",
      ).show(context);
    }


    if(refresh){
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    isMobile = MediaQuery.of(context).size.width > 700 ? false : true;
    final linkManager = ref.read(linkManagerProvider.notifier);

    return Scaffold(
      appBar: UserMenuBar(isMobile: isMobile, appBar: AppBar(),),
      drawer: isMobile ? const UserMenuDrawer() : null,
      body: isLoading ? const Center(
        child: CircularProgressIndicator(),
      ) : SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            ListView.builder(
              padding: const EdgeInsets.all(0.0),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: linkManager.linkList.length,
              itemBuilder: (context, index){
                Link link = linkManager.linkList[index];
                return ListTile(
                  title: Text("${AppConstants.url}${link.refLink}"),
                  subtitle: Text("${link.originalLink}"),
                  leading: Text("${link.click} Clicks"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("ID: ${link.id}"),
                      IconButton(
                        onPressed: (){
                          CustomDialog(
                            title: "Delete Link",
                            description: "Do you want to delete this link?",
                            acceptButton: "Delete",
                            cancelButton: "Cancel",
                            acceptFunction: () => _deleteLink(link.id),
                          ).show(context);
                        },
                        icon: const Icon(Icons.delete),
                      )
                    ],
                  ),
                  onTap: () async {
                    if (!await launchUrl(Uri.parse("${AppConstants.shortUrl}${link.refLink}"))) {
                    throw Exception('Could not launch ${AppConstants.shortUrl}${link.refLink}');
                    }
                  },
                );

              },
            ),
            isRefreshLoading ? const Center(
              child: CircularProgressIndicator(),
            ) : Container()
          ],
        ),
      ),
    );
  }

  Future<void> _deleteLink(id) async {
    final linkManager = ref.read(linkManagerProvider.notifier);

    setState(() {
      isDeleting = true;
    });
    try{
      bool result = await linkManager.deleteLink(id: id);
      if(result){
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: AppStrings.success,
            message: AppStrings.operationIsSuccessful,
            contentType: ContentType.success,
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }catch(e, str){
      debugPrint("HATA: $e $str");
      CustomDialog(
        title: "Error",
        description: "Error: $e",
        acceptButton: "Close",
      ).show(context);
    }

    setState(() {
      isDeleting = false;
    });



  }

}
