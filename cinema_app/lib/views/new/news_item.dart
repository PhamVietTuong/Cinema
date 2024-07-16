import 'package:cinema_app/config.dart';
import 'package:cinema_app/data/models/new.dart';
import 'package:cinema_app/views/new/news_detail.dart';
import 'package:flutter/material.dart';

class NewsItem extends StatefulWidget {
  const NewsItem({super.key, required this.news});
  final News news;

  @override
  State<NewsItem> createState() => _NewsItemState();
}

class _NewsItemState extends State<NewsItem> {
  String textDate = "Ngày tạo";
  late String textTitle;
  bool isLoading = true;

  void translate() async {
    List<String> translateTexts = await Future.wait([
      Styles.translate(textDate),
      Styles.translate(textTitle),
    ]);

    textDate = translateTexts[0];
    textTitle = translateTexts[1];
    setState(() {});

  }

  @override
  void initState() {
    super.initState();
    textTitle = widget.news.title;
    translate();
  }

  @override
  Widget build(BuildContext context) {
    var wS = MediaQuery.of(context).size.width;
    var hS = MediaQuery.of(context).size.height;
    return Container(
      color: Styles.backgroundContent[Config.themeMode],
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      width: wS,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewsDetail(
                      news: widget.news,
                    )),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                fit: BoxFit.contain,
                height: hS * 0.2,
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
              "$textDate: ${Styles.formatDate(widget.news.createAt)}",
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
          ],
        ),
      ),
    );
  }
}
