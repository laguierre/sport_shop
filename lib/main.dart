import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sport_shop/models/topbtn_model.dart';
import 'models/brand_model.dart';
import 'models/sizebtn_model.dart';
import 'pages/home_page.dart';
import 'theme/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white, // navigation bar color
    statusBarColor: Colors.white, // status color bar
    statusBarIconBrightness: Brightness.dark, // status bar icon color
  ));
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TopButtonModel()),
        ChangeNotifierProvider(create: (_) => SizeButtonModel()),
        ChangeNotifierProvider(create: (_) => BrandFilterModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sport App Flutter Demo',
        theme: myTheme,
        home: const HomePage(),
      ),
    );
  }
}
