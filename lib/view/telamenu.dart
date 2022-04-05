import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.white30,
            ),
            child:
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text("Lucas", style: const TextStyle(fontSize: 18)),
              subtitle: Text("Eduardo"),
              trailing: Container(
                padding: const EdgeInsets.only(left: 20),
                width: 40,
                child: IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.blue,
                  ),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
              ),
            ),

          ),
          ListTile(
            onTap: (){
              Navigator.pushNamed(context, "/telainicio");
            },
            leading: const Icon(Icons.home),
            title: const Text("Início"),
          ),
          ListTile(
            onTap: (){},
            leading: const Icon(Icons.apartment),
            title: const Text("Fornecedores"),
          ),
          ListTile(
            onTap: (){
              Navigator.pushNamed(context, "/telausuario");
            },
            leading: const Icon(Icons.person),
            title: const Text("Usuários"),
          ),
          const Divider(),
            ListTile(
              onTap: (){
                Navigator.pushReplacementNamed(context, "/telainicio");
              },
              leading: const Icon(Icons.logout),
              title: const Text("Sair"),
            ),
        ],
      )
    );
  }
}
