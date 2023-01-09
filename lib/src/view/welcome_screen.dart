import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_reader/src/providers/login_providers.dart';
import 'package:news_reader/src/utils/app_localization.dart';
import 'package:news_reader/src/utils/app_utils.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginProvider(),
      child: Scaffold(
        backgroundColor: AppConstants.appPrimaryColor,
        body: SafeArea(child: Consumer<LoginProvider>(
          builder: (context, value, child) {
            
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(onTap: () => value.auth(context),
                  child: Center(
                    child: Text(
                      Strings.of(context).appName,
                      style: GoogleFonts.poppins(
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            );
          },
        )),
      ),
    );
  }
}
