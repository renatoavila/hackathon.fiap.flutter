import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reclamacao/models/chamado.dart';
import 'package:reclamacao/models/reclama.dart';
import 'home_screen.dart';
import 'login_screen.dart';


class AtendenteScreen extends StatefulWidget {
  static const String id = '/atendente';

  const AtendenteScreen({Key? key}) : super(key: key);

  @override
  State<AtendenteScreen> createState() => _AtendenteScreenState();
}

class _AtendenteScreenState extends State<AtendenteScreen> {

  List<Reclama> reclamaList = [];
  List<dynamic> chamadoList = [];

  final TextEditingController perguntaController =  TextEditingController();
  late Map<String, Object> emailArg;

  late String emailChamado;

  @override
  void initState() {
    super.initState();
    obterTodosChamados();
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
  Future criarNovoChamado(String email, String pergunta) async {
    final response = await Client().post(
      Uri.parse('http://144.22.210.64:9991/api/criar'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'texto': pergunta,
      }),
    );
    if (response.statusCode == 200) {
      // navigate to next page
      //Navigator.pushNamed(context, ChamadoScreen.id);

    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      _showDialog(context, "Nao foi possivel registrar sua pergunta.", "\n\nTente novamente!");
      perguntaController.clear();
    }
    setState(() => {});
  }


  //-------------------------------------
  Future obterTodosChamados() async {

    final uri = Uri.parse('http://144.22.210.64:9991/api/obterTodos');
    final response = await Client().get(uri);

    final responseJson = jsonDecode(response.body);

    if (response.statusCode == 200) {
      // navigate to next page

      chamadoList = responseJson.map(
            (json) => Chamado(
              id:  json['id'],
              email:  json['email'],
              texto:  json['texto'],
              urlImagem:  json['urlImagem'],
              dataCadastro:  DateTime.parse(json['dataCadastro']),
            ),
      )
          .toList();

    } else {
      if (response.statusCode == 404) {
        _showDialog(context, "Ainda nao existe nenhum chamado cadastrado",
            "\n\n!");
      }
      else {
        _showDialog(context, "Algo inesperado aconteceu !",
            "\n\n Por favor tente novamente!");
      }

    }
    setState(() => {});
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
                                'Abaixo a lista de chamados que requerem sua atenção!',
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

              Padding(
                padding: EdgeInsets.only(
                    left: 19, bottom: 10, right: 0, top: 15),
                  //apply padding to some sides only
                  child: Row (
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children:[
                      Container(
                        width: 135,
                        child: Text("Chamado", maxLines: 1,
                          overflow: TextOverflow.ellipsis,),
                      ),
                      Container(
                        width: 350,
                        child: Text("Pergunta", maxLines: 1,
                          overflow: TextOverflow.ellipsis,),
                      ),
                      Container(
                        width: 202,
                        child: Text("Data/Hora abertura", maxLines: 1,
                          overflow: TextOverflow.ellipsis,),
                      ),
                      Container(
                        width: 205,
                        child: Text("Tempo", maxLines: 1,
                          overflow: TextOverflow.ellipsis,),
                      ),
                      Container(
                        child: Text("Editar", maxLines: 1,
                          overflow: TextOverflow.ellipsis,),
                      )
                    ]
                  )
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: chamadoList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final qa = chamadoList[index];

                    return Card(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ListTile(
                                  title: Text(
                                      qa.id.toString().padLeft(6,"0"),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.didactGothic(
                                        textStyle: TextStyle(color: Colors.black54,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  //subtitle: Text(qa.texto),
                                  trailing: SizedBox(
                                    height: 200, width: 800,
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            width: 300,
                                            child: Text(qa.texto, maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,),
                                          ),
                                          Text(qa.dataCadastro.toString(), maxLines: 1,
                                            overflow: TextOverflow.ellipsis,),
                                          Text(qa.dataCadastro.toString(), maxLines: 1,
                                            overflow: TextOverflow.ellipsis,),
                                          IconButton(
                                            icon: Icon(Icons.edit),
                                            onPressed: () {
                                              _showDialog(context, "Voce selecionou este chamado para atualização:"+ qa.id.toString().padLeft(6,"0"),"\nEsta funcionalidade encontra-se em construção!");
                                            },
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
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.black45, width: 2),
                    padding: EdgeInsets.only(left:70, bottom: 25, right: 50, top:25),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)
                    )
                ),
                onPressed: () {
                  Navigator.pushNamed(context, HomeScreen.id);
                },
                child: Text(
                    "Sair",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.didactGothic(
                      textStyle: TextStyle(color: Colors.black54, fontSize: 20, fontWeight: FontWeight.bold),
                    )
                ),
              ),
            ]
        )
    );
  }
}
