import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reclamacao/models/chamado.dart';
import 'package:reclamacao/models/reclama.dart';
import 'home_screen.dart';
import 'login_screen.dart';


class ChamadoScreen extends StatefulWidget {
  static const String id = '/chamado';

  const ChamadoScreen({Key? key}) : super(key: key);

  @override
  State<ChamadoScreen> createState() => _ChamadoScreenState();
}

class _ChamadoScreenState extends State<ChamadoScreen> {
  List<Reclama> reclamaList = [];
  List<dynamic> chamadoList = [];

  final TextEditingController perguntaController =  TextEditingController();

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
        _showDialog(context, "Voce ainda nao tem nenhum chamado cadastrado",
            "\n\n!");
      }
      else {
        _showDialog(context, "Algo inesperado aconteceu !",
            "\n\n Por favor tente novamente!");
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    //final  Map<String, Object>emailArg = ModalRoute.of(context)?.settings.arguments as Map<String, Object>;
    //emailChamado=emailArg!['email'] as String;

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

              //-----------------------------
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 70, bottom: 10, right: 70, top: 10),
                      child: TextField(
                        controller: perguntaController,
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


              //---------------------------------
              //  Botoes de imagem, enviar e sair
              //---------------------------------
              Row (
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [

                    OutlinedButton(
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


                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.black45, width: 2),
                            padding: EdgeInsets.only(left:70, bottom: 25, right: 50, top:25),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)
                            )
                        ),

                        onPressed: () {
                          criarNovoChamado("solicitante1@pontolep.com",perguntaController.text);
                          Navigator.pushNamed(context, HomeScreen.id);
                          _showDialog(context, "Chamado cadastrado com sucesso!", "Obrigado");

                        },

                        child: Text(
                            "Enviar",
                            textAlign: TextAlign.left,
                            style: GoogleFonts.didactGothic(
                              textStyle: TextStyle(color: Colors.black54, fontSize: 20, fontWeight: FontWeight.bold),
                            )
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
              ),

              //-----------------------------------------
              // header da lista de chamados
              //-----------------------------------------
              Padding(
                padding: EdgeInsets.only(left: 10, bottom: 20, right: 10, top: 70),
                child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children:[
                        Text('Seus chamados abertos, caso os tenha, estão listados abaixo:',
                          style: GoogleFonts.didactGothic(
                            textStyle: TextStyle(color: Colors.black54, fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5, bottom: 10, right: 5, top: 20),
                          child: Card(
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                //mainAxisSize: MainAxisSize.min,
                                children:[
                                  Container(
                                    width: 135,
                                    child: Text("Chamado", maxLines: 1,
                                        overflow: TextOverflow.ellipsis,),
                                    ),
                                  SizedBox(
                                     height: 50, width: 800,
                                      child: Row(
                                        children: [
                                          Container(
                                              width: 350,
                                              child: Text("Pergunta",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,),
                                            ),
                                            Container(
                                              width: 202,
                                              child: Text("Data/Hora abertura",
                                                maxLines: 1,
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
                                ]
                              )
                            )
                        )
                      ]
                    ),
                ),

              //-----------------------------------------
              // corpo da lista de chamados
              //-----------------------------------------
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
            ],
        )
    );
  }
}
