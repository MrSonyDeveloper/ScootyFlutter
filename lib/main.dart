
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:scooty/model/local_storage.dart';
import 'package:scooty/screens/main_screen.dart';
import 'package:scooty/screens/start_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

String token = "";

void main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage().getToken().then((String result){
   token = result;
  });
  var mySystemTheme = SystemUiOverlayStyle.light
      .copyWith(systemNavigationBarColor: Colors.black);
  SystemChrome.setSystemUIOverlayStyle(mySystemTheme);
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
     const MyApp({Key? key, token}) : super(key: key);
  @override
   build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scooty',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ru', ''),
      ],
      theme: ThemeData(
        fontFamily: 'CeraPro',
        primaryColor: const Color.fromRGBO(38, 38, 38, 0),
        backgroundColor: const Color.fromRGBO(38, 38, 38, 0),
        textTheme: const TextTheme(
          subtitle1: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          subtitle2: TextStyle(fontSize: 15),
          bodyText1: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          bodyText2: TextStyle(),
        ).apply(
          bodyColor: Colors.white,
          displayColor: Colors.blue,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                primary: Colors.yellow,
                onPrimary: Colors.black,
                textStyle: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold))),
      ),

      home: _getStartupScreen(),
    );
  }

   Widget _getStartupScreen()   {
      if (token != "") {
        return MainScreen();
      } else {
        return const StartScreen();
      }
    }
}
