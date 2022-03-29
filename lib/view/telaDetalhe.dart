import 'package:flutter/material.dart';
import '../model/Users.dart';

class telaDetalhe extends StatefulWidget {
  final Users usuario;
  const telaDetalhe(this.usuario, {Key? key}) : super(key: key);

  @override
  _telaDetalheState createState() => _telaDetalheState();
}

class _telaDetalheState extends State<telaDetalhe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes do Usuário")
      ),
      body: Container(
        child: Column(
          children: [
            Column(
              children: [
                widget.usuario.avatar == "" ? Icon(Icons.account_circle) :
                CircleAvatar(backgroundImage: NetworkImage(widget.usuario.avatar!),),
                Row( //REPETIR PARA CADA DETALHE (PARA FAZER)
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Nome: ", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                    Text(widget.usuario.nome!, style: TextStyle(fontSize: 15))
                  ],
                )
              ]
            )
          ]
        )
      ),
    );
  }
}
