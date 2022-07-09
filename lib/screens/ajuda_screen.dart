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

    //final String dados_qa= await rootBundle.loadString('data/qa.json');
    //final jsonResponse = await jsonDecode(dados_qa);
    const String dados_qa = '{"results": [{"Categoria": "Sou lep","Pergunta": "Não encontrei meu ponto","Resposta": "Na nossa plataforma você pode solicitar a verificação de um ponto! Para isso, basta preencher o formulário informando o endereço do ponte e se puder, envie uma foto para facilitar a nossa localização! Pronto! Após isso, é só aguardar que o nosso time irá realizar a validação do ponto e irá te retornar no e-mail ou celular cadastrado no formulário."}, { "Categoria": "Sou lep", "Pergunta": "Estou com problemas para acessar minha conta","Resposta": "Caso tenha esquecido seu usuário ou senha, recomendamos que clique em esqueci minha senha e siga as instruções para criar uma nova senha."},{"Categoria": "Sou lep", "Pergunta": "Tem um veiculo no meu ponto, o que fazer?","Resposta": "O seu ponto está legalizado, sendo assim, o espaço é de uso exclusivo para o seu negócio durante os dias e horários alugados, entre em contato com a policia civil ou acione a CET para que possam realizar a remoção do veiculo do seu ponto."},{"Categoria": "Quero ser lep","Pergunta": "Não estou conseguindo concluir meu cadastro","Resposta": "Para alugar um ponto, é necessário que todos os documentos exigidos na região de interesse estejam cadastrados na plataforma, verifique se digitou corretamente as informações ou se os documentos enviados estão legiveis. Caso o problema insista procure nossos especialistas."},{"Categoria": "Quero ser lep","Pergunta": "Dúvidas sobre o meu cadastro","Resposta": "Para realizar a solicitação da analise do ponto para locação, é necessário o cadastro completo de acordo com a região escolhida. Para isso, é importante verificar quais dados o ponto escolhido necessita para locação, indo para a página do ponto e selecionando ele."}, {"Categoria": "Quero ser lep","Pergunta": "Dúvidas sobre a locação do espaço público","Resposta": "Deixa que a burocracia a gente cuida para você! Com o LEP, você encontra o ponto certo para o seu negócio, solicita a locação do espaço e nós iremos realizar toda a intermediação entre seu negócio e os orgãos responsáveis, como: subprefeitura, CET, Vigilância Sanitária, etc. De acordo com as regras e normas do local. Enquanto isso, aproveite para se desenvolver na escola lep ou evoluir seu negócio com os nossos parceiros na loja lep. Bora localizar o ponto certo para o seu negócio?"},{"Categoria": "Não sou lep","Pergunta": "Tem um ambulante irregular atrapalhando o trânsito","Resposta": "Neste caso, você pode recomendar que ele procure a nossa plataforma para apoia-lo na escolha do ponto ou falar com um de nossos especialistas para identificarmos sua localização e apresentarmos pontos que estão legalizados"},{"Categoria": "Não sou lep","Pergunta": "Tem um ambulante deixando a calçada suja","Resposta": "A policia militar junto com a vigilância sanitária é responsável pela fiscalização do espaço público, mas você pode informar para nossos especialistas sua localização para que possamos notifica-lo do ocorrido."},{"Categoria": "Não sou lep","Pergunta": "Tem um ambulante vendendo produtos ilegais","Resposta": "A policia militar é a responsável pela fiscalização do espaço público, porém a venda de produtos ilegais vai contra as normas de locação do lep, caso ele seja um cliente nosso, iremos suspender a locação do ponto, para isso será necessário que você informe o local do ponto para nossos especialistas"}]}';
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
