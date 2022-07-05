import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reclamacao/screens/report_screen.dart';
import 'package:reclamacao/screens/ajuda_screen.dart';
import 'package:reclamacao/screens/login_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String id = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: InkWell(
          //mainAxisAlignment: MainAxisAlignment.start,
          //children: [

          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/suporte2.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Container(
                  constraints: BoxConstraints(
                    minHeight: 650,
                    maxHeight: MediaQuery.of(context).size.height,
                  ),
                color: Colors.black54,
                width: 460,

                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left:70, bottom: 20, right: 70, top:10), //apply padding to some sides only
                            child: Text('lep',
                                maxLines: 1,
                                textAlign: TextAlign.left,
                                style: GoogleFonts.signika(
                                  textStyle: TextStyle(color: Colors.white70, fontSize: 110),
                                )
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left:70, bottom: 20, right: 70, top:10), //apply padding to some sides only
                              child: Text('Conte com um time especializado para te ajudar!',
                                maxLines: 3,
                                textAlign: TextAlign.left,
                                style: GoogleFonts.didactGothic(
                                  textStyle: TextStyle(color: Colors.white70, fontSize: 37, height: 1.0, fontWeight: FontWeight.bold),
                                )
                              ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left:70, bottom: 20, right: 70, top:10), //apply padding to some sides only
                              child: Text('Você está prestes a realizar um passo grande para o seu negócio e sabemos que dúvidas podem surgir nesse caminho, conte com a gente:',
                                maxLines: 4,
                                textAlign: TextAlign.left,
                                style: GoogleFonts.didactGothic(
                                  textStyle: TextStyle(color: Colors.white70, fontSize: 18, height: 1.0, fontWeight: FontWeight.bold),
                                )
                              ),
                          ),

                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, AjudaScreen.id);
                            },

                            child: Container(
                              width: 400,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.black45,
                              ),
                              padding: EdgeInsets.only(left:70, bottom: 15, right: 70, top:15),
                              margin: EdgeInsets.only(left:70, bottom: 10, right: 70, top:15),
                              child: Text('Sou lep',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.didactGothic(
                                    textStyle: TextStyle(color: Colors.white70, fontSize: 20, height: 1.0, fontWeight: FontWeight.bold),
                                  )

                                ),
                              ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, LoginScreen.id);
                            },

                            child: Container(
                              width: 320,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.green,
                              ),
                              padding: EdgeInsets.only(bottom: 15, top:15), //apply padding to some sides only
                              margin: EdgeInsets.only(left:70, bottom: 10),
                              child: Text('Quero ser lep',
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.didactGothic(
                                    textStyle: TextStyle(color: Colors.white70, fontSize: 20, height: 1.0, fontWeight: FontWeight.bold),
                                  )
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, ReportScreen.id);
                            },

                            child: Container(
                              width: 320,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.deepOrange,
                              ),
                              padding: EdgeInsets.only(bottom: 15, top:15), //apply padding to some sides only
                              margin: EdgeInsets.only(left:70, bottom: 10),
                              child: Text('Não sou lep',
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.didactGothic(
                                    textStyle: TextStyle(color: Colors.white70, fontSize: 20, height: 1.0, fontWeight: FontWeight.bold),
                                  )
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
