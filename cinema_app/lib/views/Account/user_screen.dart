import 'package:cinema_app/constants.dart';
import 'package:cinema_app/views/Account/login_screen.dart';
import 'package:cinema_app/views/Account/registration_screen.dart';
import 'package:cinema_app/views/Account/setting_screen.dart';
import 'package:flutter/material.dart';

class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  var styles = Styles();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("TÀI KHOẢN",
                style: styles.titleTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight:
                        FontWeight.w700) // Adjust the font size as needed
                ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/img_demo/group.png',
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.height / 5,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      "Đăng Ký Thành Viên",
                      style: styles.titleTextStyle.copyWith(fontSize: 20),
                    ),
                    Text(
                      "Nhận Ngay Nhiều Ưu Đãi!",
                      style: styles.titleTextStyle.copyWith(fontSize: 20),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {
                     Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegistrationScreen()),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text(
                    "Đăng ký",
                    style: styles.titleTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    backgroundColor: Colors.grey,
                  ),
                  child: Text(
                    "Đăng nhập",
                    style: styles.titleTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 5,
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              color: const Color.fromARGB(255, 211, 211, 211),
            ),
            TextButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Thông Tin Công Ty",
                    style: styles.titleTextStyle
                        .copyWith(fontSize: 18, color: Colors.black54),
                  ),
                  const Icon(Icons.arrow_forward_ios_rounded,
                      color: Colors.black54),
                ],
              ),
            ),
            Container(
              height: 2,
              color: const Color.fromARGB(255, 211, 211, 211),
            ),
            TextButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Điều Khoản Sử Dụng",
                    style: styles.titleTextStyle
                        .copyWith(fontSize: 18, color: Colors.black54),
                  ),
                  const Icon(Icons.arrow_forward_ios_rounded,
                      color: Colors.black54),
                ],
              ),
            ),
            Container(
              height: 2,
              color: const Color.fromARGB(255, 211, 211, 211),
            ),
            TextButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Chính Sách Thanh Toán",
                    style: styles.titleTextStyle
                        .copyWith(fontSize: 18, color: Colors.black54),
                  ),
                  const Icon(Icons.arrow_forward_ios_rounded,
                      color: Colors.black54),
                ],
              ),
            ),
            Container(
              height: 2,
              color: const Color.fromARGB(255, 211, 211, 211),
            ),
            TextButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Chính Sách Bảo Mật",
                    style: styles.titleTextStyle
                        .copyWith(fontSize: 18, color: Colors.black54),
                  ),
                  const Icon(Icons.arrow_forward_ios_rounded,
                      color: Colors.black54),
                ],
              ),
            ),
            Container(
              height: 2,
              color: const Color.fromARGB(255, 211, 211, 211),
            ),
            TextButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hỏi Đáp",
                    style: styles.titleTextStyle
                        .copyWith(fontSize: 18, color: Colors.black54),
                  ),
                  const Icon(Icons.arrow_forward_ios_rounded,
                      color: Colors.black54),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
