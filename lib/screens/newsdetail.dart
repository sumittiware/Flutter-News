import 'package:news_app/Theme/colors.dart';
import 'package:news_app/Theme/customtheme.dart';
import 'package:news_app/config.dart';
import 'package:news_app/services/api_manager.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NewsDetail extends StatelessWidget {
  final int index;
  final bool isFromSearch;
  NewsDetail({this.index, this.isFromSearch = false});
  @override
  Widget build(BuildContext context) {
    print("Current index" + index.toString());
    print("Is form : " + isFromSearch.toString());
    final deviceSize = MediaQuery.of(context).size;
    final currentNews = (isFromSearch)
        ? Provider.of<ApiManager>(context, listen: false).searchedNews[index]
        : Provider.of<ApiManager>(context, listen: false).news[index];

    print("Current : " + currentNews.toString());

    var formattedTime =
        DateFormat('dd MMM - HH:mm').format(currentNews.publishedAt);
    final theme = Provider.of<CustomTheme>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryLight,
        title: Text(
          "News App",
          style: TextStyle(fontSize: 20, color: AppColor.bgColorLight),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.share_rounded,
              color: AppColor.bgColorLight,
            ),
            onPressed: () {
              share(currentNews.url);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                currentNews.title,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: !theme.isDarkTheme
                        ? AppColor.bgColorDark
                        : AppColor.bgColorLight),
              ),
              SizedBox(
                height: deviceSize.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (formattedTime != null)
                    Text(
                      formattedTime,
                      style: TextStyle(
                          color: !theme.isDarkTheme
                              ? AppColor.bgColorDark
                              : AppColor.bgColorLight),
                    ),
                  if (currentNews.author != null)
                    Text(
                      currentNews.author,
                      style: TextStyle(
                          color: !theme.isDarkTheme
                              ? AppColor.bgColorDark
                              : AppColor.bgColorLight),
                    )
                ],
              ),
              SizedBox(
                height: deviceSize.height * 0.01,
              ),
              if (currentNews.urlToImage != null)
                Container(
                  height: deviceSize.height * 0.3,
                  width: double.infinity,
                  child: Image.network(
                    currentNews.urlToImage,
                    fit: BoxFit.contain,
                  ),
                ),
              SizedBox(
                height: deviceSize.height * 0.01,
              ),
              if (currentNews.source.name != null)
                Text("Source : " + currentNews.source.name,
                    style: TextStyle(
                        fontSize: 16,
                        color: !theme.isDarkTheme
                            ? AppColor.bgColorDark
                            : AppColor.bgColorLight)),
              SizedBox(
                height: deviceSize.height * 0.01,
              ),
              if (currentNews.description != null)
                Text(
                  currentNews.description,
                  style: TextStyle(
                      fontSize: 18,
                      color: !theme.isDarkTheme
                          ? AppColor.bgColorDark
                          : AppColor.bgColorLight),
                )
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        height: 50,
        width: double.infinity,
        child: RaisedButton(
          child: Text('Know more...'),
          onPressed: () {
            launchInWebViewOrVC(currentNews.url);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
