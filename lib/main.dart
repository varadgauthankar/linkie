import 'package:flutter/material.dart';
import 'package:linkie/pages/home_page.dart';
import 'package:linkie/pages/preview_page.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: ((context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          '/preview': (context) => const PreviewPage(),
        },
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: const Color(0xff6750a4),
        ),
      );
    }));
  }
}
