import 'package:flutter/material.dart';
import 'package:short_links/ui/resources/routes_manager.dart';


class MenuAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  const MenuAppBar({
    super.key,
    required this.isMobile,
    required this.appBar,
  });

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
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
                  child: Text("Home", style: TextStyle(fontSize: 12)),
                ),
                onTap: (){
                  Navigator.pushReplacementNamed(context, Routes.homePageRoute);
                },
              ),
              const SizedBox(width: 10,),
              InkWell(
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("What is Short Links", style: TextStyle(fontSize: 12),),
                ),
                onTap: (){
                  Navigator.pushReplacementNamed(context, Routes.whatIsShortLinksPageRoute);
                },
              ),
              /*
              const SizedBox(width: 10,),
              InkWell(
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("How To Use?", style: TextStyle(fontSize: 12)),
                ),
                onTap: (){

                },
              ),
               */
              const SizedBox(width: 10,),
              /*
              InkWell(
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Link Shortener", style: TextStyle(fontSize: 12),),
                ),
                onTap: (){
                  Navigator.pushReplacementNamed(context, Routes.linkShortener);
                },
              ),
               */
              const SizedBox(width: 10,),
              const VerticalDivider(),
              const SizedBox(width: 10,),
              /*
              InkWell(
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Login", style: TextStyle(fontSize: 12)),
                ),
                onTap: (){

                },
              ),
               */
              ElevatedButton(
                onPressed: (){
                  Navigator.pushReplacementNamed(context, Routes.login);
                },
                child: const Text("Login", style: TextStyle(fontSize: 12,)),
              ),
              const SizedBox(width: 10,),
              OutlinedButton(
                onPressed: (){
                  Navigator.pushReplacementNamed(context, Routes.register);
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black
                ),
                child: const Text("Register", style: TextStyle(fontSize: 12, color: Colors.black)),
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