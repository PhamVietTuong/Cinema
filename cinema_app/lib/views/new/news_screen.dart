import 'package:cinema_app/config.dart';
import 'package:cinema_app/data/models/new.dart';
import 'package:cinema_app/presenters/new_presenter.dart';
import 'package:cinema_app/views/new/news_item.dart';
import 'package:flutter/material.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}


class _NewsScreenState extends State<NewsScreen> implements NewViewContract {
late  NewPresenter newPresenter;
  List<News> lstNew = [];
    String titleAppBar = "Tin tức";
  bool isLoading = true;

  void translate() async {
    List<String> translateTexts = await Future.wait([
      Styles.translate(titleAppBar),
    ]);

    titleAppBar = translateTexts[0];
    setState(() {});

  }

  @override
  void initState() {
    super.initState();
    newPresenter = NewPresenter(this);
    newPresenter.fetchNew();
    translate();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text(
          titleAppBar,
          style: TextStyle(
            fontSize: Styles.appbarFontSize,
            color: Styles.boldTextColor[Config.themeMode],
          ),
        ),
        backgroundColor: Styles.backgroundContent[Config.themeMode],
      ),
        backgroundColor: Styles.backgroundColor[Config.themeMode],

      body: isLoading // Hiển thị vòng xoay nếu đang tải dữ liệu
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Styles.boldTextColor[Config.themeMode] ?? Colors.blue),
              ),
            ): Container(
        margin: const EdgeInsets.symmetric(horizontal: Styles.defaultHorizontal,vertical: 10),
        child: SingleChildScrollView(
      child: Column(
        children: lstNew.map((e) => NewsItem(news: e)).toList(),
      ),
    )) ,
    );
    
  }

  @override
  void onLoadError() {
    
  }

  @override
  void onLoadNewComplete(List<News> News) {
    setState(() {
      
    lstNew = News;

    });
    isLoading=false;

  }
}
