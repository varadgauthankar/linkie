import 'package:flutter/material.dart';
import 'package:linkie/pages/home_page.dart';
import 'package:linkie/pages/preview_page.dart';
import 'package:linkie/providers/link_data_provider.dart';
import 'package:linkie/providers/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LinkDataProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, value, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            initialRoute: '/',
            routes: {
              '/': (context) => const HomePage(),
              '/preview': (context) => const PreviewPage(),
            },
            themeMode: value.themeMode,
            theme: ThemeData(
              brightness: Brightness.light,
              useMaterial3: true,
              colorSchemeSeed: const Color(0xff6750a4),
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              useMaterial3: true,
              colorSchemeSeed: const Color(0xff6750a4),
            ),
          );
        },
      ),
    );
  }
}
