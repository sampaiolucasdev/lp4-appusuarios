import 'package:flutter/material.dart';
import '../model/Users.dart';

class telaDetalhe extends StatefulWidget {
  final Users? usuario;
  const telaDetalhe({this.usuario, Key? key}) : super(key: key);

  @override
  _telaDetalheState createState() => _telaDetalheState();
}

class _telaDetalheState extends State<telaDetalhe> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Detalhes do Usuário"),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            bottom: const TabBar(
                tabs:[
                  Tab(icon: Icon(Icons.list_outlined,)),
                  Tab(icon: Icon(Icons.settings)),
                ]
            ),
          ),
          body: TabBarView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    widget.usuario!.avatar == "" ?
                    const Icon(Icons.account_circle,
                      color: Colors.blue,
                      size: 150,
                    ):
                    CircleAvatar(backgroundImage: NetworkImage(widget.usuario!.avatar!)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Nome", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        Text(widget.usuario!.nome!, style: const TextStyle(fontSize: 20),)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("CPF:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        Text(widget.usuario!.cpf!, style: const TextStyle(fontSize: 20),)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Email", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        Text(widget.usuario!.email!, style: const TextStyle(fontSize: 20),)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Login", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        Text(widget.usuario!.login!, style: const TextStyle(fontSize: 20),)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text("Senha", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        Text("******", style: const TextStyle(fontSize: 20),)
                      ],
                    ),
                  ],
                ),
                Text("Tab 2")
              ],
            ),
          ),
      ),
    );
  }
}
