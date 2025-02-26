import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../apptheme/app_colors.dart';
import '../apptheme/stylehelper.dart';
import 'custom_button.dart';
import 'custom_container.dart';
import 'custom_text_field.dart';

class PaddingHorizontal20 extends StatelessWidget {
  const PaddingHorizontal20({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w), child: child);
  }
}

class PaddingHorizontal15 extends StatelessWidget {
  const PaddingHorizontal15(
      {Key? key, required this.child, this.verticalPadding})
      : super(key: key);

  final Widget child;
  final double? verticalPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 15.w, vertical: verticalPadding ?? 0),
        child: child);
  }
}

String removeHtmlTags(String htmlText) {
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

  return htmlText.replaceAll(exp, '');
}

ddMMYYYYDateFormat(String date) {
  try {
    return DateFormat('dd-MM-yyyy').format(DateTime.parse(date));
  } catch (e) {
    return '';
  }
}

yyyyMMddDateFormat(String date) {
  try {
    return DateFormat('yyyy-MM-dd').format(DateTime.parse(date.trim()));
  } catch (e) {
    return '';
  }
}

HHmmTimeFormat(String date) {
  try {
    return DateFormat('HH:mm')
        .format(DateTime.parse(date)); // Converts it to HH:mm format
  } catch (e) {
    return '';
  }
}

String hhmmAMPMTimeFormat(DateTime time) {
  try {
    final parsedTime =
        DateFormat.Hm(); // Parses the time in HH:mm format
    return DateFormat('hh:mm a')
        .format(time); // Converts it to hh:mm a format
  } catch (e) {
    return '';
  }
}

void showToast(BuildContext context, {required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.orange,
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      duration: const Duration(seconds: 3),
    ),
  );
}


class CommonDialog extends StatelessWidget {
  const CommonDialog({
    Key? key,
    required this.onTapNo,
    required this.onTapYes,
    required this.title,
  }) : super(key: key);

  final VoidCallback onTapNo;
  final VoidCallback onTapYes;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: StyleHelper.semiBoldBlack_14), // Removed .tr
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: onTapNo,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  child: Text("No", style: StyleHelper.semiBoldBlack_14), // Removed .tr
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: ElevatedButton(
                  onPressed: onTapYes,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue),
                  child: Text("Yes", style: StyleHelper.semiBoldWhite_14), // Removed .tr
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Future<void> openCustomTimePicker({
  required BuildContext context,
  required Function(String) pickTime,
}) async {
  TimeOfDay selectedTime = TimeOfDay.now();
  bool isAm = selectedTime.period == DayPeriod.am;

  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Select Time'),
        content: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Display hour and minute pickers
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButton<int>(
                      value: selectedTime.hourOfPeriod == 0
                          ? 12
                          : selectedTime.hourOfPeriod,
                      items:
                          List.generate(12, (index) => index + 1).map((hour) {
                        return DropdownMenuItem(
                          value: hour,
                          child: Text(hour.toString().padLeft(2, '0')),
                        );
                      }).toList(),
                      onChanged: (hour) {
                        setState(() {
                          selectedTime = selectedTime.replacing(
                            hour: (isAm ? 0 : 12) + (hour ?? 0),
                          );
                        });
                      },
                    ),
                    Text(':'),
                    DropdownButton<int>(
                      value: selectedTime.minute,
                      items: List.generate(60, (index) => index).map((minute) {
                        return DropdownMenuItem(
                          value: minute,
                          child: Text(minute.toString().padLeft(2, '0')),
                        );
                      }).toList(),
                      onChanged: (minute) {
                        setState(() {
                          selectedTime =
                              selectedTime.replacing(minute: minute ?? 0);
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16),
                // AM/PM toggle buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isAm = true;
                          selectedTime = selectedTime.replacing(
                            hour: selectedTime.hourOfPeriod,
                          );
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isAm ? Colors.orange : Colors.grey.shade300,
                        foregroundColor: isAm ? Colors.white : Colors.black,
                      ),
                      child: Text('AM'),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isAm = false;
                          selectedTime = selectedTime.replacing(
                            hour: selectedTime.hourOfPeriod + 12,
                          );
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            !isAm ? Colors.orange : Colors.grey.shade300,
                        foregroundColor: !isAm ? Colors.white : Colors.black,
                      ),
                      child: Text('PM'),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final formattedTime = selectedTime.format(context);
              pickTime(formattedTime);
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

openTimePicker(
    {required BuildContext context, required Function(String) pickTime}) async {
  TimeOfDay? temp = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    builder: (context, child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.dark(
            primary: AppColors.likeOrange,
            onPrimary: Colors.white,
            surface: AppColors.lightOrange,
            onSurface: Colors.black,
          ),
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                  textStyle: StyleHelper.semiBoldBlack_16)),
        ),
        child: child!,
      );
    },
  );

  if (temp != null) {
    final formattedTime = temp.format(context);
    pickTime.call(formattedTime);
  }
}

openDatePicker({required context, required Function(String) pickDate}) async {
  DateTime? temp = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2023, 01, 01),
    lastDate: DateTime.now(),
    initialEntryMode: DatePickerEntryMode.calendarOnly,
    builder: (context, child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.dark(
            primary: AppColors.likeOrange,
            onPrimary: Colors.white,
            surface: AppColors.lightOrange,
            onSurface: Colors.black,
          ),
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                  textStyle: StyleHelper.semiBoldBlack_16)),
        ),
        child: child!,
      );
    },
  );

  if (temp != null) {
    pickDate.call(ddMMYYYYDateFormat(temp.toString()));
  }
}


class FromDateToDateDialog extends StatefulWidget {
  const FromDateToDateDialog({
    Key? key,
    required this.onTapNo,
    required this.onTapYes,
  }) : super(key: key);

  final VoidCallback onTapNo;
  final Function(String fromDate, String toDate) onTapYes;

  @override
  _FromDateToDateDialogState createState() => _FromDateToDateDialogState();
}

class _FromDateToDateDialogState extends State<FromDateToDateDialog> {
  String fromDate = '';
  String toDate = '';

  void openDatePicker(BuildContext context, Function(String) pickDate) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (selectedDate != null) {
      pickDate(selectedDate.toString().split(" ")[0]); // Format YYYY-MM-DD
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Select From and To Date', style: StyleHelper.semiBoldBlack_16),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    openDatePicker(context, (selectedDate) {
                      setState(() {
                        fromDate = selectedDate;
                      });
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        fromDate.isEmpty ? "From Date" : fromDate,
                        style: StyleHelper.semiBoldBlack_11,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Text("To", style: StyleHelper.semiBoldBlack_12),
              const SizedBox(width: 15),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    openDatePicker(context, (selectedDate) {
                      setState(() {
                        toDate = selectedDate;
                      });
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        toDate.isEmpty ? "To Date" : toDate,
                        style: StyleHelper.semiBoldBlack_11,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: widget.onTapNo,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  child: Text("No", style: StyleHelper.semiBoldBlack_14),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (fromDate.isNotEmpty && toDate.isNotEmpty) {
                      widget.onTapYes(fromDate, toDate);
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please select both From and To dates'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: fromDate.isNotEmpty && toDate.isNotEmpty
                        ? AppColors.primaryBlue
                        : AppColors.greyColor.withAlpha(500),
                  ),
                  child: Text("Yes", style: StyleHelper.semiBoldWhite_14),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomBottomSheetContainer {
  static Widget bottomSheetContainer(
      {required Widget child,
      double? height,
      double? horizontal,
      double? topMargin,
      Color? color}) {
    return Container(
      height: height,
      padding:
          EdgeInsets.symmetric(horizontal: horizontal ?? 20.w, vertical: 5.h),
      margin: EdgeInsets.only(top: topMargin ?? 0),
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          color: color ?? Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(18.r))),
      child: child,
    );
  }
}





Future<String> convertFileToBase64(XFile pickedFile) async {
  // Read the image as bytes
  File file = File(pickedFile.path);
  List<int> fileBytes = await file.readAsBytes();

  // Convert bytes to base64 string
  String base64Image = base64Encode(fileBytes);

  // Get the file extension and prepare the data URI
  String fileExtension = pickedFile.path.split('.').last.toLowerCase();

  // Data URI format: data:image/<extension>;base64,<base64string>
  String dataUri = 'data:image/$fileExtension;base64,$base64Image';

  return dataUri;
}
