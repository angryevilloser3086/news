import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_reader/src/providers/home_provider.dart';
import 'package:news_reader/src/view/signup/signup_screen.dart';
import 'package:provider/provider.dart';

import '../../model/article.dart';
import '../../model/news_headline.dart';
import '../../utils/app_localization.dart';
import '../../utils/app_utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      child: Scaffold(
        backgroundColor:AppConstants.appBgColor,
        appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          automaticallyImplyLeading: false,
          backgroundColor: AppConstants.appPrimaryColor,
          title: Padding(
              padding: AppConstants.leftRight_5,
              child: Text(Strings.of(context).appName,
                  style: Theme.of(context).textTheme.headline4)),
          actions: const [Icon(Icons.play_arrow)],
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
                        if (homeProvider.topNews != null) {
                          return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: homeProvider.topNews!.articles!.length,
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
                      }))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Card newsCard(BuildContext context, Article article) {
    return Card(
      elevation: 0,
      
      color: Colors.white,
      child: Container(
        height: 156,
        width: 356,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            newsText(context, article.source!.name!, article.content ?? "",
                article.publishedAt!),
            Container(
              height: 119,
              width: 119,
              padding: AppConstants.all_5,
              decoration:
                  const BoxDecoration(borderRadius: AppConstants.boxRadius15),
              child: FadeInImage.memoryNetwork(
                height: 119,
                width: 119,
                fit: BoxFit.cover,
                placeholder: kTransparentImage,
                image: '${article.urlToImage}',
                imageErrorBuilder: (context, error, stackTrace) {
                  return Column(
                    children: const [
                      Icon(
                        Icons.error,
                        color: Colors.white,
                      ),
                      Center(
                        child: Text(
                          'Error loading icon',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      AppConstants.h_10
                    ],
                  ); //do something
                },
              ),
            ),
          ],
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
            padding: AppConstants.all_5,
            height: 80,
            width: 250,
            child: Text(description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
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
