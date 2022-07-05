import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reclamacao/models/reclama.dart';

import '../models/q_and_e.dart';
import 'chamado_screen.dart';
import 'login_screen.dart';


class ReportScreen extends StatefulWidget {
  static const String id = '/report';

  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
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
                    left: 8, bottom: 10, right: 70, top: 85),
                    //apply padding to some sides only
                    child: Text(
                      'Vimos aqui que você já possui um chamado em aberto com a gente:',
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
            itemCount: reclamaList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final qa = reclamaList[index];

              return Card(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ListTile(
                      title: Text(
                        qa.cpf,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.didactGothic(
                          textStyle: TextStyle(color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                        ),
                      ),
                      subtitle: Text(qa.texto),
                      trailing: SizedBox(
                        height: 200, width: 600,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(qa.datahora, maxLines: 1,
                              overflow: TextOverflow.ellipsis,),
                            Text(qa.atendimento, maxLines: 1,
                              overflow: TextOverflow.ellipsis,),
                            Text(qa.timer, maxLines: 1,
                              overflow: TextOverflow.ellipsis,),
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {},
                              color: Theme.of(context).primaryColor,
                            ),
                          ]
                      ),
                      )
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
                'Ainda precisa de ajuda?',
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
                Navigator.pushNamed(context, ChamadoScreen.id);
              },

              child: Text(
                "CRIAR CHAMADO",
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

  void fetchReclama() async {
    //final uri = Uri.parse('https://demo7206081.mockable.io/movies');
    //Response response = await Client().get(uri);

    //final responseJson = jsonDecode(response.body);

    final String dados_qa= await rootBundle.loadString('data/reclama.json');
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
