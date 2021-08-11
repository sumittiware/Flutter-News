import 'package:news_app/Theme/colors.dart';
import 'package:news_app/Theme/customtheme.dart';
import 'package:news_app/services/api_manager.dart';
import 'package:news_app/widgets/news_templete.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var _isSearched = false;
  final searchController = TextEditingController();
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final theme = Provider.of<CustomTheme>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
              color: !theme.isDarkTheme
                  ? AppColor.bgColorDark
                  : AppColor.bgColorLight),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          title: TextField(
            controller: searchController,
            decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(
                    color: !theme.isDarkTheme
                        ? AppColor.bgColorDark
                        : AppColor.bgColorLight),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    searchController.clear();
                  },
                )),
            onSubmitted: (value) {
              setState(() {
                _isSearched = true;
              });
            },
          ),
        ),
        body: Container(
          height: deviceSize.height - kToolbarHeight,
          width: deviceSize.width,
          child: (_isSearched)
              ? FutureBuilder(
                  future: Provider.of<ApiManager>(context, listen: false)
                      .fetchByKeyWord(searchController.text
                          .toLowerCase()
                          .trimLeft()
                          .trimRight()),
                  builder: (context, snapshot) {
                    return (snapshot.connectionState == ConnectionState.waiting)
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : (snapshot.hasError || snapshot.data == null)
                            ? Center(
                                child: Text(
                                  'Something went wrong!!',
                                  style: TextStyle(
                                      color: !theme.isDarkTheme
                                          ? AppColor.bgColorDark
                                          : AppColor.bgColorLight),
                                ),
                              )
                            : (snapshot.data.length == 0)
                                ? Center(
                                    child: Text('No result found!!',
                                        style: TextStyle(
                                            color: !theme.isDarkTheme
                                                ? AppColor.bgColorDark
                                                : AppColor.bgColorLight)),
                                  )
                                : ListView.builder(
                                    itemBuilder: (context, index) {
                                      var article = snapshot.data[index];
                                      return SizedBox(
                                        height: 240,
                                        width: double.infinity,
                                        child: NewsTemplete(
                                          index: index,
                                          title: article.title,
                                          imageURL: article.urlToImage,
                                          publishDate: article.publishedAt,
                                          author: article.author,
                                          url: article.url,
                                          isFromSearch: true,
                                        ),
                                      );
                                    },
                                    itemCount: snapshot.data.length);
                  })
              : Center(
                  child: Text('Search using keywords',
                      style: TextStyle(
                          color: !theme.isDarkTheme
                              ? AppColor.bgColorDark
                              : AppColor.bgColorLight)),
                ),
        ),
      ),
    );
  }
}
