import 'package:news_app/Theme/theme.dart';
import 'package:news_app/screens/homepage.dart';
import 'package:news_app/services/api_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'Theme/customtheme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider.value(
        value: ApiManager(),
      ),
      ChangeNotifierProvider(
        create: (_) => CustomTheme(),
      ),
    ], child: App());
  }
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: Provider.of<CustomTheme>(context).isDarkTheme
          ? ThemeMode.dark
          : ThemeMode.light,
      home: HomePage(),
    );
  }
}
