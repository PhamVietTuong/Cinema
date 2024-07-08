import 'package:cinema_app/config.dart';
import 'package:flutter/material.dart';

class InfoBar extends StatefulWidget {
  const InfoBar(
      {super.key,
      required this.title,
      this.value = "",
      this.img = "",
      this.titleMinWith = 0.0,
      this.botBorderW = 2.0});
  final String title;
  final String value;
  final String img;
  final double titleMinWith;
  final double botBorderW;

  @override
  State<InfoBar> createState() => _InfoBarState();
}

class _InfoBarState extends State<InfoBar> {
  late String textTitle;
  void tranlate() async {
    List<String> textTranlate = await Future.wait([
      Styles.translate(textTitle),
    ]);
    textTitle = textTranlate[0];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    textTitle = widget.title;
    tranlate();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 30,
      padding: EdgeInsets.only(bottom: widget.botBorderW),
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.bottomLeft,
            colors: [
              Styles.gradientTop[Config.themeMode]!,
              Styles.gradientBot[Config.themeMode]!,
            ]),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration:
            BoxDecoration(color: Styles.backgroundColor[Config.themeMode]),
        child: Row(
          mainAxisAlignment: (widget.titleMinWith != 0.0)
              ? MainAxisAlignment.start
              : MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                widget.img != ""
                    ? Container(
                        margin: const EdgeInsets.only(right: 5),
                        width: 30,
                        child: Image(
                            image: NetworkImage(
                                '$serverUrl/Images/${widget.img}')))
                    : const SizedBox(),
                Container(
                  constraints: BoxConstraints(minWidth: widget.titleMinWith),
                  child: Text(
                    textTitle,
                    style: TextStyle(
                        fontSize: Styles.titleFontSize,
                        fontWeight: FontWeight.bold,
                        color: Styles.boldTextColor[Config.themeMode]),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              flex: (widget.titleMinWith != 0.0) ? 1 : 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.value,
                    style: TextStyle(
                        fontSize: Styles.titleFontSize,
                        fontWeight: FontWeight.bold,
                        color: Styles.boldTextColor[Config.themeMode]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
