import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reclamacao/screens/report_screen.dart';

import 'ajuda_screen.dart';


class LoginScreen extends StatelessWidget {
  static const String id = '/login';

  const LoginScreen({Key? key}) : super(key: key);

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
                  image: AssetImage("assets/suporte.jpg"),
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
                  Padding(
                    padding: EdgeInsets.only(left:60, bottom: 20, right: 70, top:10), //apply padding to some sides only
                    child: Text('lep',
                        maxLines: 1,
                        textAlign: TextAlign.right,
                        style: GoogleFonts.didactGothic(
                          textStyle: TextStyle(color: Colors.white70, fontSize: 110, fontWeight: FontWeight.bold),
                        )
                    ),
                  ),

                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Padding(
                          padding: EdgeInsets.only(left:60, bottom: 20, right: 60, top:10), //apply padding to some sides only
                          child: Text('Vamos te ajudar a resolver seu problema!',
                              maxLines: 3,
                              textAlign: TextAlign.left,
                              style: GoogleFonts.didactGothic(
                                textStyle: TextStyle(color: Colors.white70, fontSize: 35, height: 1.0, fontWeight: FontWeight.bold),
                              )
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left:60, bottom: 10, right: 70, top:10), //apply padding to some sides only
                          child: Text('Digite seu CPF:',
                              maxLines: 1,
                              textAlign: TextAlign.left,
                              style: GoogleFonts.didactGothic(
                                textStyle: TextStyle(color: Colors.white70, fontSize: 18, height: 1.0, fontWeight: FontWeight.bold),
                              )
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left:60, bottom: 20, right: 70 ), //apply padding to some sides only
                          child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: '000 000 000 00',
                                  border: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white70, width: 0.5),),
                                ),

                              maxLength: 11,
                              textAlign: TextAlign.left,
                              style: GoogleFonts.didactGothic(
                                textStyle: TextStyle(color: Colors.white70, fontSize: 18, height: 1.0, fontWeight: FontWeight.bold),
                              ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(left:60, bottom: 10, right: 70, top:10), //apply padding to some sides only
                          child: Text('Digite sua data de nascimento:',
                              maxLines: 1,
                              textAlign: TextAlign.left,
                              style: GoogleFonts.didactGothic(
                                textStyle: TextStyle(color: Colors.white70, fontSize: 18, height: 1.0, fontWeight: FontWeight.bold),
                              )
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left:60, bottom: 20, right: 70 ), //apply padding to some sides only
                          child: TextFormField(
                              decoration: InputDecoration(
                                hintText: '00 00 0000',
                                border: OutlineInputBorder(),
                              ),
                              maxLength: 8,
                              textAlign: TextAlign.left,
                              style: GoogleFonts.didactGothic(
                                textStyle: TextStyle(color: Colors.white70, fontSize: 18, height: 1.0, fontWeight: FontWeight.bold),
                              )
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(left:60, bottom: 20, right: 70 ), //apply padding to some sides only
                          child: Text('Não quero me identificar',
                              maxLines: 1,
                              textAlign: TextAlign.left,
                              style: GoogleFonts.didactGothic(
                                textStyle: TextStyle(color: Colors.yellow, fontSize: 18, height: 1.0, fontWeight: FontWeight.bold),
                              )
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
                              color: Colors.green,
                            ),
                            padding: EdgeInsets.only(bottom: 15, top:15), //apply padding to some sides only
                            margin: EdgeInsets.only(left:60, bottom: 10),
                            child: Text('Avançar',
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
        //
        //

        //
        //

      ),



    );
  }
}
