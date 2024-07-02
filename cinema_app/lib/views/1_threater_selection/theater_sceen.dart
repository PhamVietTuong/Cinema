import 'package:cinema_app/config.dart';
import 'package:cinema_app/data/models/food_and_drink.dart';
import 'package:cinema_app/data/models/theater.dart';
import 'package:cinema_app/presenters/theater_presenter.dart';
import 'package:cinema_app/views/1_threater_selection/theater_item.dart';
import 'package:flutter/material.dart';

class TheaterScreen extends StatefulWidget {
  const TheaterScreen({Key? key}) : super(key: key);

  @override
  State<TheaterScreen> createState() => _TheaterScreenState();
}

class _TheaterScreenState extends State<TheaterScreen>
    implements TheaterViewContract {
  late TheaterPresenter _theaterPresenter;
  bool _isLoadingData = true;
  List<TheaterItem> _theaterItemList = [];
  String titleAppbar = "MUA VÉ";
  String stateDes = "Đang tải";
  void translate() async {
    List<String> res = await Future.wait(
        [Styles.translate(titleAppbar), Styles.translate(stateDes)]);
    titleAppbar = res[0];
    stateDes = res[1];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _theaterPresenter = TheaterPresenter(this);
    _theaterPresenter.fetchTheaters();
    translate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.backgroundColor[Config.themeMode],
      appBar: AppBar(
        title: Text(
          titleAppbar,
          style: TextStyle(color: Styles.boldTextColor[Config.themeMode]),
        ),
        centerTitle: true,
        backgroundColor: Styles.backgroundContent[Config.themeMode],
        elevation: 1,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return _isLoadingData ? _buildLoadingIndicator() : _buildTheaterList();
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
                Styles.boldTextColor[Config.themeMode]!),
          ),
          const SizedBox(height: 20),
          Text(
            "$stateDes....",
            style: TextStyle(
                fontSize: Styles.titleFontSize,
                fontWeight: FontWeight.bold,
                color: Styles.boldTextColor[Config.themeMode]),
          ),
        ],
      ),
    );
  }

  Widget _buildTheaterList() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: _theaterItemList,
      ),
    );
  }

  @override
  void onLoadTheaterComplete(List<Theater> theaters) {
    setState(() {
      theaters.sort((a, b) => a.name.compareTo(b.name));
      _theaterItemList =
          (theaters.map((theater) => TheaterItem(theater: theater)).toList())
              .cast<TheaterItem>();
      _isLoadingData = false;
    });
  }

  @override
  void onLoadError() {
    setState(() {
      _isLoadingData = false;
    });
    _showErrorDialog();
  }

  void _showErrorDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Lỗi"),
            content: const Text(
                "Đã xảy ra lỗi khi tải dữ liệu. Vui lòng thử lại sau."),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Đóng"),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _isLoadingData = true;
                  });
                  _theaterPresenter.fetchTheaters();
                  Navigator.of(context).pop();
                },
                child: const Text("Tải lại"),
              ),
            ],
          );
        });
  }

  @override
  void onLoadCombosByTheater(List<FoodAndDrink> combos) {}
}
