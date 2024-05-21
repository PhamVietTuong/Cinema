import 'package:cinema_app/constants.dart';
import 'package:cinema_app/views/Account/registration_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var styles = Styles();
  var email = TextEditingController();
  var pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Đăng nhập",
              style: styles.titleTextStyle.copyWith(fontSize: 20),
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                filled: true,
                labelText: 'Email đăng nhập',
                prefixIcon: const Icon(Icons.email),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
              ),
              controller: email,
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                filled: true,
                labelText: 'Mật khẩu',
                prefixIcon: const Icon(Icons.password),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
              ),
              obscureText: true,
              controller: pass,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {},
                    child: const Text("Quên mật khẩu",
                        style: TextStyle(fontSize: 16))),
              ],
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                'Đăng nhập',
                style: styles.titleTextStyle.copyWith(fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Người dùng mới!",
                  style: styles.titleTextStyle
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  width: 10,
                ),
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
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
