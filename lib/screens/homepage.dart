import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:news_app/Theme/colors.dart';
import 'package:news_app/Theme/customtheme.dart';
import 'package:news_app/widgets/news_templete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import '../screens/searchscreen.dart';
import '../services/api_manager.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiManager newsProvider;
  bool error = false;
  bool loading = true;
  fetchNews() {
    newsProvider.getNews().then((_) {
      setState(() {
        loading = false;
      });
    }).catchError((e) {
      setState(() {
        error = true;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
    });
  }

  @override
  void initState() {
    Future.delayed(Duration(seconds: 1)).then((_) => fetchNews());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<CustomTheme>(context);
    newsProvider = Provider.of<ApiManager>(context);
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
                          color: !theme.isDarkTheme
                              ? AppColor.bgColorDark
                              : AppColor.bgColorLight)),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.search_rounded,
                          size: 30,
                          color: !theme.isDarkTheme
                              ? AppColor.bgColorDark
                              : AppColor.bgColorLight,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SearchScreen()));
                        },
                      ),
                      ThemeSwitcher(
                        clipper: ThemeSwitcherCircleClipper(),
                        builder: (context) {
                          return IconButton(
                            icon: Icon(
                                (theme.isDarkTheme)
                                    ? Icons.brightness_5
                                    : Icons.brightness_3_outlined,
                                size: 30,
                                color: !theme.isDarkTheme
                                    ? AppColor.bgColorDark
                                    : AppColor.bgColorLight),
                            onPressed: () {
                              theme.toggleTheme();
                            },
                          );
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
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
                          color: !theme.isDarkTheme
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
                              newsProvider
                                  .setCategory(newsProvider.category[index]);
                              setState(() {
                                loading = true;
                              });
                              fetchNews();
                            },
                            child: Container(
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.all(10),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    newsProvider.category[index],
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 16),
                                  )),
                              decoration: BoxDecoration(
                                  color: (newsProvider.currentCategory ==
                                          newsProvider.category[index])
                                      ? Theme.of(context).accentColor
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: Theme.of(context).primaryColor)),
                            ),
                          );
                        },
                        itemCount: newsProvider.category.length,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
                height: deviceSize.height * 0.8,
                width: deviceSize.width,
                child: (!loading)
                    ? ListView(
                        children: List.generate(
                            newsProvider.news.length,
                            (index) => NewsTemplete(
                                  title: newsProvider.news[index].title,
                                  author: newsProvider.news[index].author,
                                  imageURL: newsProvider.news[index].urlToImage,
                                  publishDate:
                                      newsProvider.news[index].publishedAt,
                                  index: index,
                                  url: newsProvider.news[index].url,
                                )),
                      )
                    : ((error)
                        ? Center(
                            child: Text("Error occured"),
                          )
                        : Center(child: CircularProgressIndicator())))
          ],
        ),
      ),
    );
  }
}
