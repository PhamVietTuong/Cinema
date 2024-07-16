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

  @override
  void initState() {
    super.initState();
    invoicePr = InvoicePresenter(this);
    invoicePr.fetchInvoice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Styles.boldTextColor[
              Config.themeMode], 
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Hóa đơn",
          style: TextStyle(
            fontSize: Styles.appbarFontSize,
            color: Styles.boldTextColor[
                Config.themeMode], 
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
                    "Đang load",
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
                margin: const EdgeInsets.symmetric(
                    horizontal: Styles.defaultHorizontal, vertical: 15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Hóa đơn",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color:
                                  Styles.titleColor[Config.themeMode],
                              fontSize: Styles.titleFontSize,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Chi nhánh",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color:
                                  Styles.titleColor[Config.themeMode],
                              fontSize: Styles.titleFontSize,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Tổng cộng",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color:
                                  Styles.titleColor[Config.themeMode],
                              fontSize: Styles.titleFontSize,
                            ),
                          ),
                        ),
                         Expanded(
                          child: Text(
                            "Điểm",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color:
                                  Styles.titleColor[Config.themeMode],
                              fontSize: Styles.titleFontSize,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if(lstInvoi.isEmpty)
                      Center(child: Text("Chưa có hóa đơn nào", style: TextStyle(
                      color: Styles.boldTextColor[Config.themeMode],
                      fontSize: Styles.titleFontSize,
                    ),),),
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
