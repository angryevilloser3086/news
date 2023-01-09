import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_reader/src/utils/app_utils.dart';
import 'package:provider/provider.dart';

import 'providers/login_providers.dart';
import 'view/welcome_screen.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      foregroundColor: AppConstants.appPrimaryColor,
      minimumSize: const Size(88, 36),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
      ),
    );
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: Colors.amberAccent,
      backgroundColor: AppConstants.appPrimaryColor,
      // shadowColor: AppConstants.appBgColor,
      textStyle:
          GoogleFonts.poppins(textStyle: textTheme.button, color: Colors.black),
      fixedSize: const Size(250, 54),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider())
      ],
      child: MaterialApp(
        theme: ThemeData(
         
          unselectedWidgetColor: Colors.white,
          
          textButtonTheme: TextButtonThemeData(style: flatButtonStyle),
          elevatedButtonTheme:
              ElevatedButtonThemeData(style: raisedButtonStyle),
          textTheme: GoogleFonts.interTextTheme(textTheme).copyWith(
              headline1: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppConstants.appPrimaryColor),
              headline2: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
              headline3: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
              headline4: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
              headline5: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
              headline6: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
              caption: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
              bodyText1: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
              bodyText2: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
              button: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
              subtitle1: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppConstants.appPrimaryColor)),
          buttonTheme: const ButtonThemeData(
              shape: RoundedRectangleBorder(),
              buttonColor: AppConstants.appPrimaryColor),
          // outlinedButtonTheme: OutlinedButtonThemeData(
          //     style: OutlinedButton.styleFrom(
          //       shape: const RoundedRectangleBorder(),
          //       primary: const Color(0xFFF7BB0E),
          //     ),
          //   ),
        ),
        debugShowCheckedModeBanner: false,
        restorationScopeId: 'app',
        // Provide the generated AppLocalizations to the MaterialApp. This
        // allows descendant Widgets to display the correct translations
        // depending on the user's locale.
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
       
        supportedLocales: const [
          Locale('en', ''), // English, no country code
        ],

        // Use AppLocalizations to configure the correct application title
        // depending on the user's locale.
        //
        // The appTitle is defined in .arb files found in the localization
        // directory.
        onGenerateTitle: (BuildContext context) =>
            AppLocalizations.of(context)!.appTitle,
        home: const WelcomeScreen(),
        builder: (context, child) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child!);
        },
      ),
    );
  }
}
