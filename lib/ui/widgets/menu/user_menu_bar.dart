import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:short_links/ui/resources/routes_manager.dart';
import 'package:short_links/view_model/user_manager.dart';



class UserMenuBar extends ConsumerWidget implements PreferredSizeWidget {
  final AppBar appBar;
  final bool isMobile;
  const UserMenuBar({
    Key? key,
    required this.isMobile,
    required this.appBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userManager = ref.read(userManagerProvider.notifier);


    return AppBar(
      centerTitle: false,
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: const Text("Short Links"),
      actions: isMobile ? null : [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const SizedBox(width: 10,),
              InkWell(
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Home Page", style: TextStyle(fontSize: 12)),
                ),
                onTap: (){
                  Navigator.pushReplacementNamed(context, Routes.userHomePage);
                },
              ),
              const SizedBox(width: 10,),
              InkWell(
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("My Links", style: TextStyle(fontSize: 12),),
                ),
                onTap: (){
                  Navigator.pushReplacementNamed(context, Routes.myLinks);
                },
              ),
              const SizedBox(width: 10,),
              InkWell(
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Link Shortener", style: TextStyle(fontSize: 12),),
                ),
                onTap: (){
                  Navigator.pushReplacementNamed(context, Routes.linkShortener);
                },
              ),
              const VerticalDivider(),
              const SizedBox(width: 10,),

              ElevatedButton(
                onPressed: (){
                  userManager.signOut();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red
                ),
                child: const Text("Sign out", style: TextStyle(fontSize: 12,)),
              ),
              const SizedBox(width: 40,),
            ],
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
