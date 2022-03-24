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

  updateUsers(int id, String cpf, String nome, String email, String avatar){
    db.editUser(Users(id: id, cpf: cpf, nome: nome, email: email, avatar: avatar));
  }

  TextEditingController controllerAddUserCPF = TextEditingController();
  TextEditingController controllerAddUsername = TextEditingController();
  TextEditingController controllerAddEmail = TextEditingController();
  TextEditingController controllerAddAvatar = TextEditingController();

  TextEditingController controllerEditUserCPF = TextEditingController();
  TextEditingController controllerEditUsername = TextEditingController();
  TextEditingController controllerEditEmail = TextEditingController();
  TextEditingController controllerEditAvatar = TextEditingController();

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
                    leading: CircleAvatar(
                      child: Image.network(usuarios[index].avatar!),
                    ),
                    title: Text(usuarios[index].nome!),
                    subtitle: Text(usuarios[index].email!),
                    trailing: Container(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed:(){
                              controllerEditUserCPF.text = usuarios[index].cpf!;
                              controllerEditUsername.text = usuarios[index].nome!;
                              controllerEditEmail.text = usuarios[index].email!;
                              controllerEditAvatar.text = usuarios[index].avatar!;
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
                                                controller: controllerEditAvatar,
                                                keyboardType: TextInputType.text,
                                                decoration: InputDecoration(
                                                  labelText: "Avatar:",
                                                  hintText: "Insira o link do Avatar",
                                                  )
                                              ),
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
                                                updateUsers(usuarios[index].id!,
                                                    controllerEditUserCPF.text,
                                                    controllerEditUsername.text,
                                                    controllerEditEmail.text,
                                                    controllerEditAvatar.text,
                                                );
                                                    controllerEditUsername.clear();
                                                    controllerEditUserCPF.clear();
                                                    controllerEditEmail.clear();
                                                    controllerEditAvatar.clear();
                                                listUsers();
                                                Navigator.pop(context);
                                              },
                                              child: Text("Salvar")),
                                          ElevatedButton(
                                              onPressed: (){
                                                listUsers();
                                                Navigator.pop(context);
                                              },
                                              child: Text("Cancelar"))
                                        ]
                                    );
                                  }
                              ); //Final do Edit
                            },
                            icon: Icon(Icons.edit),
                            color: Colors.blue,
                          ),
                          IconButton(
                              onPressed:(){
                                showDialog(
                                    context:context,
                                    builder: (context){
                                      return AlertDialog(
                                        title: Text("Excluir usuário"),
                                        content: Text("Deseja excluir o usuário ${usuarios[index].nome} ?"),
                                        actions: [
                                          TextButton(
                                              onPressed: (){
                                                Navigator.pop(context);
                                              },
                                              child: Text("Não")
                                          ),
                                          TextButton(
                                              onPressed: (){
                                                deleteUsers(usuarios[index].id!);
                                                listUsers();
                                                Navigator.pop(context);
                                              },
                                              child: Text("Sim"))
                                        ]
                                      );
                                    });

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
                            controller: controllerAddAvatar,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: "Avatar:",
                              hintText: "Digite seu Avatar",
                            )
                        ),
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
                              email: controllerAddEmail.text,
                              avatar: controllerAddAvatar.text,
                            )
                          );
                          controllerAddUsername.clear();
                          controllerAddUserCPF.clear();
                          controllerAddEmail.clear();
                          controllerAddAvatar.clear();
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
