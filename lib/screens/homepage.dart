import 'package:NewsApp/Theme/colors.dart';
import 'package:NewsApp/Theme/config.dart';
import 'package:NewsApp/Theme/customtheme.dart';
import 'package:NewsApp/config.dart';
import 'package:NewsApp/models/newsinfo.dart';
import 'package:NewsApp/widgets/news_templete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import '../Theme/textstyle.dart';
import '../screens/searchscreen.dart';
import '../services/api_manager.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    //print('Homescreen build method!!');
    final deviceSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: deviceSize.height * 0.06,
              width: deviceSize.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('News App',
                      style: TextStyle(
                          fontSize: 20,
                          color: !CustomTheme.isDarkTheme
                              ? AppColor.bgColorDark
                              : AppColor.bgColorLight)),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.search_rounded,
                          size: 30,
                          color: !CustomTheme.isDarkTheme
                              ? AppColor.bgColorDark
                              : AppColor.bgColorLight,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SearchScreen()));
                        },
                      ),
                      IconButton(
                        icon: Icon(
                            (CustomTheme.isDarkTheme)
                                ? Icons.brightness_5
                                : Icons.brightness_3_outlined,
                            size: 30,
                            color: !CustomTheme.isDarkTheme
                                ? AppColor.bgColorDark
                                : AppColor.bgColorLight),
                        onPressed: () {
                          currentTheme.toggleTheme();
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
            Consumer<ApiManager>(
              builder: (context, data, child) {
                return Container(
                  height: deviceSize.height * 0.1,
                  width: deviceSize.width,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Category : ',
                          style: TextStyle(
                              color: !CustomTheme.isDarkTheme
                                  ? AppColor.bgColorDark
                                  : AppColor.bgColorLight,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              textBaseline: TextBaseline.alphabetic),
                        ),
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  data.fetchByCategory(data.category[index]);
                                },
                                child: Container(
                                  margin: EdgeInsets.all(5),
                                  padding: EdgeInsets.all(10),
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        data.category[index],
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 16),
                                      )),
                                  decoration: BoxDecoration(
                                      color: (data.currentCategory ==
                                              data.category[index])
                                          ? Theme.of(context).accentColor
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color:
                                              Theme.of(context).primaryColor)),
                                ),
                              );
                            },
                            itemCount: data.category.length,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            Container(
              height: deviceSize.height * 0.8,
              width: deviceSize.width,
              child: FutureBuilder<List<Article>>(
                  future:
                      Provider.of<ApiManager>(context, listen: false).getNews(),
                  builder: (context, snapshot) {
                    //print('News build method!!!');
                    if (snapshot.hasData && snapshot.data.length != 0) {
                      return Consumer<ApiManager>(
                          builder: (context, data, child) {
                        return ListView.builder(
                          itemCount: data.news.length,
                          itemBuilder: (context, index) {
                            var article = data.news[index];
                            return NewsTemplete(
                              index: index,
                              title: article.title,
                              imageURL: article.urlToImage,
                              publishDate: article.publishedAt,
                              author: article.author,
                              url: article.url,
                            );
                          },
                        );
                      });
                    } else {
                      return Center(
                        child: (snapshot.hasError)
                            ? Text(
                                'OOPS! Someting wrong',
                              )
                            : CircularProgressIndicator(),
                      );
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
