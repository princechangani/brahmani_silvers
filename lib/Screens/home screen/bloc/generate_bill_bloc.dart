import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:brahmani_silvers/Screens/home%20screen/bloc/generate_bill_event.dart';
import 'package:brahmani_silvers/Screens/home%20screen/bloc/generate_bill_state.dart';
import 'package:brahmani_silvers/apptheme/app_colors.dart';
import 'package:brahmani_silvers/apptheme/stylehelper.dart';
import 'package:brahmani_silvers/model/bill_model.dart';
import 'package:brahmani_silvers/widgets/common_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

class GenerateBillBloc extends Bloc<GenerateBillEvent, GenerateBillState> {
  final List<BillModel> billModelList = [];

  String date = DateFormat('dd-MMM-yyyy').format(DateTime.now());
  final TextEditingController weightController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  final TextEditingController crWeightController = TextEditingController();
  final TextEditingController pieceController = TextEditingController();

  GenerateBillBloc() : super(GenerateBillInitial()) {
    on<AddBillEntryEvent>(_onAddBillEntry);
    on<FetchBillEntriesEvent>(_onFetchBillEntries);
  }

  void _onAddBillEntry(AddBillEntryEvent event, Emitter<GenerateBillState> emit) {
    emit(GenerateBillLoadingState());

    if(_validator()){
      billModelList.add(BillModel(
        id: event.id,
        date: event.date,
        weight: event.weight,
        details: event.details,
        crWeight: event.crWeight,
        pieces: event.pieces,
      ));
    }
    else{
      Fluttertoast.showToast(
          backgroundColor: AppColors.errorColor,
          msg: "Full Fill Entry Details");
    }


    clearControllers();
    emit(BillLoadedState(List.from(billModelList)));
  }

  void _onFetchBillEntries(FetchBillEntriesEvent event, Emitter<GenerateBillState> emit) {
    emit(GenerateBillLoadingState());
    emit(BillLoadedState(List.from(billModelList)));
  }
  bool _validator (){
    if(weightController.text.isEmpty ||
    detailsController.text.isEmpty ||
    crWeightController.text.isEmpty ||
    pieceController.text.isEmpty ) {

      return false;
    }
    return true;
  }
  Future<void> generateAndStorePDF(BuildContext context, List<BillModel> billList) async {
    final status = await Permission.manageExternalStorage.status;

    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Storage permission is required to save the PDF.")),
      );
      return;
    }

    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
             pw.Text("Bill Report", style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),

            pw.Center(
              child: pw.Text("Bill Report", style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),

            ),
            pw.SizedBox(height: 10),
            pw.Table(
              border: pw.TableBorder.all(width: 1),
              columnWidths: {
                0: pw.FlexColumnWidth(1),
                1: pw.FlexColumnWidth(1),
                2: pw.FlexColumnWidth(2),
                3: pw.FlexColumnWidth(1),
                4: pw.FlexColumnWidth(1),
              },
              children: [
                pw.TableRow(
                  decoration: pw.BoxDecoration(color: PdfColors.grey300),
                  children: [
                    pw.Padding(padding: pw.EdgeInsets.all(5), child: pw.Text("Date", style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                    pw.Padding(padding: pw.EdgeInsets.all(5), child: pw.Text("Weight", style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                    pw.Padding(padding: pw.EdgeInsets.all(5), child: pw.Text("Details", style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                    pw.Padding(padding: pw.EdgeInsets.all(5), child: pw.Text("CrWeight", style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                    pw.Padding(padding: pw.EdgeInsets.all(5), child: pw.Text("Pieces", style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                  ],
                ),
                ...billList.map(
                      (bill) => pw.TableRow(
                    children: [
                      pw.Padding(padding: pw.EdgeInsets.all(5), child: pw.Text(bill.date.toString())),
                      pw.Padding(padding: pw.EdgeInsets.all(5), child: pw.Text(bill.weight.toString())),
                      pw.Padding(padding: pw.EdgeInsets.all(5), child: pw.Text(bill.details.toString())),
                      pw.Padding(padding: pw.EdgeInsets.all(5), child: pw.Text(bill.crWeight.toString())),
                      pw.Padding(padding: pw.EdgeInsets.all(5), child: pw.Text(bill.pieces.toString())),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    try {
      final Directory? downloadsDir = await Directory('/storage/emulated/0/Download');
      final filePath = '${downloadsDir?.path}/${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}_bill_report.pdf';

      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());
      showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
        ),
        backgroundColor: AppColors.whiteColor,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Download Complete", style: StyleHelper.boldWhite_14),
                SizedBox(height: 10.h),
                Text("File saved at: $filePath", style: StyleHelper.regularBlack_14),
                SizedBox(height: 20.h),

                Column(
                  children: [
                    Padding(
                      padding:  EdgeInsets.symmetric(vertical: 10.h),
                      child: GestureDetector(

                        onTap: () => OpenFile.open(filePath),
                        child: Row(
                          children: [
                            Image.asset('assets/images/folder.png',color: AppColors.primaryWhite,height: 20.h,width: 20.h,),
                            SizedBox(width: 10.h,),
                            Expanded(child: Text("Open", style: StyleHelper.regularBlack_14)),
                          ],
                        ),
                      ),
                    ),
                    PaddingHorizontal15(
                        child: Divider(height: 1.h,color: AppColors.primaryBlack,)),
                    Padding(
                      padding:  EdgeInsets.symmetric(vertical: 10.h),
                      child: GestureDetector(
                        onTap: () => Share.shareXFiles([XFile(filePath)], text: "Here is your file"),
                        child: Row(
                          children: [
                            Image.asset('assets/images/share.png',color: AppColors.primaryWhite,height: 20.h,width: 20.h,),
                            SizedBox(width: 10.h,),
                            Expanded(child: Text("Share", style:  StyleHelper.regularBlack_14)),
                          ],
                        ),
                      ),
                    ),
                    PaddingHorizontal15(

                        child: Divider(height: 1.h,color: AppColors.primaryBlack,)),
                    Padding(
                      padding:  EdgeInsets.symmetric(vertical: 10.h),

                      child: GestureDetector(
                        onTap: () async {
                          final Directory? downloadsDir = await Directory(
                              '/storage/emulated/0/Download');
                          final filePath = '${downloadsDir
                              ?.path}/bill_report.pdf';

                          final file = File(filePath);
                          await file.writeAsBytes(await pdf.save());
                          Navigator.pop(context);
                        },
                        child: Row(
                          children: [
                            Image.asset('assets/images/close.png',color: AppColors.errorColor,height: 20.h,width: 20.h,),
                            SizedBox(width: 10.h,),
                            Expanded(child: Text("Close", style: StyleHelper.regularBlack_14)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );


    } catch (e) {
      print("Error generating PDF: $e");
    }
  }


  void clearControllers() {
    weightController.clear();
    detailsController.clear();
    crWeightController.clear();
    pieceController.clear();
  }


}
