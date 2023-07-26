import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:short_links/ui/resources/input_checker.dart';
import 'package:short_links/ui/resources/routes_manager.dart';
import 'package:short_links/ui/resources/string_manager.dart';
import 'package:short_links/ui/widgets/CustomButton.dart';
import 'package:short_links/ui/widgets/CustomDialog.dart';
import 'package:short_links/ui/widgets/menu/menu_drawer.dart';
import 'package:short_links/ui/widgets/menu/menu_app_bar.dart';
import 'package:short_links/view_model/user_manager.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<RegisterPage> {

  final GlobalKey<FormState> _formRegisterKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  bool isMobile = false;

  @override
  Widget build(BuildContext context) {
    isMobile = MediaQuery.of(context).size.width > 700 ? false : true;

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
                    key: _formRegisterKey,
                    child: Column(
                      children: [
                        const Text("Register", style: TextStyle(fontSize: 21, letterSpacing: 3),),
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
                          decoration: const InputDecoration(
                              hintText: "Username"
                          ),
                          controller: usernameController,
                          validator: (value){
                            if(value!.isEmpty || !InputChecker.isValidUsername(value)){
                              return "Please enter a valid username";
                            }else{
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 20,),
                        TextFormField(
                          obscureText: true,
                          decoration: const InputDecoration(
                              hintText: "Password",
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
                        TextFormField(
                          obscureText: true,
                          decoration: const InputDecoration(
                              hintText: "Confirm your password",
                          ),
                          controller: passwordConfirmController,
                          validator: (v){
                            if(v!.isEmpty && v != passwordController.text){
                              return "Passwords are not matched";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20,),
                        CustomButton(
                          onPressed: (){
                            //TODO: Register Operations
                            if(_formRegisterKey.currentState!.validate()){
                              _formRegisterKey.currentState!.save();
                              register();
                            }
                          },
                          child: const Text(AppStrings.register),
                        ),
                        const SizedBox(height: 20,),
                        const Divider(thickness: 2,),
                        const SizedBox(height: 20,),
                        CustomButton(
                          onPressed: (){
                            Navigator.pushReplacementNamed(context, Routes.login);
                          },
                          color: Theme.of(context).colorScheme.secondary,
                          splashColor: Theme.of(context).colorScheme.secondary,
                          child: const Text(AppStrings.login),
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

  Future<void> register() async {
    final userModel = ref.read(userManagerProvider.notifier);
    try{
      bool result = await userModel.register(
          email: emailController.text,
          username: usernameController.text,
          password: passwordController.text
      );
      if(result){
        Navigator.pushReplacementNamed(context, Routes.login);
      }else{
        const CustomDialog(
          title: "Error",
          description: "Error occured",
          acceptButton: "Close",
        ).show(context);
      }
    }catch(e){
      CustomDialog(
        title: "Error",
        description: "Hata $e",
        acceptButton: "Close",
      ).show(context);
    }

  }

}
