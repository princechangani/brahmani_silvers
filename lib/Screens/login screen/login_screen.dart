import 'package:brahmani_silvers/Screens/login%20screen/bloc/login_bloc.dart';
import 'package:brahmani_silvers/apptheme/app_colors.dart';
import 'package:brahmani_silvers/apptheme/stylehelper.dart';
import 'package:brahmani_silvers/routes.dart';
import 'package:brahmani_silvers/utils/const_image_key.dart';
import 'package:brahmani_silvers/utils/const_keys.dart';
import 'package:brahmani_silvers/widgets/common_widgets.dart';
import 'package:brahmani_silvers/widgets/custom_appBar.dart';
import 'package:brahmani_silvers/widgets/custom_button.dart';
import 'package:brahmani_silvers/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}



class _LoginScreenState extends State<LoginScreen> {
  late LoginBloc loginBloc;

  @override
  void initState() {
    loginBloc = context.read<LoginBloc>();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Center(child: Text("Login", style: StyleHelper.regularWhite_20)),
      ),
      body: BlocConsumer<LoginBloc,LoginState>(
        bloc: loginBloc,
          listener: (context,state)async{
            if(state is LoginSuccess){
              if(state.isLoginSuccess){
                SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString(IS_LOGIN, "true");
                Navigator.pushNamedAndRemoveUntil(context, Routes.home, (route) => false);
              }
              else{
                Fluttertoast.showToast(
                backgroundColor: AppColors.errorColor,
                msg: "Invalid credentials",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                fontSize: 16.0.sp,
              );
            }
            }
          },
          builder: (context,state){

             if(state is LoginLoading){
              return Center(
                child: Lottie.asset(AppImages.loadingIndicator),
              );
            }
            else if(state is LoginFailure){
             return Center(
                child: Text(state.errorMessage),
              );
            }
            else {
              return PaddingHorizontal15(
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(

                      children: [
                        Padding(
                          padding:  EdgeInsets.symmetric(vertical: 20.h),
                          child: Container(

                              child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                                  child: Image.asset(AppImages.smallAppLogo,height: 150.h,width: 150.h,))),
                        ),
                        CustomTextField(
                          controller: loginBloc.phoneController,
                          labelText: "Phone no.",
                          keyboardType: TextInputType.number,

                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10)
                          ],
                          ),
                        CustomTextField(
                          controller: loginBloc.pinController,
                          labelText: "Pin",
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(4)
                          ],
                        ),
                        CustomButton(
                            text: "Login",
                            onTap: (){
                          loginBloc.add(
                              LoginRequested(phone: loginBloc.phoneController.text, pin: loginBloc.pinController.text));

                        })
                      ],
                    ),
                  ),
                ),
              );
            }
          }, )
    );
  }
}
