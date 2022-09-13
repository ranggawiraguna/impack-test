import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_impack/others/AppTheme.dart';
import 'package:test_impack/pages/Home.dart';
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
        return App(snapshot: snapshot);
      },
    ),
  );
}

class App extends StatefulWidget {
  final AsyncSnapshot snapshot;
  const App({Key? key, required this.snapshot}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AppTheme theme;

  @override
  void initState() {
    theme = AppTheme(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: theme.colorPrimary,
          shadowColor: Colors.transparent,
        ),
      ),
      home: widget.snapshot.connectionState == ConnectionState.waiting
          ? const SplashScreen()
          : const Home(),
    );
  }
}
