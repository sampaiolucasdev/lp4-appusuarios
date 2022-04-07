import 'package:flutter/material.dart';
import '../model/Users.dart';

class telaDetalheUsuario extends StatefulWidget {

  const telaDetalheUsuario({ Key? key}) : super(key: key);

  @override
  _telaDetalheUsuarioState createState() => _telaDetalheUsuarioState();
}

class _telaDetalheUsuarioState extends State<telaDetalheUsuario> {
  Users? usuario;
  @override
  Widget build(BuildContext context) {

    usuario = ModalRoute.of(context)!.settings.arguments as Users;
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
                    usuario!.avatar == "" ?
                    const Icon(Icons.account_circle,
                      color: Colors.blue,
                      size: 150,
                    ):
                    CircleAvatar(backgroundImage: NetworkImage(usuario!.avatar!)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Nome", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        Text(usuario!.nome!, style: const TextStyle(fontSize: 20),)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("CPF:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        Text(usuario!.cpf!, style: const TextStyle(fontSize: 20),)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Email", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        Text(usuario!.email!, style: const TextStyle(fontSize: 20),)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Login", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        Text(usuario!.login!, style: const TextStyle(fontSize: 20),)
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
