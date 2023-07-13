import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:short_links/ui/resources/input_checker.dart';
import 'package:short_links/ui/resources/string_manager.dart';
import 'package:short_links/ui/widgets/CustomButton.dart';
import 'package:short_links/ui/widgets/home_menu_drawer.dart';
import 'package:short_links/ui/widgets/menu_app_bar.dart';

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


    return Scaffold(
      appBar: MenuAppBar(isMobile: isMobile, appBar: AppBar(),),
      drawer: isMobile ? const HomeMenuDrawer() : null,
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
                              return "Lütfen geçerli bir mail adresi girin";
                            }else{
                              return null;
                            }

                          },
                        ),
                        const SizedBox(height: 20,),
                        TextFormField(
                          obscureText: show ? false : true,
                          decoration: InputDecoration(
                              hintText: "Şifre",
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
                              return "Geçerli bir şifre girin";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20,),
                        CustomButton(
                          onPressed: (){

                          },
                          child: const Text(AppStrings.login),
                        ),
                        const SizedBox(height: 20,),
                        const Divider(thickness: 2,),
                        const SizedBox(height: 20,),
                        CustomButton(
                          onPressed: (){

                          },
                          color: Theme.of(context).colorScheme.secondary,
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
}
