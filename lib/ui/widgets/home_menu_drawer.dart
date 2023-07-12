import 'package:flutter/material.dart';
import 'package:short_links/ui/widgets/CustomButton.dart';

class HomeMenuDrawer extends StatelessWidget {
  const HomeMenuDrawer({
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
                  title: const Text("Home Page"),
                  onTap: (){

                  },
                ),
                ListTile(
                  title: const Text("What is Short Links?"),
                  onTap: (){

                  },
                ),
                ListTile(
                  title: const Text("How To Use"),
                  onTap: (){

                  },
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: CustomButton(

                    onPressed: (){

                    },
                    child: const Text("Login"),
                  ),
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: CustomButton(
                    onPressed: (){

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