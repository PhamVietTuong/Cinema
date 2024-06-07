
//Slide Show
import 'dart:async';

import 'package:flutter/material.dart';

class SlideShow extends StatefulWidget {
  const SlideShow({super.key});

  @override
  State<SlideShow> createState() => _SlideShowState();
}

class _SlideShowState extends State<SlideShow> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    // Khởi tạo một Timer để tự động chuyển đổi giữa các trang của carousel.
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      // Nếu trang hiện tại nhỏ hơn 2 (chỉ số của trang cuối cùng trong carousel),
      if (_currentPage < 2) {
        // Tăng chỉ số của trang hiện tại lên một đơn vị.
        _currentPage++;
      } else {
        // Nếu trang hiện tại là trang cuối cùng, đặt lại chỉ số của trang hiện tại về 0 (trang đầu tiên).
        _currentPage = 0;
      }
      // Sử dụng _pageController để chuyển đến trang mới được xác định bởi _currentPage.
      _pageController.animateToPage(
        _currentPage, // Chỉ số của trang mới
        duration: const Duration(milliseconds: 500), // Thời gian chuyển đổi
        curve: Curves.ease, // Kiểu chuyển đổi
      );
    });
  }

// Hàm được gọi khi widget bị xóa khỏi cây widget
  @override
  void dispose() {
    // Hủy bỏ Timer để tránh rò rỉ bộ nhớ.
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      onPageChanged: (int page) {
        setState(() {
          _currentPage = page;
        });
      },
      children: [
        Center(
          child: ClipRRect(
            child: Image.asset(
              'assets/img_demo/Banner.png',
            ),
          ),
        ),
        Center(
          child: ClipRRect(
            child: Image.asset(
              'assets/img_demo/Banner.png',
            ),
          ),
        ),
        Center(
          child: ClipRRect(
            child: Image.asset(
              'assets/img_demo/Banner.png',
            ),
          ),
        ),
      ],
    );
  }
}
