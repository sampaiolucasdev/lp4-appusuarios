import 'package:flutter/material.dart';
import 'package:projetolp4/data/usersDB.dart';
import 'package:projetolp4/model/Users.dart';

class Inicio extends StatefulWidget {
  const Inicio({Key? key}) : super(key: key);

  @override
  _InicioState createState() => _InicioState();
}
class _InicioState extends State<Inicio> {

  List<Users> usuarios = [];

  UsersDB db = UsersDB();

  addUser(Users u){
    db.addUser(u);
  }

  listUsers() async {
    usuarios = await db.listUsers();
    setState(() {
      usuarios;
    });
  }

  deleteUsers(int id){
    db.deleteUser(id);
  }

  updateUsers(int id, String cpf, String nome, String email){
    db.editUser(Users(id: id, cpf: cpf, nome: nome, email: email));
  }

  TextEditingController controllerAddUserCPF = TextEditingController();
  TextEditingController controllerAddUsername = TextEditingController();
  TextEditingController controllerAddEmail = TextEditingController();

  TextEditingController controllerEditUserCPF = TextEditingController();
  TextEditingController controllerEditUsername = TextEditingController();
  TextEditingController controllerEditEmail = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listUsers();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Início")
      ),
      body: Container(
        child:Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: usuarios.length,
                itemBuilder: (context, index){
                  return ListTile(
                    leading:Icon(Icons.person, color: Colors.blue),
                    title: Text(usuarios[index].nome!),
                    subtitle: Text(usuarios[index].email!),
                    trailing: Container(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed:(){
                              showDialog(
                                  context: context,
                                  builder: (context){
                                    return AlertDialog(
                                        title: const Text("Editar Usuário"),
                                        content: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children:  [
                                              TextField(
                                                  controller: controllerEditUserCPF,
                                                  keyboardType: TextInputType.number,
                                                  decoration: InputDecoration(
                                                    labelText: "CPF:",
                                                    hintText: "Digite seu CPF",
                                                  )
                                              ),
                                              TextField(
                                                  controller: controllerEditUsername,
                                                  keyboardType: TextInputType.text,
                                                  decoration: InputDecoration(
                                                    labelText: "Nome:",
                                                    hintText: "Digite seu Nome",
                                                  )
                                              ),
                                              TextField(
                                                  controller: controllerEditEmail,
                                                  keyboardType: TextInputType.emailAddress,
                                                  decoration: InputDecoration(
                                                    labelText: "E-mail:",
                                                    hintText: "Digite seu e-mail",
                                                  )
                                              )
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          ElevatedButton(
                                              onPressed: (){
                                                addUser(Users(
                                                    cpf: controllerAddUserCPF.text,
                                                    nome: controllerAddUsername.text,
                                                    email: controllerAddEmail.text)
                                                );
                                                controllerAddUsername.clear();
                                                controllerAddUserCPF.clear();
                                                controllerAddEmail.clear();
                                                listUsers();
                                                Navigator.pop(context);
                                              },
                                              child: Text("Salvar")),
                                          ElevatedButton(
                                              onPressed: (){
                                                Navigator.pop(context);
                                              },
                                              child: Text("Cancelar"))
                                        ]
                                    );
                                  }
                              );
                            },
                            icon: Icon(Icons.edit),
                            color: Colors.blue,
                          ),
                          IconButton(
                              onPressed:(){
                                deleteUsers(usuarios[index].id!);
                                listUsers();
                              },
                              icon: Icon(Icons.delete),
                            color: Colors.red,
                          ),
                        ],
                      )
                    ),
                  );
                },
              ),
            )
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(
              context: context,
              builder: (context){
                return AlertDialog(
                  title: const Text("Adicionar Usuário"),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children:  [
                        TextField(
                          controller: controllerAddUserCPF,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "CPF:",
                              hintText: "Digite seu CPF",
                          )
                        ),
                        TextField(
                          controller: controllerAddUsername,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: "Nome:",
                              hintText: "Digite seu Nome",
                            )
                        ),
                        TextField(
                            controller: controllerAddEmail,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: "E-mail:",
                              hintText: "Digite seu e-mail",
                            )
                        )
                    ],
                ),
                  ),
                  actions: [
                    ElevatedButton(
                        onPressed: (){
                          addUser(Users(
                              cpf: controllerAddUserCPF.text,
                              nome: controllerAddUsername.text,
                              email: controllerAddEmail.text)
                          );
                          controllerAddUsername.clear();
                          controllerAddUserCPF.clear();
                          controllerAddEmail.clear();
                          listUsers();
                          Navigator.pop(context);
                        },
                        child: Text("Salvar")),
                    ElevatedButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: Text("Cancelar"))
                  ]
                );
                });
        },
            child: Icon(Icons.add),
      ),
    );
  }

}
