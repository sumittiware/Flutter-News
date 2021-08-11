import 'package:news_app/Theme/colors.dart';
import 'package:news_app/Theme/customtheme.dart';
import 'package:news_app/config.dart';
import 'package:news_app/screens/newsdetail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../config.dart';

class NewsTemplete extends StatefulWidget {
  final int index;
  final String title;
  final String imageURL;
  final DateTime publishDate;
  final String author;
  final String url;
  final bool isFromSearch;
  NewsTemplete(
      {this.index,
      this.title,
      this.imageURL,
      this.publishDate,
      this.author,
      this.url,
      this.isFromSearch = false});
  @override
  _NewsTempleteState createState() => _NewsTempleteState();
}

class _NewsTempleteState extends State<NewsTemplete> {
  @override
  Widget build(BuildContext context) {
    var formattedTime = DateFormat('dd MMM - HH:mm').format(widget.publishDate);
    final theme = Provider.of<CustomTheme>(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final widgetHeight = constraints.maxHeight;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            borderRadius: BorderRadius.circular(8),
            elevation: 2,
            color: Theme.of(context).accentColor,
            shadowColor: Theme.of(context).primaryColor,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => NewsDetail(
                          index: widget.index,
                          isFromSearch: widget.isFromSearch,
                        )));
              },
              child: Container(
                color: Colors.transparent,
                padding: EdgeInsets.all(10),
                height: (widget.imageURL != null)
                    ? widgetHeight * 0.5
                    : widgetHeight * 0.1,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    (widget.imageURL != null)
                        ? Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: AspectRatio(
                                aspectRatio: 2.5,
                                child: Image.network(
                                  widget.imageURL,
                                  fit: BoxFit.cover,
                                )),
                          )
                        : Container(),
                    SizedBox(width: widgetHeight * 0.01),
                    Flexible(
                      child: Text(
                        widget.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: !theme.isDarkTheme
                                ? AppColor.bgColorDark
                                : AppColor.bgColorLight),
                      ),
                    ),
                    Expanded(
                      child: Row(
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
                          if (widget.author != null &&
                              widget.author.length < 20)
                            Text(
                              widget.author,
                              maxLines: 1,
                              style: TextStyle(
                                  color: !theme.isDarkTheme
                                      ? AppColor.bgColorDark
                                      : AppColor.bgColorLight),
                            ),
                          FlatButton.icon(
                            icon: Icon(
                              Icons.share_rounded,
                              color: !theme.isDarkTheme
                                  ? AppColor.bgColorDark
                                  : AppColor.bgColorLight,
                              size: 15,
                            ),
                            label: Text(
                              'SHARE',
                              style: TextStyle(
                                  color: !theme.isDarkTheme
                                      ? AppColor.bgColorDark
                                      : AppColor.bgColorLight,
                                  fontSize: 12),
                            ),
                            onPressed: () => share(widget.url),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
