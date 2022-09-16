import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:test_impack/providers/Activities.dart';
import 'package:test_impack/services/AppTheme.dart';
import 'package:test_impack/pages/MainPage.dart';
import 'package:test_impack/pages/SplashScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  runApp(
    FutureBuilder(
      future: FutureSplash.instance.initialize(),
      builder: (context, AsyncSnapshot snapshot) {
        final AppTheme theme = AppTheme(context);

        return ChangeNotifierProvider(
          create: (_) => Activities(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              appBarTheme: AppBarTheme(
                color: theme.colorPrimary,
                shadowColor: Colors.transparent,
              ),
            ),
            home: snapshot.connectionState == ConnectionState.waiting
                ? const SplashScreen()
                : const MainPage(),
          ),
        );
      },
    ),
  );
}
