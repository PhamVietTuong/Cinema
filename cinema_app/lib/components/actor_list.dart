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
    List<String> actorList = widget.actors.split(', '); // Tách danh sách các diễn viên bằng dấu phẩy
    int displayCount = isExpanded2 ? actorList.length : (actorList.length > 3 ? 3 : actorList.length); // Hiển thị 3 diễn viên nếu không mở rộng

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 5.0, // Khoảng cách giữa các diễn viên
          runSpacing: 4.0, // Khoảng cách giữa các dòng
          children: [
            for (int i = 0; i < displayCount; i++)
              GestureDetector(
                onTap: () {
                  _launchActorWikipedia(actorList[i].trim()); // Mở Wikipedia cho diễn viên được nhấn vào
                },
                child: Text(
                  '${actorList[i]}, '
                  , // Hiển thị tên diễn viên
                  style: TextStyle(
                    color: Styles.textColor["dark_purple"],
                    fontSize: Styles.textSize,
                  ),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
        ),
        if (actorList.length > 3)
          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded2 = !isExpanded2;
              });
            },
            child: Text(
              isExpanded2 ? 'Thu gọn' : 'Xem thêm',
              style: TextStyle(
                color: Styles.textColor["dark_purple"],
                fontSize: Styles.textSize,
              ),
            ),
          ),
      ],
    );
  }

  void _launchActorWikipedia(String actorName)  {
    try {
      String searchQuery = Uri.encodeFull(actorName);
      String url = 'https://vi.wikipedia.org/wiki/$searchQuery'; // Đường dẫn đến Wikipedia

      Uri uri = Uri.parse(url); // Chuyển đổi chuỗi URL thành đối tượng Uri
      launchUrl(uri); // Sử dụng đối tượng Uri khi gọi phương thức launchUrl
    } catch (e) {
      // In ra lỗi nếu không mở được URL
      print('Error launching URL: $e');
    }
  }
}
