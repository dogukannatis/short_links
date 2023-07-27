import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:short_links/models/link.dart';
import 'package:short_links/ui/resources/constants_manager.dart';
import 'package:short_links/ui/resources/input_checker.dart';
import 'package:short_links/ui/resources/string_manager.dart';
import 'package:short_links/ui/widgets/CustomButton.dart';
import 'package:short_links/ui/widgets/CustomDialog.dart';
import 'package:short_links/ui/widgets/menu/user_menu_bar.dart';
import 'package:short_links/ui/widgets/menu/user_menu_drawer.dart';
import 'package:short_links/view_model/link_manager.dart';
import 'package:short_links/view_model/user_manager.dart';

class LinkShortenerPage extends ConsumerStatefulWidget {
  const LinkShortenerPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _LinkShortenerPageState();
}

class _LinkShortenerPageState extends ConsumerState<LinkShortenerPage> {

  final GlobalKey<FormState> _formLoginKey = GlobalKey<FormState>();

  TextEditingController urlController = TextEditingController();

  bool isMobile = false;

  Link? convertedLink;

  bool isDone = false;
  bool isCopied = false;


  @override
  Widget build(BuildContext context) {
    isMobile = MediaQuery.of(context).size.width > 700 ? false : true;



    final linkManagerState = ref.watch(linkManagerProvider);


    return Scaffold(
      appBar: UserMenuBar(isMobile: isMobile, appBar: AppBar(),),
      drawer: isMobile ? const UserMenuDrawer() : null,
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 3,
                  child: Image.asset("assets/url_2.png", height: 400,),
                ),

                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 20,),
                      const Text("Link Shortener", style: TextStyle(fontSize: 32, letterSpacing: 3),),
                      const SizedBox(height: 20,),
                      const Text("Enter your link below", style: TextStyle(fontSize: 24),),
                      const SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal:  20
                        ),
                        child: Form(
                          key: _formLoginKey,
                          child: Column(
                            children: [
                              TextFormField(
                                readOnly: isDone ? true : false,
                                decoration: InputDecoration(
                                    hintText: "Your URL",
                                    suffixIcon: isDone ? GestureDetector(
                                      child: isCopied ? const Icon(Icons.done, color: Colors.green,) : const Icon(Icons.copy),
                                      onTap: () async {
                                        await Clipboard.setData(ClipboardData(text: urlController.text));
                                        setState(() {
                                          isCopied = true;
                                        });
                                      },
                                    ) : null,
                                ),
                                controller: urlController,
                                validator: (v){
                                  if(v!.isEmpty || !InputChecker.isValidUrl(v)){
                                    return "Please enter a valid url";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20,),
                              CustomButton(
                                onPressed: (){
                                  if(isDone){
                                    urlController.clear();
                                    setState(() {
                                      isDone = false;
                                    });
                                    return;
                                  }

                                  if(_formLoginKey.currentState!.validate()){
                                    _formLoginKey.currentState!.save();

                                    _convertUrl();
                                  }
                                },
                                child: linkManagerState == LinkManagerState.busy ? const SizedBox(
                                  height: 16,
                                  width: 16,
                                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white,),
                                ) : isDone ? const Text(AppStrings.convertAgain) : const Text(AppStrings.convert),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _convertUrl() async {
    final linkManager = ref.read(linkManagerProvider.notifier);
    final userManager= ref.read(userManagerProvider.notifier);
    try{
      convertedLink = await linkManager.convertLink(originalLink: urlController.text, token: userManager.user!.token!);
      setState(() {
        urlController.text = AppConstants.shortUrl + convertedLink!.refLink!;
        isDone = true;
      });

    }catch(e, str){
      debugPrint("Error Convert: $e $str");
      const CustomDialog(
        title: "Error",
        description: "Something went wrong. Please try again.",
        acceptButton: "Close",
      ).show(context);
    }


  }


}

//sonari8371@weizixu.com