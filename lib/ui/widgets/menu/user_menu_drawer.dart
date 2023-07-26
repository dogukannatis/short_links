import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:short_links/ui/resources/routes_manager.dart';
import 'package:short_links/ui/widgets/CustomDialog.dart';
import 'package:short_links/view_model/user_manager.dart';

class UserMenuDrawer extends ConsumerWidget {
  const UserMenuDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userManager = ref.read(userManagerProvider.notifier);

    return Drawer(
      // backgroundColor: iPurple.shade500,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [
                            Colors.blue,
                            Colors.purple
                          ]
                      )
                  ),
                  accountName: Text("account"),
                  accountEmail: Text("mail"),

                ),
                Column(
                  children: [
                    ListTile(
                      onTap: (){
                        Navigator.pushReplacementNamed(context, Routes.myLinks);
                      },
                      leading: const Icon(Icons.link, color: Colors.white,),
                      title: const Text("My Links", style: TextStyle(color: Colors.white)),
                    ),
                    ListTile(
                      onTap: (){
                        Navigator.pushReplacementNamed(context, Routes.linkShortener);
                      },
                      leading: const Icon(Icons.add_link, color: Colors.white,),
                      title: const Text("Link Shortener", style: TextStyle(color: Colors.white)),
                    ),
                    ListTile(
                      onTap: (){
                        CustomDialog(
                          title: "Çıkış Yap",
                          description: "Çıkış yapmak istediğnize emin misiniz?",
                          acceptButton: "Çıkış Yap",
                          cancelButton: "Vazgeç",
                          acceptFunction: () {
                            userManager.signOut();
                          },
                        ).show(context);
                      },
                      leading: const Icon(Icons.exit_to_app, color: Colors.white,),
                      title: const Text("Çıkış Yap", style: TextStyle(color: Colors.white)),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}