import 'package:cinema_app/config.dart';
import 'package:cinema_app/views/Account/account_screen.dart';
import 'package:cinema_app/views/Account/setting_screen.dart';
import 'package:cinema_app/views/Account/user_info_page.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key, required this.refresh});
  final Function() refresh;

  @override
  State<UserScreen> createState() => _UserState();
}

class _UserState extends State<UserScreen> {
  double _currentRanking = 0.0;

  String textAppBar = "Thành viên";
  String textInfoUser = "Thông tin người dùng";
  String textTransactionHistory = "Lịch sử giao dịch";
  String textMovie = "Danh sách phim";
  String textFavorite = "Phim yêu thích";
  String textLogin = "Đăng nhập";
  String textRegister = "Đăng ký";
  String textRank = "Điểm thành viên";

  void tranlate() async {
    List<String> textTranlate = await Future.wait([
      Styles.translate(textAppBar),
      Styles.translate(textInfoUser),
      Styles.translate(textTransactionHistory),
      Styles.translate(textMovie),
      Styles.translate(textFavorite),
      Styles.translate(textLogin),
      Styles.translate(textRank),
      Styles.translate(textRegister),
    ]);
    textAppBar = textTranlate[0];
    textInfoUser = textTranlate[1];
    textTransactionHistory = textTranlate[2];
    textMovie = textTranlate[3];
    textFavorite = textTranlate[4];
    textLogin = textTranlate[5];
    textRank = textTranlate[6];
    textRegister = textTranlate[7];
    setState(() {});
  }

  void refresh() {
    widget.refresh();
    tranlate();
  }

  @override
  void initState() {
    super.initState();
    tranlate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.backgroundContent[Config.themeMode],
        title: Text(
          textAppBar,
          style: TextStyle(
              color: Styles.boldTextColor[Config.themeMode],
              fontSize: Styles.appbarFontSize),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            color: Styles.boldTextColor[Config.themeMode],
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SettingsScreen(
                          refresh: refresh,
                        )),
              );
            },
          ),
        ],
      ),
      backgroundColor: Styles.backgroundColor[Config.themeMode],
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Config.userInfo != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: Image.asset(
                              'assets/img/user.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Config.userInfo!.fullname,
                                style: TextStyle(
                                  color: Styles.boldTextColor[Config.themeMode],
                                  fontSize: Styles.titleFontSize,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UserInfoPage(
                                              infoUser: Config.userInfo!,
                                            )),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.edit_note_outlined,
                                        color: Styles
                                            .boldTextColor[Config.themeMode],
                                        size: Styles.iconSizeInLineText,
                                      ),
                                      Text(
                                        textInfoUser,
                                        style: TextStyle(
                                            color: Styles.boldTextColor[
                                                Config.themeMode],
                                            fontSize: Styles.textSize),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.favorite_border_outlined,
                                      color: Styles
                                          .boldTextColor[Config.themeMode],
                                      size: Styles.iconSizeInTitle,
                                    ),
                                    Text(
                                      textFavorite,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Styles
                                              .boldTextColor[Config.themeMode],
                                          fontSize: Styles.textSize),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.history,
                                      color: Styles
                                          .boldTextColor[Config.themeMode],
                                      size: Styles.iconSizeInTitle,
                                    ),
                                    Text(
                                      textTransactionHistory,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Styles
                                              .boldTextColor[Config.themeMode],
                                          fontSize: Styles.textSize),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.movie_filter_outlined,
                                      color: Styles
                                          .boldTextColor[Config.themeMode],
                                      size: Styles.iconSizeInTitle,
                                    ),
                                    Text(
                                      textMovie,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Styles
                                              .boldTextColor[Config.themeMode],
                                          fontSize: Styles.textSize),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        textRank,
                        style: TextStyle(
                            fontSize: Styles.titleFontSize,
                            color: Styles.boldTextColor[Config.themeMode]),
                      ),
                      Slider(
                        value: _currentRanking,
                        min: 0,
                        max: 100,
                        divisions: 100,
                        label: _currentRanking.round().toString(),
                        onChanged: (double value) {
                          setState(() {
                            _currentRanking = value;
                          });
                        },
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: Image.asset(
                          'assets/img/user.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AccountScreen()),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: Styles.boldTextColor[
                                Config.themeMode]!, // Màu của đường viền
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(5), // Độ cong của góc
                          ),
                        ),
                        child: Text(
                          '${textLogin} / ${textRegister}',
                          style: TextStyle(
                            color: Styles.boldTextColor[Config.themeMode],
                            fontSize: Styles.titleFontSize,
                          ),
                        ),
                      )
                    ],
                  ),
            Container(
              height: 2,
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              color: const Color.fromARGB(255, 211, 211, 211),
            ),
            TextButton(
              onPressed: () {},
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Thông Tin Công Ty",
                  ),
                  Icon(Icons.arrow_forward_ios_rounded, color: Colors.black54),
                ],
              ),
            ),
            Container(
              height: 2,
              color: const Color.fromARGB(255, 211, 211, 211),
            ),
            TextButton(
              onPressed: () {},
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Điều Khoản Sử Dụng",
                  ),
                  Icon(Icons.arrow_forward_ios_rounded, color: Colors.black54),
                ],
              ),
            ),
            Container(
              height: 2,
              color: const Color.fromARGB(255, 211, 211, 211),
            ),
            TextButton(
              onPressed: () {},
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Chính Sách Thanh Toán",
                  ),
                  Icon(Icons.arrow_forward_ios_rounded, color: Colors.black54),
                ],
              ),
            ),
            Container(
              height: 2,
              color: const Color.fromARGB(255, 211, 211, 211),
            ),
            TextButton(
              onPressed: () {},
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Chính Sách Bảo Mật",
                  ),
                  Icon(Icons.arrow_forward_ios_rounded, color: Colors.black54),
                ],
              ),
            ),
            Container(
              height: 2,
              color: const Color.fromARGB(255, 211, 211, 211),
            ),
            TextButton(
              onPressed: () {},
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hỏi Đáp",
                  ),
                  Icon(Icons.arrow_forward_ios_rounded, color: Colors.black54),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
