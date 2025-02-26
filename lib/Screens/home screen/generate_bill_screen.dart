import 'package:brahmani_silvers/model/bill_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

import 'package:brahmani_silvers/Screens/home%20screen/bloc/generate_bill_bloc.dart';
import 'package:brahmani_silvers/Screens/home%20screen/bloc/generate_bill_event.dart';
import 'package:brahmani_silvers/Screens/home%20screen/bloc/generate_bill_state.dart';
import 'package:brahmani_silvers/apptheme/app_colors.dart';
import 'package:brahmani_silvers/apptheme/stylehelper.dart';
import 'package:brahmani_silvers/utils/const_image_key.dart';
import 'package:brahmani_silvers/widgets/common_widgets.dart';
import 'package:brahmani_silvers/widgets/custom_appBar.dart';
import 'package:brahmani_silvers/widgets/custom_button.dart';
import 'package:brahmani_silvers/widgets/custom_text_field.dart';

class GenerateBillScreen extends StatefulWidget {
  const GenerateBillScreen({super.key});

  @override
  State<GenerateBillScreen> createState() => _GenerateBillScreenState();
}

class _GenerateBillScreenState extends State<GenerateBillScreen> {
  late GenerateBillBloc generateBillBloc;
  bool isUpdate = false;
  int id = 0;

  @override
  void initState() {
    super.initState();
    generateBillBloc = context.read<GenerateBillBloc>();
    generateBillBloc.add(FetchBillEntriesEvent());
  }

  void _addBill(int id) {
    generateBillBloc.add(AddBillEntryEvent(
      id:id,
      date: generateBillBloc.date,
      details: generateBillBloc.detailsController.text,
      weight: generateBillBloc.weightController.text,
      crWeight: generateBillBloc.crWeightController.text,
      pieces: generateBillBloc.pieceController.text,
    ));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Center(
          child: Text("Generate Bill", style: StyleHelper.regularWhite_20),
        ),
        actions: [
          IconButton(onPressed: () {
            generateBillBloc.generateAndStorePDF(
                context, generateBillBloc.billModelList);
          }, icon: Icon(Icons.picture_as_pdf, color: AppColors.whiteColor,))
        ],
      ),
      body: BlocConsumer<GenerateBillBloc, GenerateBillState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is GenerateBillLoadingState) {
            return Center(
              child: Lottie.asset(AppImages.loadingIndicator),
            );
          }

          return PaddingHorizontal15(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Text("Details", style: StyleHelper.semiBoldBlack_14),
                ),
                CustomTextField(
                  horizontalMargin: 5.w,
                  topMargin: 5.h,
                  keyboardType: TextInputType.text,
                  controller: generateBillBloc.detailsController,
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    _buildInputField(
                        "Weight", generateBillBloc.weightController),
                    _buildInputField(
                        "CrWeight", generateBillBloc.crWeightController),
                    _buildInputField(
                        "Pieces", generateBillBloc.pieceController),
                  ],
                ),
                Row(
                  children: [
                    Text("Select Date", style: StyleHelper.boldBlack_14),
                    Spacer(),
                    TextButton(onPressed: () {
                      openDatePicker(context: context, pickDate: (
                          selectedDate) {
                        setState(() {
                          generateBillBloc.date = selectedDate;
                        });
                      });
                    },
                        child: Text(generateBillBloc.date,
                          style: StyleHelper.semiBoldBlack_14,)),
                  ],
                ),
                CustomButton(text: "Save", onTap: () {
                  setState(() {
                    _addBill(id);
                    id++;
                  });
                }),
                SizedBox(height: 15.h),
                Expanded(
                  child: BlocBuilder<GenerateBillBloc, GenerateBillState>(
                    builder: (context, state) {
                      if (state is BillLoadedState &&
                          state.billList.isNotEmpty) {
                        return ListView.separated(
                          shrinkWrap: true,
                          itemCount: state.billList.length,
                          separatorBuilder: (__, _) =>
                              Divider(
                                height: 0,
                                color: AppColors.primaryBlack,
                                thickness: 0.3.h,
                              ),
                          itemBuilder: (context, index) {
                            final bill = state.billList[index];
                            return Dismissible(
                              direction: DismissDirection.endToStart,
                              resizeDuration:
                              const Duration(milliseconds: 200),
                              key: ObjectKey(index),
                              confirmDismiss: (direction) {
                                if (direction ==
                                    DismissDirection.startToEnd) {
                                  setState(() {

                                  });

                                  generateBillBloc.date = bill.date!;
                                  generateBillBloc.detailsController.text =
                                      bill.details.toString();
                                  generateBillBloc.weightController.text =
                                      bill.weight.toString();

                                  generateBillBloc.crWeightController.text =
                                      bill.crWeight.toString();

                                  generateBillBloc.pieceController.text =
                                      bill.pieces.toString();
                                } else {
                                  setState(() {

                                  });
                                  state.billList.removeAt(index);
                                  generateBillBloc.billModelList.removeAt(
                                      index);
                                }

                                return Future.value(false);
                              },
                              background: Container(
                                padding: EdgeInsets.only(left: 25.w),
                                alignment: AlignmentDirectional.centerStart,
                                decoration: const BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(8))),
                                child: FaIcon(
                                    FontAwesomeIcons.solidPenToSquare,
                                    color: Colors.white,
                                    size: 20.sp),
                              ),
                              secondaryBackground: Container(
                                padding: EdgeInsets.only(right: 25.w),
                                alignment: AlignmentDirectional.centerEnd,
                                decoration: BoxDecoration(
                                  color: AppColors.buttonOrange.withOpacity(
                                      0.5),),
                                child: FaIcon(FontAwesomeIcons.trash,
                                    color: Colors.white, size: 20.sp),

                              ),
                              child: Padding(
                                padding: EdgeInsets.all(3.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Row(
                                      children: [
                                        Text(bill.details.toString()),
                                        Spacer(),
                                        Text(bill.date.toString(),
                                          style: StyleHelper.regularBlack_10
                                              .copyWith(
                                              color: AppColors.greyColor),),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Text("Weight: ${bill.weight}, Pieces: ${bill
                                        .pieces} , CrWeight: ${bill.crWeight}")
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return Center(child: Text("No bills added yet."));
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  Widget _buildInputField(String label, TextEditingController controller) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 5.w),
            child: Text(label,style: StyleHelper.semiBoldBlack_14),
          ),
          CustomTextField(
            horizontalMargin: 5.w,
            keyboardType: TextInputType.number,
            topMargin: 5.h,
            controller: controller,
          ),
        ],
      ),
    );
  }
}
