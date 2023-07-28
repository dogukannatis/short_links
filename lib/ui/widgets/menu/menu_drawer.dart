import 'package:flutter/material.dart';
import 'package:short_links/ui/resources/routes_manager.dart';
import 'package:short_links/ui/widgets/CustomButton.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({
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
               const ListTile(
                  title: Text("Short Links", style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                ListTile(
                  title: const Text("Home"),
                  onTap: (){
                    Navigator.pushReplacementNamed(context, Routes.homePageRoute);
                  },
                ),
                ListTile(
                  title: const Text("What is Short Links?"),
                  onTap: (){
                    Navigator.pushReplacementNamed(context, Routes.whatIsShortLinksPageRoute);
                  },
                ),
                /*
                ListTile(
                  onTap: (){
                    Navigator.pushReplacementNamed(context, Routes.linkShortener);
                  },
                  leading: const Icon(Icons.add_link,),
                  title: const Text("Link Shortener"),
                ),
                 */
                /*
                ListTile(
                  title: const Text("How To Use"),
                  onTap: (){

                  },
                ),
                 */
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: CustomButton(
                    onPressed: (){
                      Navigator.pushReplacementNamed(context, Routes.login);
                    },
                    child: const Text("Login"),
                  ),
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: CustomButton(
                    onPressed: (){
                      Navigator.pushReplacementNamed(context, Routes.register);
                    },
                    color: Colors.black,
                    splashColor: Colors.black,
                    child: const Text("Register"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}