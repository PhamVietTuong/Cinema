import 'package:cinema_app/config.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ActorList extends StatefulWidget {
  final String actors;

  const ActorList({super.key, required this.actors});

  @override
  _ActorListState createState() => _ActorListState();
}

class _ActorListState extends State<ActorList> {
  bool isExpanded2 = false;

  @override
  Widget build(BuildContext context) {
    List<String> actorList =
        widget.actors.split(', '); // Tách danh sách các diễn viên bằng dấu phẩy
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 10.0,
          runSpacing: 4.0,
          children: [
            for (int i = 0; i < actorList.length; i++)
              GestureDetector(
                onTap: () {
                  _launchActorWikipedia(actorList[i].trim());
                },
                child: Column(
                  mainAxisSize: MainAxisSize
                      .min,
                  children: [
                    Icon(
                      Icons.account_circle,
                      color: Styles.textColor[Config.themeMode],
                      size: 50,
                    ),
                    Text(
                      '${actorList[i]}',
                      style: TextStyle(
                        color: Styles.textColor[Config.themeMode],
                        fontSize: Styles.textSize,
                      ),
                      softWrap: true,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }
  void _launchActorWikipedia(String actorName) {
    try {
      String searchQuery = Uri.encodeFull(actorName);
      String url =
          'https://vi.wikipedia.org/wiki/$searchQuery'; // Đường dẫn đến Wikipedia

      Uri uri = Uri.parse(url); // Chuyển đổi chuỗi URL thành đối tượng Uri
      launchUrl(uri); // Sử dụng đối tượng Uri khi gọi phương thức launchUrl
    } catch (e) {
      // In ra lỗi nếu không mở được URL
      // print('Error launching URL: $e');
    }
  }
}
