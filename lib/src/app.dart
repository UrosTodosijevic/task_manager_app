import 'package:flutter/material.dart';
import 'package:task_manager_app/src/routes.dart';
import 'package:task_manager_app/src/styles/colors.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlatformApp();
  }
}

class PlatformApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      theme: ThemeData(
        primaryColor: AppColors.cadetBlue,
        colorScheme: ColorScheme(
          primary: AppColors.cadetBlue,
          primaryVariant: AppColors.tealBlue,
          secondary: AppColors.charcoal,
          secondaryVariant: AppColors.raisinBlack,
          surface: AppColors.beauBlue,
          background: AppColors.lightPeriwinkle,
          error: Colors.red,
          onPrimary: AppColors.charcoal,
          onSecondary: AppColors.raisinBlack,
          onSurface: /*AppColors.raisinBlack*/AppColors.charcoal,
          onBackground: /*AppColors.raisinBlack*/AppColors.charcoal,
          onError: AppColors.raisinBlack,
          brightness: Brightness.light,
        ),
        dialogBackgroundColor: AppColors.lightPeriwinkle,
        scaffoldBackgroundColor: AppColors.lightPeriwinkle,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: Routes.materialRoutes,
    );
  }
}
