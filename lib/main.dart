import 'package:flutter/material.dart';
import 'package:unn_mobile/pages/home_page.dart';
import 'package:unn_mobile/theme/dark_mode.dart';
import 'package:unn_mobile/theme/light_mode.dart';

import 'pages/login_page.dart';

void main() {
 runApp(MyApp());
}

class MyApp extends StatelessWidget {
 const MyApp({super.key});

 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     debugShowCheckedModeBanner: false,
     home: HomePage(),//LoginPage(),
     theme: lightMode,
     darkTheme: darkMode,
   );
 }
}