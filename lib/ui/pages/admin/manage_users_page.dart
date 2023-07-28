import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:short_links/models/user.dart';
import 'package:short_links/ui/pages/admin/user_details_page.dart';
import 'package:short_links/ui/widgets/CustomDialog.dart';
import 'package:short_links/ui/widgets/menu/user_menu_bar.dart';
import 'package:short_links/ui/widgets/menu/user_menu_drawer.dart';
import 'package:short_links/view_model/user_manager.dart';

class ManageUsersPage extends ConsumerStatefulWidget {
  const ManageUsersPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ManageUsersPageState();
}

class _ManageUsersPageState extends ConsumerState<ManageUsersPage> {

  final ScrollController _scrollController = ScrollController();

  bool isMobile = false;
  bool isLoading = false;
  bool isRefreshLoading = false;


  @override
  void initState() {
    super.initState();
    _setScrollController();
    _getUsers(true);
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

          await _getUsers(false);

          setState(() {
            isRefreshLoading = false;
          });

        }
      }
    });


  }

  Future<void> _getUsers(bool refresh) async {
    final userManager = ref.read(userManagerProvider.notifier);

    if(refresh){
     setState(() {
       isLoading = true;
     });
    }
    try{
      await userManager.getAllUsers(refresh: refresh);
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
    final userManager = ref.read(userManagerProvider.notifier);

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
              itemCount: userManager.userList.length,
              itemBuilder: (context, index){
                User user = userManager.userList[index];
                return ListTile(
                  title: Text("${user.username}"),
                  subtitle: Text("${user.email}"),
                  leading: user.isAdmin == true ? const Icon(Icons.shield) : const Icon(Icons.person),
                  trailing: user.isAdmin == false ? const Icon(Icons.manage_accounts) : null,
                  onTap: user.isAdmin == true ? null : (){
                    Navigator.push(context,
                        MaterialPageRoute(fullscreenDialog: true, builder: (context) => UserDetailsPage(user: user)));
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
}
