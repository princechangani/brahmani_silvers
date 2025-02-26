import 'package:brahmani_silvers/Screens/bottom%20navbar%20screen/bloc/navbar_bloc.dart';
import 'package:brahmani_silvers/apptheme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomBarScreen extends StatelessWidget {
  final List<Widget> bodyList = [

  ];

  BottomBarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavbarBloc(),
      child: BlocConsumer<NavbarBloc, NavbarState>(
        listener: (context, state) {},
        builder: (context, state) {
          int currentIndex = state is DashboardPageChanged ? state.currentIndex : 0;

          return Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                bodyList[currentIndex],
                Positioned(
                  bottom: 15.h,
                  left: 8.w,
                  right: 8.w,
                  child: Container(
                    height: 60.h,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primaryBlack,
                          AppColors.primaryWhite,
                        ],
                        end: Alignment.bottomCenter,
                        begin: Alignment.topCenter,
                      ),
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max, // Ensure Row takes full width
                      children: List.generate(5, (index) {
                        return Expanded(
                          child: GestureDetector(
                            onTap: () {
                              context.read<NavbarBloc>().add(DashboardNavigateEvent(index));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 45.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: currentIndex == index
                                        ? AppColors.whiteColor
                                        : Colors.transparent,
                                    shape: BoxShape.circle,
                                  ),
                                  child: _getIcon(index, currentIndex),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _getIcon(int index, int currentIndex) {
    List<IconData> icons = [
      Icons.home,
      Icons.computer,
      Icons.assignment,
      Icons.score,
      Icons.chat
    ];

    return FaIcon(
      icons[index],
      color: currentIndex == index ? AppColors.primaryBlack : Colors.white,
      size: currentIndex == index ? 25.sp : 23.sp,
    );
  }
}