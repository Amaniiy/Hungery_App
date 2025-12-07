import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sonic_app/core/routing/Routes.dart';
import 'package:sonic_app/core/routing/app_route.dart';
import 'package:sonic_app/core/theming/colorsapp.dart';

class HungeryApp extends StatelessWidget {
  final AppRouter appRouter;
  const HungeryApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        initialRoute: Routes.splashScreen,
        title: "Hungery App",
        theme: ThemeData(
          primaryColor: ColorsApp.mainColor,
          scaffoldBackgroundColor: Colors.white,
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: appRouter.generateRoute,
      ),
    );
  }
}
