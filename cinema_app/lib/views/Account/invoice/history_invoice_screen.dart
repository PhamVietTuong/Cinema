import 'package:flutter/material.dart';
import 'package:cinema_app/config.dart';
import 'package:cinema_app/data/models/invoice.dart';
import 'package:cinema_app/presenters/invoice_presenter.dart';
import 'package:cinema_app/views/Account/invoice/history_invoice_item.dart';

class HistoryInvoiceScreen extends StatefulWidget {
  const HistoryInvoiceScreen({super.key});

  @override
  State<HistoryInvoiceScreen> createState() => _HistoryInvoiceScreenState();
}

class _HistoryInvoiceScreenState extends State<HistoryInvoiceScreen>
    implements InvoiceViewContract {
  List<Invoice> lstInvoi = [];
  late InvoicePresenter invoicePr;
  bool isLoadingData = true;
  String appBarTitle = "Hóa đơn";
  String loadingText = "Đang load";
  String noInvoicesText = "Chưa có hóa đơn nào";
  String invoiceLabel = "Hóa đơn";
  String branchLabel = "Chi nhánh";
  String totalLabel = "Tổng cộng";
  String pointsLabel = "Điểm";

  @override
  void initState() {
    super.initState();
    invoicePr = InvoicePresenter(this);
    invoicePr.fetchInvoice();
    translate(); // Dịch các chuỗi văn bản ngay khi khởi tạo
  }

  Future<void> translate() async {
    List<String> translateTexts = await Future.wait([
      Styles.translate(appBarTitle),
      Styles.translate(loadingText),
      Styles.translate(noInvoicesText),
      Styles.translate(invoiceLabel),
      Styles.translate(branchLabel),
      Styles.translate(totalLabel),
      Styles.translate(pointsLabel),
    ]);

    setState(() {
      appBarTitle = translateTexts[0];
      loadingText = translateTexts[1];
      noInvoicesText = translateTexts[2];
      invoiceLabel = translateTexts[3];
      branchLabel = translateTexts[4];
      totalLabel = translateTexts[5];
      pointsLabel = translateTexts[6];
      // Không đặt isLoadingData = false ở đây để tránh ảnh hưởng đến trạng thái tải dữ liệu
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Styles.boldTextColor[Config.themeMode],
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          appBarTitle,
          style: TextStyle(
            fontSize: Styles.appbarFontSize,
            color: Styles.boldTextColor[Config.themeMode],
          ),
        ),
        backgroundColor: Styles.backgroundContent[Config.themeMode],
      ),
      backgroundColor: Styles.backgroundColor[Config.themeMode],
      body: isLoadingData
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Styles.textColor[Config.themeMode]!),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    loadingText,
                    style: TextStyle(
                      fontSize: Styles.titleFontSize,
                      fontWeight: FontWeight.bold,
                      color: Styles.textColor[Config.themeMode],
                    ),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            invoiceLabel,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Styles.titleColor[Config.themeMode],
                              fontSize: Styles.titleFontSize,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            branchLabel,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Styles.titleColor[Config.themeMode],
                              fontSize: Styles.titleFontSize,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            totalLabel,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Styles.titleColor[Config.themeMode],
                              fontSize: Styles.titleFontSize,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            pointsLabel,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Styles.titleColor[Config.themeMode],
                              fontSize: Styles.titleFontSize,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (lstInvoi.isEmpty)
                      Center(
                        child: Text(
                          noInvoicesText,
                          style: TextStyle(
                            color: Styles.boldTextColor[Config.themeMode],
                            fontSize: Styles.titleFontSize,
                          ),
                        ),
                      ),
                    Column(
                      children: lstInvoi
                          .map((e) => HistoryInvoiceItem(invoice: e))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  @override
  void onLoadError() {
    setState(() {
      isLoadingData = false;
    });
  }

  Future<void> _checkAndFetchInvoices(List<Invoice> invoices) async {
    final List<Invoice> storedInvoices = await Config.getStoredInvoices();

    if (storedInvoices.length < invoices.length) {
      Config.saveInvoice(invoices);
      //print("Luu");
    } else {
      setState(() {
        isLoadingData = false;
      });
      // print("khongLuu");
    }
  }

  @override
  void onLoadInvoiceComplete(List<Invoice> invoices) {
    setState(() {
      lstInvoi = invoices;
      isLoadingData = false;
    });
    _checkAndFetchInvoices(lstInvoi);
  }
}
