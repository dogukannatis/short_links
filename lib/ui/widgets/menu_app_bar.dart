import 'package:flutter/material.dart';
import 'package:short_links/ui/resources/routes_manager.dart';
import 'package:short_links/ui/widgets/CustomButton.dart';


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
                  child: Text("Home Page"),
                ),
                onTap: (){
                  Navigator.pushReplacementNamed(context, Routes.homePageRoute);
                },
              ),
              const SizedBox(width: 10,),
              InkWell(
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("What is Short Links"),
                ),
                onTap: (){
                  Navigator.pushReplacementNamed(context, Routes.whatIsShortLinksPageRoute);
                },
              ),
              const SizedBox(width: 10,),
              InkWell(
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("How To Use?"),
                ),
                onTap: (){

                },
              ),
              const SizedBox(width: 10,),
              CustomButton(
                width: 100,
                onPressed: (){

                },
                child: const Text("Login"),
              ),
              const SizedBox(width: 10,),
              CustomButton(
                width: 100,
                onPressed: (){

                },
                color: Colors.black,
                splashColor: Colors.black,
                child: const Text("Register"),
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