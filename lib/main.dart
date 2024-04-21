import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:iservice_application/Views/main-page-establishment.dart';
import 'Views/main-page-client.dart';
import 'Views/Establishment_MyEstablishment/review-page.dart';
import 'Views/Establishment_Services/register-services.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('pt', 'BR'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
      title: 'iService',
      theme: ThemeData(),
      home: MainPageClient(),
    );
  }
}
