import 'package:cinema_app/config.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieTypeBox extends StatelessWidget {
  const MovieTypeBox({
    super.key,
    this.maxBoxWith = 0.0,
    this.marginBottom = 0.0,
    this.padding = 0.0,
    this.marginTop = 0.0,
    required this.title,
  });
  final String title;
  final double maxBoxWith;
  final double marginTop;
  final double marginBottom;
  final double padding;

  @override
  Widget build(BuildContext context) {
    List<String> genres = title.split(', ');

    return Container(
      margin: EdgeInsets.only(top: marginTop, bottom: marginBottom),
      constraints: maxBoxWith != 0.0
          ? BoxConstraints(maxWidth: maxBoxWith)
          : const BoxConstraints(),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3.0),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Styles.gradientTop[Config.themeMode]!,
            Styles.gradientBot[Config.themeMode]!
          ],
        ),
      ),
      child: Container(
        margin: const EdgeInsets.all(2),
                padding: EdgeInsets.all(padding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.0),
                  color: Styles.backgroundContent[Config.themeMode],
                ),
        child: Wrap(
          spacing: 8.0,
          children: genres.map((genre) {
            return GestureDetector(
              onTap: () {
                _launchGenreWikipedia(genre.trim());
              },
              child: Text(
                '${genre},',
                style: TextStyle(color: Styles.boldTextColor[Config.themeMode]),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _launchGenreWikipedia(String genre) {
    try {
      String searchQuery = Uri.encodeFull(genre);
      String url =
          'https://vi.wikipedia.org/wiki/Phim_$searchQuery'; // Đường dẫn đến Wikipedia

      Uri uri = Uri.parse(url); // Chuyển đổi chuỗi URL thành đối tượng Uri
      launchUrl(uri);
    } catch (e) {
      print('Error launching URL: $e');
    }
  }
}
