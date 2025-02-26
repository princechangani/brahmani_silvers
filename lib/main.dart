import 'dart:io';

import 'package:brahmani_silvers/Screens/home%20screen/bloc/generate_bill_bloc.dart';
import 'package:brahmani_silvers/Screens/home%20screen/bloc/generate_bill_state.dart';
import 'package:brahmani_silvers/Screens/login%20screen/bloc/login_bloc.dart';
import 'package:brahmani_silvers/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Screens/splash screen/bloc/splash_bloc.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      splitScreenMode: true,

      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => SplashBloc()),
            BlocProvider(create: (context) => LoginBloc()),
            BlocProvider(create: (context) => GenerateBillBloc()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Brahmani Silvers',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            initialRoute: Routes.splash, // Set initial route here
            onGenerateRoute: generateRoute, ),
        );
      },
    );
  }
}

