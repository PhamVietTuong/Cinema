import 'package:cinema_app/config.dart';
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Styles.boldTextColor[Config.themeMode], // Màu bạn muốn
          onPressed: () {
            Navigator.pop(this.context);
          },
        ),
        title: Text(
          "Đăng nhập",
          style: TextStyle(
            fontSize: Styles.appbarFontSize,
            color: Styles.boldTextColor[Config.themeMode],
          ),
        ),
        backgroundColor: Styles.backgroundContent[Config.themeMode],
      ),
      body: Container(
        color: Styles.backgroundColor[Config.themeMode],
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(
                horizontal: Styles.defaultHorizontal),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    labelText: 'Tên đăng nhập',
                    prefixIcon: const Icon(Icons.email),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                   
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    //  borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    labelStyle: const TextStyle( fontSize: Styles.titleFontSize)
                  ),
                  controller: email,
                ),
                const SizedBox(height: 20),
                TextField(
                  decoration:  InputDecoration(
                    filled: true,
                    labelText: 'Mật khẩu',
                    prefixIcon: const Icon(Icons.password),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                     enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      //borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    labelStyle: const TextStyle( fontSize: Styles.titleFontSize)
                   
                  ),
                  obscureText: true,
                  controller: pass,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {},
                        child:  Text("Quên mật khẩu",
                            style: TextStyle(fontSize: Styles.textSize,color: Styles.textColor[Config.themeMode]))),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'Đăng nhập',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      "Người dùng mới!",
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
                      child: const Text(
                        "Đăng ký",
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
