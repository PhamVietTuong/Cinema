import 'package:cinema_app/config.dart';
import 'package:cinema_app/data/models/new.dart';
import 'package:flutter/material.dart';

class NewsDetail extends StatefulWidget {
  const NewsDetail({super.key, required this.news});
  final News news;

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  String titleAppBar = "Chi tiết tin tức";
  String textDate = "Ngày tạo";
  late String textTitle;
  late String textContent;
  bool isLoading = true; // Biến trạng thái để theo dõi quá trình tải dữ liệu

  void translate() async {
    List<String> translateTexts = await Future.wait([
      Styles.translate(titleAppBar),
      Styles.translate(textDate),
      Styles.translate(textTitle),
      Styles.translate(textContent),
    ]);

    titleAppBar = translateTexts[0];
    textDate = translateTexts[1];
    textTitle = translateTexts[2];
    textContent = translateTexts[3];
    setState(() {
    });
      isLoading = false;

  }

  @override
  void initState() {
    super.initState();
    textTitle = widget.news.title;
    textContent = widget.news.content;
    translate();
  }

  @override
  Widget build(BuildContext context) {
    var wS = MediaQuery.of(context).size.width;
    var hS = MediaQuery.of(context).size.height;
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Styles.boldTextColor[Config.themeMode],
          onPressed: () {
            Navigator.pop(this.context);
          },
        ),
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
            )
          : Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: Styles.defaultHorizontal, vertical: 10),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      fit: BoxFit.contain,
                      height: hS * 0.3,
                      width: wS,
                      image: widget.news.image.isEmpty
                          ? const AssetImage('assets/img/news.png') as ImageProvider
                          : NetworkImage('$serverUrl/Images/${widget.news.image}'),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    " $textDate: ${Styles.formatDate(widget.news.createAt)}",
                    style: TextStyle(
                      fontSize: Styles.titleFontSize,
                      color: Styles.boldTextColor[Config.themeMode],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    textTitle,
                    style: TextStyle(
                      fontSize: Styles.titleFontSize,
                      color: Styles.boldTextColor[Config.themeMode],
                    ),
                  ),
                  Text(
                    textContent,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: Styles.titleFontSize,
                      color: Styles.boldTextColor[Config.themeMode],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
