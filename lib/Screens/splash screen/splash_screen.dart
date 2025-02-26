import 'package:brahmani_silvers/Screens/splash%20screen/bloc/splash_bloc.dart';
import 'package:brahmani_silvers/routes.dart';
import 'package:brahmani_silvers/utils/const_image_key.dart';
import 'package:brahmani_silvers/utils/const_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:brahmani_silvers/Screens/splash%20screen/bloc/splash_bloc.dart';
import 'package:brahmani_silvers/routes.dart';
import 'package:brahmani_silvers/utils/const_image_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SplashBloc splashBloc;

  @override
  void initState() {
    splashBloc = context.read<SplashBloc>(); // Get Bloc from Provider

    splashBloc.add(InitializeAppEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SplashBloc, SplashState>(
        bloc: splashBloc,
        listener: (context, state) async {
          if (state is SplashCompleted) {
            SharedPreferences sharedPreferences  = await SharedPreferences.getInstance();
            sharedPreferences.getString(IS_LOGIN);
            if(sharedPreferences.getString(IS_LOGIN)=="true")
              {
                Navigator.pushNamedAndRemoveUntil(context, Routes.home, (route) => false);

              }
            else{
              Navigator.pushNamedAndRemoveUntil(context, Routes.loginPage, (route) => false);

            }
          }
        },
        builder: (context, state) {
          if (state is SplashLoading) {
            return Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(AppImages.appLogo),
                  )
              ),
            );
          } else if (state is SplashCompleted) {
            return SizedBox.shrink(); // Avoid UI flickering
          } else {
            return Center(
              child: Text("Initializing..."), // Default state
            );
          }
        },
      ),
    );
  }
}

