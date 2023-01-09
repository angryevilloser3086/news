import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_reader/src/providers/login_providers.dart';
import 'package:provider/provider.dart';

import '../../utils/app_localization.dart';
import '../../utils/app_utils.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginProvider(),
      child: Scaffold(
        backgroundColor: AppConstants.appBgColor,
        body: SafeArea(
            child: Padding(
          padding: AppConstants.all_10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: AppConstants.all_20,
                child: Text(
                  Strings.of(context).appName,
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              AppConstants.h_50,AppConstants.h_60,
                      AppConstants.h_50,AppConstants.h_60,
                      AppConstants.h_50,
              
                Consumer<LoginProvider>(builder: (context, loginProvider, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    
                    children: [
                     
                      Padding(
                        padding: AppConstants.all_5,
                        child: textfiled(context, loginProvider,loginProvider.emailController, "Email"),
                      ),
                      Padding(
                        padding: AppConstants.all_5,
                        child: passField(context, loginProvider.passController,"Password"),
                      ),
                      AppConstants.h_60,
                      AppConstants.h_50,
                      AppConstants.h_60,
                      GestureDetector(child: toButton(context),onTap: () => loginProvider.signIn(context,loginProvider.emailController.text, loginProvider.passController.text),),
                      AppConstants.h_30,
                    text(context),
                    AppConstants.h_30
                    ],
                  );
                }),
              
              
            ],
          ),
        )),
      ),
    );
  }
  Row text(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          Strings.of(context).newHere,
          style: GoogleFonts.poppins(
              fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),
        ),
        AppConstants.w_5,
        InkWell(
          onTap: () {
            AppConstants.moveNextstl(context, const LoginScreen());
          },
          child: Text(
            Strings.of(context).singUp,
            style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppConstants.appPrimaryColor),
          ),
        )
      ],
    );
  }

  Container toButton(BuildContext context) {
    return Container(
        width: 231,
        height: 49,
        decoration: AppConstants.boxBorderDecorationPrimary,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              Strings.of(context).login,
              style: Theme.of(context).textTheme.headline3,
            )
          ],
        ));
  }

  textfiled(BuildContext context,  LoginProvider loginProvider,TextEditingController controller,String hint) {
    return TextFormField(
      autofocus: true,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => loginProvider.isEmail(value!)?null:"Please Enter Correct email",
      cursorColor: Colors.grey,
      style: Theme.of(context).textTheme.headline6,
      decoration: AppConstants.toAppInputDecoration2(context, hint, ""),
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      
    );
  }
  passField(BuildContext context,  TextEditingController controller,String hint) {
    return TextFormField(
      autofocus: true,
      obscureText: true,
      obscuringCharacter: "*",
      autovalidateMode: AutovalidateMode.onUserInteraction,
      //validator: (value) => loginProvider.isEmail(value!)?null:"Please Enter Correct email",
      cursorColor: Colors.grey,
      style: Theme.of(context).textTheme.headline6,
      decoration: AppConstants.toAppInputDecoration2(context, hint, ""),
      controller: controller,
      keyboardType: TextInputType.visiblePassword,
      
    );
  }

}
