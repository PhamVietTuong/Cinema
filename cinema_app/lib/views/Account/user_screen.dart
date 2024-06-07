import 'package:cinema_app/config.dart';
import 'package:cinema_app/views/Account/login_screen.dart';
import 'package:cinema_app/views/Account/registration_screen.dart';
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
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("TÀI KHOẢN",
               // Adjust the font size as needed
                ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const SettingsScreen()),
              // );
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
                    const Text(
                      "Đăng Ký Thành Viên",
                    ),
                    const Text(
                      "Nhận Ngay Nhiều Ưu Đãi!",
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
                  child: const Text(
                    "Đăng ký",
                 
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
                  child: const Text(
                    "Đăng nhập",
                   
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
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Thông Tin Công Ty",
                
                  ),
                  Icon(Icons.arrow_forward_ios_rounded,
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
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Điều Khoản Sử Dụng",
                   
                  ),
                  Icon(Icons.arrow_forward_ios_rounded,
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
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Chính Sách Thanh Toán",
                  
                  ),
                  Icon(Icons.arrow_forward_ios_rounded,
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
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Chính Sách Bảo Mật",
                   
                  ),
                  Icon(Icons.arrow_forward_ios_rounded,
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
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hỏi Đáp",
                   
                  ),
                  Icon(Icons.arrow_forward_ios_rounded,
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
