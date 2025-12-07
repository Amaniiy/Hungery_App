import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sonic_app/core/routing/app_route.dart';
import 'package:sonic_app/features/hungery_app.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  runApp(HungeryApp(appRouter: AppRouter()));
}
