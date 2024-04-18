import 'package:cinema_app/style.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var styles=Styles();
  var email=TextEditingController();
  var pass =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.all(2),
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Image.asset(
              'assets/img/User.JPG',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: const Text("Hi, Nhu Y!",
            style: TextStyle(fontSize: 20, color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 7, 13, 45),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
              color: Colors.white),
        ],
      ),
      body: Column(
        children: [
          Row
          (
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Đăng nhập",style: styles.titleTextStyle.copyWith(color: Colors.grey,fontSize: 24),),
            ],
          ),
          const Text("Đăng nhập bằng email của bạn !",style: TextStyle(fontSize: 16),),
          Container(
            padding: EdgeInsets.all(30),

          
            child:  TextField(
            decoration: InputDecoration
            (
              hintText: "Nhập email của bạn vào đây",
              hintStyle: TextStyle(color: Colors.grey),
              
            ),
            controller:email ,
          ),
          )
         
        ],
      ),
    );
  }
}