import 'package:flutter/material.dart';
import 'package:test_impack/services/AppTheme.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = AppTheme(context);
    return Scaffold(
      backgroundColor: theme.colorPrimary,
      body: Center(
          child: Row(
        children: const <Widget>[
          Spacer(flex: 150),
          Flexible(
            flex: 730,
            child: FlutterLogo(
              size: double.infinity,
              style: FlutterLogoStyle.horizontal,
              textColor: Colors.white,
            ),
          ),
          Spacer(flex: 200),
        ],
      )),
    );
  }
}

class FutureSplash {
  FutureSplash._();
  static final instance = FutureSplash._();

  Future initialize() async {
    await Future.delayed(const Duration(seconds: 4));
  }
}
