import 'dart:async';

// Đối tượng CountDown để quản lý thời gian đếm ngược
class CountDown  {
  static const int _max=420;
 static int time = _max;
 static  Timer _timer=Timer(Duration.zero,(){});

static int index=0;
  // Bắt đầu đếm ngược

static void start() {
    time = _max;
    _timer.cancel();
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (time > 0) {
        time--;
      } else {
        stop();
      }
    });
  }

  // Dừng đếm ngược
 static void stop() {
    _timer.cancel();
  }


 static void resetTime() {
    time=_max;
 }
}


