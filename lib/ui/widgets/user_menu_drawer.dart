import 'package:flutter/material.dart';
import 'package:short_links/ui/widgets/CustomDialog.dart';

class UserMenuDrawer extends StatelessWidget {
  const UserMenuDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                        const CustomDialog(
                          title: "Çıkış Yap",
                          description: "Çıkış yapmak istediğnize emin misiniz?",
                          acceptButton: "Çıkış Yap",
                          cancelButton: "Vazgeç",
                          // acceptFunction: ()=> _signOut(),
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