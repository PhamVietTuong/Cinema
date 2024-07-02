import 'package:cinema_app/components/age_restriction_box.dart';
import 'package:cinema_app/components/showtime_type_box.dart';
import 'package:cinema_app/config.dart';
import 'package:cinema_app/data/models/movie.dart';
import 'package:cinema_app/views/detail/movie_detail.dart';
import 'package:flutter/material.dart';

class InfoMovie extends StatelessWidget {
  const InfoMovie({
    Key? key,
    required this.movie,
  }) : super(key: key);
  final Movie movie;
  @override
  Widget build(BuildContext context) {
    var wImage = (MediaQuery.of(context).size.width - 30) / 2;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MovieDetail(
                    movieID: movie.id,
                    projectionForm: movie.projectionForm,
                  )),
        );
      },
      child: SizedBox(
        width: wImage,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: wImage,
              height: wImage / 0.57,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: movie.img.isNotEmpty
                      ? NetworkImage("$serverUrl/Images/${movie.img}")
                      : const AssetImage("assets/img/movie.png") as ImageProvider,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Widget cho hộp giới hạn tuổi
                  movie.ageRestrictionName.isNotEmpty
                      ? AgeRestrictionBox(
                          title: movie.ageRestrictionName,
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(
                      width: 2), // Khoảng cách giữa các widget trong Row
                  // Widget cho loại suất chiếu
                  ShowtimeTypeBox(
                    title: movie.showTimeTypeName.isNotEmpty
                        ? movie.showTimeTypeName
                        : "",
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              constraints: BoxConstraints(maxWidth: wImage * 0.9),
              child: Text(
                movie.name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Styles.boldTextColor[Config.themeMode],
                  fontSize: Styles.titleFontSize,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
