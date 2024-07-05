import 'package:cinema_app/components/age_restriction_box.dart';
import 'package:cinema_app/components/showtime_type_box.dart';
import 'package:cinema_app/config.dart';
import 'package:cinema_app/data/models/movie.dart';
import 'package:cinema_app/views/detail/movie_detail.dart';
import 'package:flutter/material.dart';

class InfoMovie extends StatefulWidget {
  const InfoMovie({
    Key? key,
    required this.movie,
  }) : super(key: key);
  final Movie movie;

  @override
  State<InfoMovie> createState() => _InfoMovieState();
}

class _InfoMovieState extends State<InfoMovie> {
 late String name;
   void translate() async {
    List<String> translatedTexts = await Future.wait([
      Styles.translate(name),
    ]);
    name = translatedTexts[0];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    name= widget.movie.name;
    translate();
  }
  @override
  Widget build(BuildContext context) {
    var wImage = (MediaQuery.of(context).size.width - 30) / 2;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MovieDetail(
                    movieID: widget.movie.id,
                    projectionForm: widget.movie.projectionForm,
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
                  image: widget.movie.img.isNotEmpty
                      ? NetworkImage("$serverUrl/Images/${widget.movie.img}")
                      : const AssetImage("assets/img/movie.png") as ImageProvider,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.movie.ageRestrictionName.isNotEmpty
                      ? AgeRestrictionBox(
                          title: widget.movie.ageRestrictionName,
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(
                      width: 2), 
                  ShowtimeTypeBox(
                    title: widget.movie.showTimeTypeName.isNotEmpty
                        ? widget.movie.showTimeTypeName
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
               name,
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
