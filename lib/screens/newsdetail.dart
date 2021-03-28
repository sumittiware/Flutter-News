import 'package:NewsApp/Theme/colors.dart';
import 'package:NewsApp/Theme/customtheme.dart';
import 'package:NewsApp/config.dart';
import 'package:NewsApp/services/api_manager.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../Theme/textstyle.dart';

class NewsDetail extends StatelessWidget {
  final int index;
  NewsDetail({this.index});
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final currentNews =
        Provider.of<ApiManager>(context, listen: false).news[index];
    var formattedTime =
        DateFormat('dd MMM - HH:mm').format(currentNews.publishedAt);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "News App",
          style: TextStyle(
              fontSize: 20,
              color: !CustomTheme.isDarkTheme
                  ? AppColor.bgColorDark
                  : AppColor.bgColorLight),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.share_rounded,
              color: !CustomTheme.isDarkTheme
                  ? AppColor.bgColorDark
                  : AppColor.bgColorLight,
            ),
            onPressed: () {
              share(currentNews.url);
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        height: deviceSize.height - kToolbarHeight,
        width: deviceSize.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                currentNews.title,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: !CustomTheme.isDarkTheme
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
                          color: !CustomTheme.isDarkTheme
                              ? AppColor.bgColorDark
                              : AppColor.bgColorLight),
                    ),
                  if (currentNews.author != null)
                    Text(
                      currentNews.author,
                      style: TextStyle(
                          color: !CustomTheme.isDarkTheme
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
                        color: !CustomTheme.isDarkTheme
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
                      color: !CustomTheme.isDarkTheme
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
