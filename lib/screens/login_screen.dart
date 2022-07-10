import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../models/login.dart';
import 'atendente_screen.dart';
import 'chamado_screen.dart';


class LoginScreen extends StatefulWidget {
  static const String id = '/login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {
  static const String id = '/login';

  List<Login> loginList = [];

  //var emailDeLogin;
  //late bool atendente;

  final TextEditingController emailController =  TextEditingController();
  final TextEditingController passController =  TextEditingController();

  //-------------------------------------
  @override
  void initState() {
    super.initState();

  }

//-------------------------------------
  Future getUser(String email, String pass) async {

    final response = await http.post(
      Uri.parse('http://144.22.210.64:9999/api/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'senha': pass,
      }),
    );
    if (response.statusCode == 200) {

      final responseJson = jsonDecode(response.body);

      if(responseJson['atendente'] == true) {
         Navigator.pushNamed(context, AtendenteScreen.id);
       }else {
         print('tela login -> email:'+responseJson['email'].toString());
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChamadoScreen(email: responseJson['email'])));

      }
    }
    else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      _showDialog(context, "Usuario ou senha inválidos.", "\n\nTente novamente!");
      emailController.clear();
      passController.clear();
    }
  }

  //-------------------------------------
  Future<void> _showDialog(BuildContext context, str1, str2) async {

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Aviso !!"),
          content: new Text(str1 + " " + str2),
          actions: <Widget>[
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //-------------------------------------
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
                          child: Text('Digite seu email:',
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
                            controller: emailController,

                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white70,
                            ),

                            maxLength: 30,
                            textAlign: TextAlign.left,
                            style: GoogleFonts.didactGothic(
                              textStyle: TextStyle(color: Colors.black, fontSize: 18, height: 1.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(left:60, bottom: 10, right: 70, top:10), //apply padding to some sides only
                          child: Text('Digite sua senha',
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
                              controller: passController,
                              obscureText: true,

                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white70,
                              ),
                              maxLength: 30,
                              textAlign: TextAlign.left,
                              style: GoogleFonts.didactGothic(
                                textStyle: TextStyle(color: Colors.black45, fontSize: 18, height: 1.0, fontWeight: FontWeight.bold),
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

                        Padding(
                          padding: EdgeInsets.only(left:90, bottom: 15, right: 90, top:15),

                            child: ElevatedButton(
                              onPressed: () {
                                getUser(emailController.text, passController.text);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green, // Background color
                                alignment: Alignment.center,
                                shape: RoundedRectangleBorder( //to set border radius to button
                                      borderRadius: BorderRadius.circular(30)
                                  ),
                                  padding: EdgeInsets.only(left:90, bottom: 15, right: 90, top:15)
                              ),
                              child: Text("Avançar",
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
