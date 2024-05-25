import 'dart:async';
import 'package:cinema_app/components/age_restriction_box.dart';
import 'package:cinema_app/components/movie_type_box.dart';
import 'package:cinema_app/components/showtime_type_box.dart';
import 'package:cinema_app/constants.dart';
import 'package:cinema_app/views/detail/movie_detail.dart';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var styles = Styles();

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
              'assets/img_demo/User.JPG',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: const Text("Hi, Nhu Y!",
            style: TextStyle(fontSize: 20, color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 102, 51, 153),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
              color: Colors.white),
        ],
      ),
      body: SingleChildScrollView(child: Column(children: [
      Container(
            padding: const EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/3, //chiếm 2 phần trên màn hình
            decoration: const BoxDecoration(
             color: Color.fromARGB(255, 102, 51, 153),
            ),
            child: const MyCarousel(),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height , //chiếm 4 phần
                       decoration: const BoxDecoration(
             color: Color.fromARGB(255, 102, 51, 153),
            ),
            child: const MySecondCarousel(),
          ),
          Text("Phim sắp chiếu",style: styles.titleTextStyle.copyWith(fontSize: 20),),
             Container(
            padding: const EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/2,
            child:  const CarouselThird(),
          ),
          Text("Ưu đãi",style: styles.titleTextStyle.copyWith(fontSize: 20),),
               Container(
            padding: const EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/3, //chiếm 2 phần trên màn hình
            child: const MyCarousel(),
          ),
      ]),)
    );
  }
}
//Banner top
class MyCarousel extends StatefulWidget {
  const MyCarousel({super.key});

  @override
  State<MyCarousel> createState() => _MyCarouselState();
}
class _MyCarouselState extends State<MyCarousel> {
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
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/img_demo/Banner.png',
            ),
          ),
        ),
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/img_demo/Banner.png',
            ),
          ),
        ),
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
          child: Image.asset(
              'assets/img_demo/Banner.png',
            ),
          ),
        )
      ],
    );
  }
}
//banner top end

// banner body
class MySecondCarousel extends StatefulWidget {
  const MySecondCarousel({super.key});

  @override
  State<MySecondCarousel> createState() => _MySecondCarouselState();
}
class _MySecondCarouselState extends State<MySecondCarousel> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 3) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var styles=Styles();
    return PageView(
      controller: _pageController,
      onPageChanged: (int page) {
        setState(() {
          _currentPage = page;
        });
      },
      children: [
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Image.asset(
                'assets/img_demo/Banner2.jpg',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                                 "KUNG FU PANDA 4 2D LT(P)",
                                 style:styles.titleTextStyle.copyWith(color: Colors.white,fontSize: 20) ,
                                  ),
                     const MovieTypeBox(fontSizeCus: 14,padding: 5, title: 'Hành động',),
                    const SizedBox(height:5),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const ShowtimeTypeBox(title: '2D',fontSizeCus: 15,),
                   const SizedBox(width: 10,),
                   const AgeRestrictionBox(title: "T18",fontSizeCus: 15,),
                  const SizedBox(width: 200,),
                  Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: TextButton(onPressed: (){

                  }, child: const Text("Đặt vé",style: TextStyle(color: Colors.white,fontSize: 16 ),), )
                   
                  )

                ],),
                          
            
              
              ],
            )
          ],
        ),
    Column(
  children: [
    GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MovieDetail(),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Image.asset(
          'assets/img_demo/Banner2.jpg',
          fit: BoxFit.cover,
        ),
      ),
    ),
    const SizedBox(height: 10,),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "KUNG FU PANDA 4 2D LT(P)",
          style: styles.titleTextStyle.copyWith(color: Colors.white,fontSize: 20),
        ),
        const MovieTypeBox(fontSizeCus: 14,padding: 5, title: 'Hài',),
        const SizedBox(height:5),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const ShowtimeTypeBox(title: '2D',fontSizeCus: 15,),
            const SizedBox(width: 2,),
            const AgeRestrictionBox(title: "T18",fontSizeCus: 15,),
            const SizedBox(width: 200,),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(10)
              ),
              child: TextButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetail(),
                    ),
                  );
                }, 
                child: const Text("Đặt vé",style: TextStyle(color: Colors.white,fontSize: 16 ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
),

      ],
    );
  }
}
// banner body end
//banner top 
class CarouselThird extends StatefulWidget {
  const CarouselThird({super.key});

  @override
  State<CarouselThird>createState() => _CarouselThirdState();
}

class _CarouselThirdState extends State<CarouselThird> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
      });
    });
  }

  @override
 Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.all(5),
          child: Center(
            child: GestureDetector(
              onTap: () {
                  Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetail(),
              
            ));
              },
              
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/img_demo/banner3.jpg',
                      fit: BoxFit.cover,
                    ),
                    const Text(
                      "19/5/2024",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
//banner top end