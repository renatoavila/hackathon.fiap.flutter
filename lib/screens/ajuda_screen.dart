import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:reclamacao/models/q_and_e.dart';

import 'login_screen.dart';


class AjudaScreen extends StatefulWidget {
  static const String id = '/ajuda';

  const AjudaScreen({Key? key}) : super(key: key);

  @override
  State<AjudaScreen> createState() => _AjudaScreenState();
}
class _AjudaScreenState extends State<AjudaScreen> {
  List<Q_and_E> qaList = [];

  @override
  void initState() {
    super.initState();

    fetchQA();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Column (
          children: [
            Row (
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Padding(
                    padding: EdgeInsets.only(
                        left: 70, bottom: 20, right: 70, top: 20),
                    //apply padding to some sides only
                    child: Text('lep',
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.signika(
                        textStyle: TextStyle(color: Colors.black54, fontSize: 110),
                      )
                    ),
                ),
                Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(
                            left: 90, bottom: 10, right: 70, top: 60),
                        //apply padding to some sides only
                        child: Text(
                            'Vamos Ajudá-lo a resolver seu problema',
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: GoogleFonts.didactGothic(
                              textStyle: TextStyle(color: Colors.black54,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )
                        ),
                      ),

                    Padding(
                        padding: EdgeInsets.only(
                            left: 70, bottom: 20, right: 70, top: 5),
                        //apply padding to some sides only
                        child: Text(
                            'Aqui estão respostas às perguntas mais comuns sobre o lep:',
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: GoogleFonts.didactGothic(
                              textStyle: TextStyle(color: Colors.black54,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )
                        ),
                      ),

                  ]
                )
              ]
            ),

            Expanded(
                child: ListView.separated(
                  itemCount: qaList.length,
                  itemBuilder: (context, index) {
                    final qa = qaList[index];

                  return Card(
                      child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                qa.pergunta,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Divider(),
                            ListTile(
                              subtitle: Text(
                                qa.resposta,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ]
                      )
                  );
                },

                separatorBuilder: (context, index) => const Divider(),
              ),
            ),


              Column (

                children: [
                  Image.asset('pergunta.png', height: 50),

                  Padding(
                      padding: EdgeInsets.only(left:70, bottom: 20, right: 70, top:10), //apply padding to some sides only
                      child: Text(
                        'Não encontrou a solução para o seu problema? \nConte com nosso time de especialistas para te ajudar:',
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: GoogleFonts.didactGothic(
                            textStyle: TextStyle(color: Colors.black54, fontSize: 20, fontWeight: FontWeight.bold),
                          )
                      ),
                  ),

                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.black45, width: 2),
                          padding: EdgeInsets.only(left:70, bottom: 20, right: 70, top:20),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)
                          )
                      ),

                      onPressed: () {
                        Navigator.pushNamed(context, LoginScreen.id);
                      },

                      child: Text(
                        "FALAR COM ESPECIALISTA",
                         textAlign: TextAlign.left,
                         style: GoogleFonts.didactGothic(
                            textStyle: TextStyle(color: Colors.black54, fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ),
                  ),
                  SizedBox(height: 40),
                ]
              )
           ]
         )
    );
  }

  void fetchQA() async {
    //final uri = Uri.parse('https://demo7206081.mockable.io/movies');
    //Response response = await Client().get(uri);

    //final responseJson = jsonDecode(response.body);

    final String dados_qa= await rootBundle.loadString('data/qa.json');
    final jsonResponse = await jsonDecode(dados_qa);

    qaList = jsonResponse['results']
        .map<Q_and_E>(
          (json) => Q_and_E(
        categoria: json['Categoria'],
        pergunta: json['Pergunta'],
        resposta: json['Resposta'].toString(),
      ),
    )
        .toList();

    setState(() => {});
  }
}
