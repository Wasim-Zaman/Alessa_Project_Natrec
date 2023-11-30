// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
              onPressed: () {
                createAndPrintPdf(context);
              },
              child: const Text("Print")),
        ),
      ),
    );
  }

  void createAndPrintPdf(BuildContext context) async {
    final pdf = pw.Document();

    // Add your custom widget to the PDF document.
    pdf.addPage(
      pw.Page(
        build: (ctx) {
          return pw.Center(
            child: printWidget(context),
          );
        },
      ),
    );

    // Generate the PDF file.
    final pdfBytes = await pdf.save();

    // Print the PDF file.
    await Printing.sharePdf(bytes: pdfBytes, filename: 'my_document.pdf');
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }

  printWidget(ctxx) => pw.Padding(
        padding: pw.EdgeInsets.symmetric(
            horizontal: MediaQuery.of(ctxx).size.width * 0.02),
        child: pw.Column(
          children: [
            pw.SizedBox(
              height: MediaQuery.of(ctxx).size.height * 0.06,
            ),
            pw.Text(
              "Delivery Note",
              style: pw.TextStyle(
                fontSize: MediaQuery.of(ctxx).size.width * 0.05,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.Table(
              //border: TableBorder.all(color: Colors.grey, borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
              children: [
                pw.TableRow(
                  children: [
                    pw.Padding(
                        padding: pw.EdgeInsets.only(
                            right: MediaQuery.of(ctxx).size.width * 0.01,
                            top: MediaQuery.of(ctxx).size.height * 0.01,
                            bottom: MediaQuery.of(ctxx).size.height * 0.03,
                            left: MediaQuery.of(ctxx).size.width * 0.02),
                        child: pw.Text(
                          "ORDER NO.",
                          style: pw.TextStyle(
                              fontSize: MediaQuery.of(ctxx).size.width * 0.04,
                              fontWeight: pw.FontWeight.bold),
                        )),
                    pw.Padding(
                        padding: pw.EdgeInsets.only(
                            right: MediaQuery.of(ctxx).size.width * 0.01,
                            top: MediaQuery.of(ctxx).size.height * 0.01,
                            bottom: MediaQuery.of(ctxx).size.height * 0.03,
                            left: MediaQuery.of(ctxx).size.width * 0.02),
                        child: pw.Text(
                          "DEPARTMENT",
                          style: pw.TextStyle(
                              fontSize: MediaQuery.of(ctxx).size.width * 0.04,
                              fontWeight: pw.FontWeight.bold),
                        )),
                    pw.Padding(
                        padding: pw.EdgeInsets.only(
                            right: MediaQuery.of(ctxx).size.width * 0.01,
                            top: MediaQuery.of(ctxx).size.height * 0.01,
                            bottom: MediaQuery.of(ctxx).size.height * 0.03,
                            left: MediaQuery.of(ctxx).size.width * 0.02),
                        child: pw.Text(
                          "DATE",
                          style: pw.TextStyle(
                              fontSize: MediaQuery.of(ctxx).size.width * 0.04,
                              fontWeight: pw.FontWeight.bold),
                        )),
                  ],
                ),
              ],
            ),
            pw.Table(
              //border: TableBorder.all(color: Colors.grey),
              children: [
                pw.TableRow(
                  children: [
                    pw.Padding(
                        padding: pw.EdgeInsets.only(
                            right: MediaQuery.of(ctxx).size.width * 0.01,
                            top: MediaQuery.of(ctxx).size.height * 0.01,
                            bottom: MediaQuery.of(ctxx).size.height * 0.03,
                            left: MediaQuery.of(ctxx).size.width * 0.02),
                        child: pw.Text(
                          "Name",
                          style: pw.TextStyle(
                              fontSize: MediaQuery.of(ctxx).size.width * 0.04,
                              fontWeight: pw.FontWeight.bold),
                        )),
                  ],
                ),
              ],
            ),
            pw.Table(
              //border: TableBorder.all(color: Colors.grey),
              children: [
                pw.TableRow(
                  children: [
                    pw.Padding(
                        padding: pw.EdgeInsets.only(
                            right: MediaQuery.of(ctxx).size.width * 0.01,
                            top: MediaQuery.of(ctxx).size.height * 0.01,
                            bottom: MediaQuery.of(ctxx).size.height * 0.03,
                            left: MediaQuery.of(ctxx).size.width * 0.02),
                        child: pw.Text(
                          "Address",
                          style: pw.TextStyle(
                              fontSize: MediaQuery.of(ctxx).size.width * 0.04,
                              fontWeight: pw.FontWeight.bold),
                        )),
                  ],
                ),
              ],
            ),
            pw.Table(
              //border: TableBorder.all(color: Colors.grey, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0))),
              children: [
                pw.TableRow(
                  children: [
                    pw.Padding(
                        padding: pw.EdgeInsets.only(
                            right: MediaQuery.of(ctxx).size.width * 0.01,
                            top: MediaQuery.of(ctxx).size.height * 0.01,
                            bottom: MediaQuery.of(ctxx).size.height * 0.03,
                            left: MediaQuery.of(ctxx).size.width * 0.02),
                        child: pw.Text(
                          "City, State, Zip",
                          style: pw.TextStyle(
                              fontSize: MediaQuery.of(ctxx).size.width * 0.04,
                              fontWeight: pw.FontWeight.bold),
                        )),
                  ],
                ),
              ],
            ),
            pw.Table(
              //border: TableBorder.all(color: Colors.grey, borderRadius: BorderRadius.circular(20.0)),
              children: [
                pw.TableRow(
                  children: [
                    pw.Padding(
                        padding: pw.EdgeInsets.only(
                            right: MediaQuery.of(ctxx).size.width * 0.02,
                            left: MediaQuery.of(ctxx).size.width * 0.02,
                            top: MediaQuery.of(ctxx).size.height * 0.005,
                            bottom: MediaQuery.of(ctxx).size.height * 0.05),
                        child: pw.Center(
                            child: pw.Text(
                          "SOLD BY",
                          style: pw.TextStyle(
                              fontSize: MediaQuery.of(ctxx).size.width * 0.04,
                              fontWeight: pw.FontWeight.bold),
                        ))),
                    pw.Padding(
                        padding: pw.EdgeInsets.only(
                            right: MediaQuery.of(ctxx).size.width * 0.02,
                            left: MediaQuery.of(ctxx).size.width * 0.02,
                            top: MediaQuery.of(ctxx).size.height * 0.005,
                            bottom: MediaQuery.of(ctxx).size.height * 0.05),
                        child: pw.Center(
                            child: pw.Text(
                          "CASH",
                          style: pw.TextStyle(
                              fontSize: MediaQuery.of(ctxx).size.width * 0.04,
                              fontWeight: pw.FontWeight.bold),
                        ))),
                    pw.Padding(
                        padding: pw.EdgeInsets.only(
                            right: MediaQuery.of(ctxx).size.width * 0.02,
                            left: MediaQuery.of(ctxx).size.width * 0.02,
                            top: MediaQuery.of(ctxx).size.height * 0.005,
                            bottom: MediaQuery.of(ctxx).size.height * 0.05),
                        child: pw.Center(
                            child: pw.Text(
                          "C.O.D",
                          style: pw.TextStyle(
                              fontSize: MediaQuery.of(ctxx).size.width * 0.04,
                              fontWeight: pw.FontWeight.bold),
                        ))),
                    pw.Padding(
                        padding: pw.EdgeInsets.only(
                            right: MediaQuery.of(ctxx).size.width * 0.02,
                            left: MediaQuery.of(ctxx).size.width * 0.02,
                            top: MediaQuery.of(ctxx).size.height * 0.005,
                            bottom: MediaQuery.of(ctxx).size.height * 0.05),
                        child: pw.Center(
                            child: pw.Text(
                          "CHARGES",
                          style: pw.TextStyle(
                              fontSize: MediaQuery.of(ctxx).size.width * 0.04,
                              fontWeight: pw.FontWeight.bold),
                        ))),
                    pw.Padding(
                        padding: pw.EdgeInsets.only(
                            right: MediaQuery.of(ctxx).size.width * 0.02,
                            left: MediaQuery.of(ctxx).size.width * 0.02,
                            top: MediaQuery.of(ctxx).size.height * 0.005,
                            bottom: MediaQuery.of(ctxx).size.height * 0.05),
                        child: pw.Center(
                            child: pw.Text(
                          "ON.ACCT.",
                          style: pw.TextStyle(
                              fontSize: MediaQuery.of(ctxx).size.width * 0.04,
                              fontWeight: pw.FontWeight.bold),
                        ))),
                    pw.Padding(
                        padding: pw.EdgeInsets.only(
                            right: MediaQuery.of(ctxx).size.width * 0.02,
                            left: MediaQuery.of(ctxx).size.width * 0.02,
                            top: MediaQuery.of(ctxx).size.height * 0.005,
                            bottom: MediaQuery.of(ctxx).size.height * 0.05),
                        child: pw.Center(
                            child: pw.Text(
                          "MDSE. RETD",
                          style: pw.TextStyle(
                              fontSize: MediaQuery.of(ctxx).size.width * 0.04,
                              fontWeight: pw.FontWeight.bold),
                        ))),
                    pw.Padding(
                        padding: pw.EdgeInsets.only(
                            right: MediaQuery.of(ctxx).size.width * 0.02,
                            left: MediaQuery.of(ctxx).size.width * 0.02,
                            top: MediaQuery.of(ctxx).size.height * 0.005,
                            bottom: MediaQuery.of(ctxx).size.height * 0.05),
                        child: pw.Center(
                            child: pw.Text(
                          "PAID OUT",
                          style: pw.TextStyle(
                              fontSize: MediaQuery.of(ctxx).size.width * 0.04,
                              fontWeight: pw.FontWeight.bold),
                        ))),
                  ],
                ),
              ],
            ),
            pw.Table(
              columnWidths: {
                0: pw.FractionColumnWidth(
                    MediaQuery.of(ctxx).size.width * 0.0005),
                1: pw.FractionColumnWidth(
                    MediaQuery.of(ctxx).size.width * 0.001)
              },
              //border: TableBorder.all(color: Colors.grey, borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
              children: [
                pw.TableRow(
                  children: [
                    pw.Padding(
                        padding: pw.EdgeInsets.symmetric(
                            vertical: MediaQuery.of(ctxx).size.height * 0.008),
                        child: pw.Center(
                            child: pw.Text(
                          "QUANTITY",
                          style: pw.TextStyle(
                              fontSize: MediaQuery.of(ctxx).size.width * 0.04,
                              fontWeight: pw.FontWeight.bold),
                        ))),
                    pw.Padding(
                      padding: pw.EdgeInsets.symmetric(
                          vertical: MediaQuery.of(ctxx).size.height * 0.008),
                      child: pw.Center(
                          child: pw.Text(
                        "DESCRIPTION",
                        style: pw.TextStyle(
                            fontSize: MediaQuery.of(ctxx).size.width * 0.04,
                            fontWeight: pw.FontWeight.bold),
                      )),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.symmetric(
                          vertical: MediaQuery.of(ctxx).size.height * 0.008),
                      child: pw.Center(
                          child: pw.Text(
                        "PRICE",
                        style: pw.TextStyle(
                            fontSize: MediaQuery.of(ctxx).size.width * 0.04,
                            fontWeight: pw.FontWeight.bold),
                      )),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.symmetric(
                          vertical: MediaQuery.of(ctxx).size.height * 0.008),
                      child: pw.Center(
                          child: pw.Text(
                        "AMOUNT",
                        style: pw.TextStyle(
                            fontSize: MediaQuery.of(ctxx).size.width * 0.04,
                            fontWeight: pw.FontWeight.bold),
                      )),
                    ),
                  ],
                ),
              ],
            ),
            pw.Expanded(
              child: pw.ListView.builder(
                  itemCount: 18,
                  itemBuilder: (pw.Context ct, int index) {
                    return pw.Table(
                      columnWidths: {
                        0: pw.FractionColumnWidth(
                            MediaQuery.of(ctxx).size.width * 0.0001),
                        1: pw.FractionColumnWidth(
                            MediaQuery.of(ctxx).size.width * 0.0004),
                        2: pw.FractionColumnWidth(
                            MediaQuery.of(ctxx).size.width * 0.001)
                      },
                      //border: TableBorder?.all(color: Colors.grey),
                      children: [
                        pw.TableRow(
                          children: [
                            pw.Padding(
                                padding: pw.EdgeInsets.symmetric(
                                    vertical: MediaQuery.of(ctxx).size.height *
                                        0.008),
                                child: pw.Center(
                                    child: pw.Text(
                                  index.toString(),
                                  style: pw.TextStyle(
                                      fontSize:
                                          MediaQuery.of(ctxx).size.width * 0.04,
                                      fontWeight: pw.FontWeight.bold),
                                ))),
                            pw.Padding(
                                padding: pw.EdgeInsets.symmetric(
                                    vertical: MediaQuery.of(ctxx).size.height *
                                        0.008),
                                child: pw.Center(
                                    child: pw.Text(
                                  "1",
                                  style: pw.TextStyle(
                                      fontSize:
                                          MediaQuery.of(ctxx).size.width * 0.04,
                                      fontWeight: pw.FontWeight.bold),
                                ))),
                            pw.Padding(
                              padding: pw.EdgeInsets.symmetric(
                                  vertical:
                                      MediaQuery.of(ctxx).size.height * 0.008),
                              child: pw.Center(
                                  child: pw.Text(
                                "",
                                style: pw.TextStyle(
                                    fontSize:
                                        MediaQuery.of(ctxx).size.width * 0.04,
                                    fontWeight: pw.FontWeight.bold),
                              )),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.symmetric(
                                  vertical:
                                      MediaQuery.of(ctxx).size.height * 0.008),
                              child: pw.Center(
                                  child: pw.Text(
                                "",
                                style: pw.TextStyle(
                                    fontSize:
                                        MediaQuery.of(ctxx).size.width * 0.04,
                                    fontWeight: pw.FontWeight.bold),
                              )),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.symmetric(
                                  vertical:
                                      MediaQuery.of(ctxx).size.height * 0.008),
                              child: pw.Center(
                                  child: pw.Text(
                                "",
                                style: pw.TextStyle(
                                    fontSize:
                                        MediaQuery.of(ctxx).size.width * 0.04,
                                    fontWeight: pw.FontWeight.bold),
                              )),
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
            ),
          ],
        ),
      );
}
