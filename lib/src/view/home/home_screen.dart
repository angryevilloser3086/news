import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_reader/src/providers/home_provider.dart';
import 'package:news_reader/src/view/signup/login_screen.dart';
import 'package:provider/provider.dart';

import '../../model/article.dart';
import '../../utils/app_localization.dart';
import '../../utils/app_utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      child: Scaffold(
        backgroundColor: AppConstants.appBgColor,
        appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          automaticallyImplyLeading: false,
          backgroundColor: AppConstants.appPrimaryColor,
          title: InkWell(
            onTap: () => {
              FirebaseAuth.instance.signOut(),
              AppConstants.moveNextstl(context, const LoginScreen())
            },
            child: Padding(
                padding: AppConstants.leftRight_5,
                child: Text(Strings.of(context).appName,
                    style: Theme.of(context).textTheme.headline4)),
          ),
          actions: [
            Consumer<HomeProvider>(builder: (context, homeProvider, child) {
              if (homeProvider.countryCode.isEmpty) {
                homeProvider.fetchConfig();
              }
              return InkWell(
                onTap: () {
                  homeProvider.fetchConfig();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/images/Vector.png",
                      height: 15,
                      width: 15,
                    ),
                    AppConstants.w_5,
                    Text(
                      homeProvider.countryCode.toUpperCase(),
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    AppConstants.w_10
                  ],
                ),
              );
            }),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: AppConstants.all_10,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppConstants.h_10,
                  Text(
                    Strings.of(context).topHeadLines,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  AppConstants.h_10,
                  SingleChildScrollView(
                      physics: const ScrollPhysics(),
                      child: Consumer<HomeProvider>(
                          builder: (context, homeProvider, child) {
                        if (homeProvider.topNews == null) {
                          homeProvider.getTopHeadLine();
                        }
                        if (homeProvider.isLoading) {
                          return Align(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(Strings.of(context).loading,
                                    style:
                                        Theme.of(context).textTheme.headline6),
                                const CircularProgressIndicator(
                                  color: AppConstants.appPrimaryColor,
                                ),
                              ],
                            ),
                          );
                        } else {
                          if (homeProvider.topNews != null) {
                            return ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    homeProvider.topNews!.articles!.length,
                                itemBuilder: ((context, index) {
                                  return newsCard(context,
                                      homeProvider.topNews!.articles![index]);
                                }));
                          } else {
                            return Text(
                              Strings.of(context).noData,
                              style: Theme.of(context).textTheme.headline1,
                            );
                          }
                        }
                      }))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  newsCard(BuildContext context, Article article) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        child: Container(
          height: 156,
          width: 300,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              newsText(
                  context,
                  article.source!.name!,
                  article.content ?? article.description ?? "",
                  article.publishedAt!),
              Container(
                height: 122,
                width: 125,
                decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    color: Colors.white),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: FadeInImage.memoryNetwork(
                    fit: BoxFit.cover,
                    fadeInCurve: Curves.easeInCirc,
                    placeholder: kTransparentImage,
                    image: '${article.urlToImage}',
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.error,
                            color: Colors.black,
                          ),
                          Center(
                            child: Text(
                              'Error loading icon',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          AppConstants.h_10
                        ],
                      ); //do something
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  newsText(BuildContext context, String source, String description,
      String duration) {
    return Padding(
      padding: AppConstants.all_10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppConstants.h_5,
          Text(
            source,
            style: Theme.of(context).textTheme.headline5,
          ),
          Container(
            height: 80,
            width: 250,
            child: Text(description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                )),
          ),
          Text(totalDuration(duration),
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                  color: AppConstants.appFontcolor)),
        ],
      ),
    );
  }

  String totalDuration(String publishedAt) {
    DateTime now = DateTime.now();
    Duration tot = now.difference(DateTime.parse(publishedAt).toLocal());
    String result = '';

    if (tot.inSeconds >= 60) {
      if (tot.inMinutes >= 60) {
        if (tot.inHours >= 24) {
          result = "${tot.inDays.toString()} days ago";
        } else {
          result = "${tot.inHours.toString()} hrs ago";
        }
      } else {
        result = "${tot.inMinutes.toString()} min ago";
      }
    } else {
      result = "${tot.inSeconds.toString()} secs ago";
    }
    return result;
  }
}
