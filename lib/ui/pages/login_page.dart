import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:short_links/ui/resources/input_checker.dart';
import 'package:short_links/ui/resources/routes_manager.dart';
import 'package:short_links/ui/resources/string_manager.dart';
import 'package:short_links/ui/widgets/CustomButton.dart';
import 'package:short_links/ui/widgets/CustomDialog.dart';
import 'package:short_links/ui/widgets/menu/menu_drawer.dart';
import 'package:short_links/ui/widgets/menu/menu_app_bar.dart';

import '../../view_model/user_manager.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {

  final GlobalKey<FormState> _formLoginKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isMobile = false;
  bool show = false;

  @override
  Widget build(BuildContext context) {
    isMobile = MediaQuery.of(context).size.width > 700 ? false : true;

    final userManagerState = ref.watch(userManagerProvider);


    return Scaffold(
      appBar: MenuAppBar(isMobile: isMobile, appBar: AppBar(),),
      drawer: isMobile ? const MenuDrawer() : null,
      body: SingleChildScrollView(
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: Image.asset("assets/login.png", height: 400,),
              ),
              const SizedBox(width: 30,),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Form(
                    key: _formLoginKey,
                    child: Column(
                      children: [
                        const Text("Login", style: TextStyle(fontSize: 21, letterSpacing: 3),),
                        const SizedBox(height: 20,),
                        TextFormField(
                          decoration: const InputDecoration(
                              hintText: "Email"
                          ),
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value){
                            if(value!.isEmpty || !InputChecker.isEmail(value)){
                              return "Please enter a valid email address";
                            }else{
                              return null;
                            }

                          },
                        ),
                        const SizedBox(height: 20,),
                        TextFormField(
                          obscureText: show ? false : true,
                          decoration: InputDecoration(
                              hintText: "Password",
                              suffixIcon: GestureDetector(
                                child: show == true ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                                onTap: (){
                                  setState(() {
                                    show = !show;
                                  });
                                },
                              )
                          ),
                          controller: passwordController,
                          validator: (v){
                            if(v!.isEmpty){
                              return "Please enter a valid password";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20,),
                        CustomButton(
                          onPressed: (){
                            //TODO: Login Operations
                            if(_formLoginKey.currentState!.validate()){
                              _formLoginKey.currentState!.save();
                              signin();
                            }
                          },
                          child: userManagerState == UserManagerState.busy
                             ? const SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white,),
                          ) : const Text(AppStrings.login),
                        ),
                        const SizedBox(height: 20,),
                        const Divider(thickness: 2,),
                        const SizedBox(height: 20,),
                        CustomButton(
                          onPressed: (){
                            Navigator.pushReplacementNamed(context, Routes.register);
                          },
                          color: Theme.of(context).colorScheme.secondary,
                          splashColor: Theme.of(context).colorScheme.secondary,
                          child: const Text(AppStrings.register),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signin() async {
    final userModel = ref.read(userManagerProvider.notifier);

    try{
      await userModel.signin(email: emailController.text, password: passwordController.text);
      Navigator.pushReplacementNamed(context, Routes.userHomePage);

    }catch(e, str){
      debugPrint("Error Login: $e $str");
      const CustomDialog(
        title: "Error",
        description: "Email or password is wrong. Please try again.",
        acceptButton: "Close",
      ).show(context);
    }


  }



}
