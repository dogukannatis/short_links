// ignore_for_file: use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:short_links/models/user.dart';
import 'package:short_links/ui/resources/input_checker.dart';
import 'package:short_links/ui/resources/string_manager.dart';
import 'package:short_links/ui/widgets/CustomButton.dart';
import 'package:short_links/ui/widgets/CustomDialog.dart';
import 'package:short_links/ui/widgets/menu/user_menu_bar.dart';
import 'package:short_links/ui/widgets/menu/user_menu_drawer.dart';
import 'package:short_links/view_model/user_manager.dart';


class UserDetailsPage extends ConsumerStatefulWidget {
  final User user;
  const UserDetailsPage({
    Key? key,
    required this.user
  }) : super(key: key);

  @override
  ConsumerState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends ConsumerState<UserDetailsPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController idController = TextEditingController();

  bool isAdmin = false;
  bool isEmailVerified = false;

  bool isMobile = false;

  bool isSaving = false;
  bool isDeleting = false;


  @override
  void initState() {
    super.initState();
    usernameController.text = widget.user.username ?? "";
    emailController.text = widget.user.email ?? "";
    idController.text = widget.user.id;
    isAdmin = widget.user.isAdmin ?? false;
    isEmailVerified = widget.user.isEmailVerified ?? false;
  }

  @override
  Widget build(BuildContext context) {
    isMobile = MediaQuery.of(context).size.width > 700 ? false : true;

    return Scaffold(
      appBar: UserMenuBar(isMobile: isMobile, appBar: AppBar(),),
      drawer: isMobile ? const UserMenuDrawer() : null,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20,),
                TextFormField(
                  controller: idController,
                  style: const TextStyle(color: Colors.grey),
                  readOnly: true,
                  decoration: const InputDecoration(
                      prefix: Text("ID:  ", style: TextStyle(fontWeight: FontWeight.bold))
                  ),
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  controller: emailController,
                  style: const TextStyle(color: Colors.grey),
                  readOnly: true,
                  decoration: const InputDecoration(
                      prefix: Text("Email:  ", style: TextStyle(fontWeight: FontWeight.bold))
                  ),
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    hintText: "Username",
                    prefix: Text("Username:  ", style: TextStyle(fontWeight: FontWeight.bold),)
                  ),
                  validator: (v){
                    if(!InputChecker.isValidUsername(v!)){
                      return "Please enter a valid username";
                    }else{
                      return null;
                    }
                  },
                  onChanged: (v){
                    setState(() {

                    });
                  },
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  readOnly: true,
                  style: const TextStyle(color: Colors.grey),
                  initialValue: "Admin",
                  decoration: InputDecoration(
                      suffixIcon: isAdmin ? const Icon(Icons.done, color: Colors.green,) : const Icon(Icons.close, color: Colors.red,)
                  ),
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  readOnly: true,
                  style: const TextStyle(color: Colors.grey),
                  initialValue: "Verified",
                  decoration: InputDecoration(
                      suffixIcon: isAdmin ? const Icon(Icons.done, color: Colors.green,) : const Icon(Icons.close, color: Colors.red,)
                  ),
                ),
                const SizedBox(height: 20,),
                CustomButton(
                  width: 200,
                  onPressed: usernameController.text == widget.user.username || (isSaving || isDeleting) ? null : (){
                    if(_formKey.currentState!.validate()){
                      _formKey.currentState!.save();
                      CustomDialog(
                        title: "Update User",
                        description: "Do you want to update?",
                        acceptButton: "Update",
                        cancelButton: "Cancel",
                        acceptFunction: () =>  _saveUser(),
                      ).show(context);

                    }
                  },
                  child: isSaving ? const Center(
                    child: SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(),
                    ),
                  ) : const Text("Save User"),
                ),
                const SizedBox(height: 10,),
                CustomButton(
                  color: Colors.red,
                  splashColor: Colors.red,
                  width: 200,
                  onPressed: isSaving || isDeleting ? null : (){
                    CustomDialog(
                      title: "Delete User",
                      description: "Do you want to delete ${widget.user.username}?",
                      acceptButton: "Delete",
                      cancelButton: "Cancel",
                      acceptFunction: () => _deleteUser(),
                    ).show(context);

                  },
                  child: isDeleting ? const Center(
                    child: SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(),
                    ),
                  ) : const Text("Delete User"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _saveUser() async {
    final userManager = ref.read(userManagerProvider.notifier);

    setState(() {
      isSaving = true;
    });
    try{
      bool result = await userManager.updateUser(username: usernameController.text, userID: widget.user.id);
      if(result){
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: AppStrings.success,
            message: AppStrings.operationIsSuccessful,
            contentType: ContentType.success,
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pop(context);
      }
    }catch(e, str){
      debugPrint("HATA: $e $str");
      CustomDialog(
        title: "Error",
        description: "Error: $e",
        acceptButton: "Close",
      ).show(context);
    }
    setState(() {
      isSaving = false;
    });



  }

  Future<void> _deleteUser() async {
    final userManager = ref.read(userManagerProvider.notifier);

    setState(() {
      isSaving = true;
    });
    try{
      bool result = await userManager.deleteUser(userID: widget.user.id);
      if(result){
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: AppStrings.success,
            message: AppStrings.operationIsSuccessful,
            contentType: ContentType.success,
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pop(context);
      }
    }catch(e, str){
      debugPrint("HATA: $e $str");
      CustomDialog(
        title: "Error",
        description: "Error: $e",
        acceptButton: "Close",
      ).show(context);
    }
    setState(() {
      isSaving = false;
    });



  }


}
