import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'repositories/mock_repository.dart';
import 'view/pages/home_page.dart';
import 'view_model/home_provider.dart';

void main() {
  runApp(ListenableProvider<HomeProvider>(
      create: (BuildContext context) => HomeProvider(MockRepoistory()),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = ThemeData.dark().textTheme;
    return MaterialApp(
      title: 'Test',
      theme: ThemeData.dark().copyWith(
          textTheme: GoogleFonts.archivoBlackTextTheme().copyWith(
              headline5: textTheme.headline5,
              bodyText1: textTheme.bodyText1,
              bodyText2: textTheme.bodyText2,
              subtitle1: textTheme.subtitle1,
              caption: textTheme.caption),
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: HomePage(),
    );
  }
}
