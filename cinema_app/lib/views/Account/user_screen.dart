import 'package:cinema_app/components/text_policy.dart';
import 'package:cinema_app/config.dart';
import 'package:cinema_app/views/Account/account_screen.dart';
import 'package:cinema_app/views/Account/invoice/history_invoice_screen.dart';
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
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Config.userInfo != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: Image.asset(
                          'assets/img/user.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        Config.userInfo!.fullname,
                        softWrap: true,
                        style: TextStyle(
                            color: Styles.boldTextColor[Config.themeMode],
                            fontSize: Styles.appbarFontSize,
                            fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const UserInfoPage()),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Styles.btnColor[Config.themeMode]!),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.edit_calendar_outlined,
                                  size: Styles.iconSizeInLineText,
                                  color:
                                      Styles.boldTextColor[Config.themeMode]),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                textInfoUser,
                                style: TextStyle(
                                    fontSize: Styles.textSize,
                                    color:
                                        Styles.boldTextColor[Config.themeMode]),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.favorite_border_outlined,
                                    color:
                                        Styles.boldTextColor[Config.themeMode],
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
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HistoryInvoiceScreen()),
                                );
                              },
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.history,
                                    color:
                                        Styles.boldTextColor[Config.themeMode],
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
                          Expanded(
                            child: GestureDetector(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.movie_filter_outlined,
                                    color:
                                        Styles.boldTextColor[Config.themeMode],
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
                        ],
                      ),
                    ],
                  )
                : Column(
                    children: [
                      SizedBox(
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
                                builder: (context) => const AccountScreen()),
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
                          '$textLogin / $textRegister',
                          style: TextStyle(
                            color: Styles.boldTextColor[Config.themeMode],
                            fontSize: Styles.titleFontSize,
                          ),
                        ),
                      )
                    ],
                  ),
            const Divider(),
            TextPolicy(title: "Thông Tin Công Ty"),
            const Divider(),
            TextPolicy(title: "Điều Khoản Sử Dụng"),
            const Divider(),
            TextPolicy(title: "Chính Sách Thanh Toán"),
            const Divider(),
            TextPolicy(title: "Chính Sách Bảo Mật"),
            const Divider(),
            TextPolicy(title: "Hỏi đáp"),
          ],
        ),
      ),
    );
  }
}
