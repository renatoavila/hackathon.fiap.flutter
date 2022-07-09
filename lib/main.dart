import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:reclamacao/screens/ajuda_screen.dart';
import 'package:reclamacao/screens/atendente_screen.dart';
import 'package:reclamacao/screens/home_screen.dart';
import 'package:reclamacao/screens/login_screen.dart';
import 'package:reclamacao/screens/report_screen.dart';
import 'package:reclamacao/screens/chamado_screen.dart';
import 'package:reclamacao/screens/imagem_screen.dart';





void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (context) => const HomeScreen(),
        AjudaScreen.id: (context) => const AjudaScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        ReportScreen.id: (context) => const ReportScreen(),
        ChamadoScreen.id: (context) => ChamadoScreen(email: '',),
        AtendenteScreen.id: (context) =>  AtendenteScreen(),


        //MoviesScreen.id: (context) => MoviesScreen(),
      },
    );
  }
}
