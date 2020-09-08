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
        //primarySwatch: Colors.green,
        primaryColor: AppColors.cadetBlue,
        /*accentColor: AppColors.cadetBlue,
        focusColor: AppColors.cadetBlue,
        hoverColor: AppColors.cadetBlue,
        backgroundColor: AppColors.cadetBlue,
        applyElevationOverlayColor: true,
        buttonColor: AppColors.cadetBlue,
        canvasColor: AppColors.cadetBlue,
        cardColor: AppColors.cadetBlue,
        cursorColor: AppColors.cadetBlue,
        dialogTheme: DialogTheme(
          //backgroundColor: Colors.red,
          contentTextStyle: TextStyle(fontSize: 12.0, color: Colors.blue),
          titleTextStyle: TextStyle(fontSize: 12.0, color: Colors.blue),
        ),
        highlightColor: AppColors.cadetBlue,
        secondaryHeaderColor: AppColors.cadetBlue,
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
          onSurface: AppColors.raisinBlack,
          onBackground: AppColors.raisinBlack,
          onError: AppColors.raisinBlack,
          brightness: Brightness.light,
        ),*/
        dialogBackgroundColor: AppColors.lightPeriwinkle,
        scaffoldBackgroundColor: AppColors.lightPeriwinkle,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: Routes.materialRoutes,
    );
  }
}
