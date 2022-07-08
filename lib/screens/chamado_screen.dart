import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reclamacao/models/reclama.dart';

import '../models/q_and_e.dart';
import 'login_screen.dart';


class ChamadoScreen extends StatefulWidget {
  static const String id = '/chamado';

  const ChamadoScreen({Key? key}) : super(key: key);

  @override
  State<ChamadoScreen> createState() => _ChamadoScreenState();
}

class _ChamadoScreenState extends State<ChamadoScreen> {
  List<Reclama> reclamaList = [];

  @override
  void initState() {
    super.initState();
    fetchReclama();
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
                                left: 60, bottom: 10, right: 70, top: 85),
                            //apply padding to some sides only
                            child: Text(
                                'Digite aqui a sua pergunta!',
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

        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 70, bottom: 10, right: 550, top: 85),
                child: TextField(
                  maxLength: 13,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Digite seu celular',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 70, bottom: 10, right: 70, top: 10),
                child: TextField(
                  minLines: 3,
                  maxLines: 5,
                  maxLength: 500,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Descreve aqui de forma detalhada a sua questão',
                  ),
                ),
              ),
            ]
        ),

              Row (
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [

                    Padding(
                        padding: EdgeInsets.only(
                            left: 70, bottom: 10, right: 70, top: 85),
                        //apply padding to some sides only
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.black45, width: 2),
                              padding: EdgeInsets.only(left:70, bottom: 25, right: 50, top:25),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)
                              )
                          ),

                          onPressed: () {
                            Navigator.pushNamed(context, LoginScreen.id);
                          },

                          child: Text(
                              "Enviar",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.didactGothic(
                                textStyle: TextStyle(color: Colors.black54, fontSize: 20, fontWeight: FontWeight.bold),
                              )
                          ),
                        ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            left: 70, bottom: 10, right: 70, top: 85),
                        //apply padding to some sides only
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.black45, width: 2),
                              padding: EdgeInsets.only(left:70, bottom: 15, right: 70, top:15),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)
                              )
                          ),

                          onPressed: () {
                            Navigator.pushNamed(context, LoginScreen.id);
                          },

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset('anexarImagem.png', scale: 1.5),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 20, bottom: 10, right: 2, top: 10),
                                //apply padding to some sides only
                                child: Text(
                                  "Anexar Imagem",
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.didactGothic(
                                    textStyle: TextStyle(color: Colors.black54, fontSize: 20, fontWeight: FontWeight.bold),
                                  )
                                ),
                              ),
                          ]
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                  ]
              )
            ]
        )
    );
  }

  void fetchReclama() async {
    //final uri = Uri.parse('https://demo7206081.mockable.io/movies');
    //Response response = await Client().get(uri);

    //final responseJson = jsonDecode(response.body);

    //final String dados_qa= await rootBundle.loadString('data/reclama.json');
    const String dados_qa='{"results": [{"Cpf": "11111111111","Texto": "Como faco para usar o App","DataHora": "03072022","Atendimento": "Nao","Timer": "30"},{"Cpf": "22222222222","Texto": "Qual a area de cobertura do app","DataHora": "2072022","Atendimento": "Nao","Timer": "60"},{"Cpf": "33333333333","Texto": "Voces atendem apenas em Sao Paulo","DataHora": "3072022","Atendimento": "Nao","Timer": "20"},{"Cpf": "11111111111","Texto": "Voces tem tambem acesso a espacos privados?","DataHora": "4072022","Atendimento": "Nao","Timer": "60"}]}';
    final jsonResponse = await jsonDecode(dados_qa);

    reclamaList = jsonResponse['results']
        .map<Reclama>(
          (json) => Reclama(
        cpf: json['Cpf'],
        texto: json['Texto'],
        datahora: json['DataHora'],
        atendimento: json['Atendimento'],
        timer: json['timer'].toString(),
      ),
    ).toList();
    setState(() => {});
  }
}
