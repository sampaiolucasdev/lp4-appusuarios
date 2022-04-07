import 'package:flutter/material.dart';
import 'package:projetolp4/data/usersDB.dart';
import 'package:projetolp4/model/Users.dart';
import 'telaDetalheUsuario.dart';
import 'package:provider/provider.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:email_validator/email_validator.dart';

class telausuario extends StatefulWidget {
  const telausuario({Key? key}) : super(key: key);

  @override
  _telausuarioState createState() => _telausuarioState();
}
class _telausuarioState extends State<telausuario> {

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
  _formularioBusca() {
    return(
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                title: Text("Buscar Usuário"),
                content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: controllerBuscaUsuario,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            hintText: "Digite o Nome",
                            border: OutlineInputBorder()
                        ),
                      )
                    ]
                ),
                actions: [
                  ElevatedButton(
                      onPressed: (){
                        var str = controllerBuscaUsuario.text;
                        _buscarUsuario(str);
                        controllerBuscaUsuario.clear();
                        Navigator.pop(context);
                      },
                      child: Text("Buscar")),
                  ElevatedButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: Text("Cancelar"))
                ]
            )
        )
    );
  }
  _buscarUsuario(String busca) async {
    await listUsers();
    List<Users> temp = [];

    if(busca == ""){
      listUsers();
    } else{
      for(var e in usuarios){
        if(e.nome!.contains(busca) || e.email == busca || e.cpf == busca || e.login == busca){
          temp.add(
              Users(
                id: e.id,
                cpf: e.cpf,
                nome: e.nome,
                email: e.email,
                login: e.login,
                senha: e.senha,
                avatar: e.avatar,

              )
          );
        }
      } setState(() {
        usuarios = temp;
      });
    }

  }
  deleteUsers(int id){
    db.deleteUser(id);
  }
  _editarUsuario(int id, String cpf, String nome, String email, String avatar, String login, String senha) async {
    var editUsuario = Users(
        id: id,
        cpf: cpf,
        nome: nome,
        email: email,
        avatar: avatar,
        login: login,
        senha: senha
    );
    await db.editUser(editUsuario);
    await listUsers();
  }

  TextEditingController controllerAddUserCPF = TextEditingController();
  TextEditingController controllerAddUsername = TextEditingController();
  TextEditingController controllerAddEmail = TextEditingController();
  TextEditingController controllerAddAvatar = TextEditingController();
  TextEditingController controllerAddLogin = TextEditingController();
  TextEditingController controllerAddSenha = TextEditingController();

  TextEditingController controllerBuscaUsuario = TextEditingController();

  TextEditingController controllerEditUserCPF = TextEditingController();
  TextEditingController controllerEditUsername = TextEditingController();
  TextEditingController controllerEditEmail = TextEditingController();
  TextEditingController controllerEditAvatar = TextEditingController();
  TextEditingController controllerEditLogin = TextEditingController();
  TextEditingController controllerEditSenha = TextEditingController();

  final GlobalKey<FormState> _formKeyAddusuario = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyEditusuario = GlobalKey<FormState>();

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
        title: Text("Início"),
        actions: [
          IconButton(
              onPressed: (){
                _formularioBusca();
              },
              icon: Icon(Icons.search)
          ),
          IconButton(
              onPressed: (){
                listUsers();
              },
              icon: Icon(Icons.list))
        ],
      ),
      body: Container(
          child:Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: usuarios.length,
                  itemBuilder: (context, index){
                    return Card(
                      child: ListTile(
                        onTap: (){
                          Navigator.pushNamed(context, "/teladetalheusuario",
                          arguments: Users(
                            id: usuarios[index].id,
                            cpf: usuarios[index].cpf,
                            nome: usuarios[index].nome,
                            email: usuarios[index].email,
                            login: usuarios[index].login,
                            senha: usuarios[index].senha,
                            avatar: usuarios[index].avatar,
                          ));
                        },
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
                                    controllerEditLogin.text = usuarios[index].login!;
                                    controllerEditSenha.text = usuarios[index].senha!;
                                    showDialog(
                                        context: context,
                                        builder: (context){
                                          return AlertDialog(
                                              title: const Text("Editar Usuário"),
                                              content: Form(
                                                key: _formKeyEditusuario,
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children:  [
                                                      TextFormField(
                                                          controller: controllerEditAvatar,
                                                          keyboardType: TextInputType.text,
                                                          decoration: const InputDecoration(
                                                            labelText: "Avatar:",
                                                            hintText: "Insira o link do Avatar",
                                                          )
                                                      ),
                                                      TextFormField(
                                                        controller: controllerEditUserCPF,
                                                        keyboardType: TextInputType.number,
                                                        decoration: const InputDecoration(
                                                          labelText: "CPF:",
                                                          hintText: "Digite seu CPF",
                                                        ),
                                                        validator: (campoCpf){
                                                          if(campoCpf == null || campoCpf.isEmpty){
                                                            return "Digite um CPF!";
                                                          }
                                                          if(CPFValidator.isValid(campoCpf) == false){
                                                            return "Cpf digitado inválido!";
                                                          } return null;
                                                        },
                                                      ),
                                                      TextFormField(
                                                          controller: controllerEditUsername,
                                                          keyboardType: TextInputType.text,
                                                          decoration: const InputDecoration(
                                                            labelText: "Nome:",
                                                            hintText: "Digite seu Nome",
                                                          )
                                                      ),
                                                      TextFormField(
                                                          controller: controllerEditEmail,
                                                          keyboardType: TextInputType.emailAddress,
                                                          decoration: const InputDecoration(
                                                            labelText: "E-mail:",
                                                            hintText: "Digite seu e-mail",
                                                          )
                                                      ),
                                                      TextFormField(
                                                          controller: controllerEditLogin,
                                                          keyboardType: TextInputType.text,
                                                          decoration: const InputDecoration(
                                                            labelText: "Login:",
                                                            hintText: "Digite seu Login",
                                                          )
                                                      ),
                                                      TextFormField(
                                                          controller: controllerEditSenha,
                                                          keyboardType: TextInputType.visiblePassword,
                                                          decoration: const InputDecoration(
                                                            labelText: "Senha:",
                                                            hintText: "Digite sua Senha",
                                                          ), obscureText: true,
                                                          validator: (campoSenha){
                                                            if(campoSenha == null || campoSenha.isEmpty){
                                                              return "Digite uma senha!";
                                                            }
                                                            if(campoSenha.length <= 6){
                                                              return "Digite uma senha maior que 6 caracteres!";
                                                            }return null;
                                                          }
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              actions: [
                                                ElevatedButton(
                                                    onPressed: (){
                                                      if(_formKeyEditusuario.currentState!.validate()) {
                                                        _editarUsuario(
                                                          usuarios[index].id!,
                                                          controllerEditUserCPF
                                                              .text,
                                                          controllerEditUsername
                                                              .text,
                                                          controllerEditEmail.text,
                                                          controllerEditAvatar.text,
                                                          controllerEditLogin.text,
                                                          controllerEditSenha.text,
                                                        );

                                                        controllerEditUsername
                                                            .clear();
                                                        controllerEditUserCPF
                                                            .clear();
                                                        controllerEditEmail.clear();
                                                        controllerEditAvatar
                                                            .clear();
                                                        controllerEditLogin.clear();
                                                        controllerEditSenha.clear();

                                                        Navigator.pop(context);
                                                        ScaffoldMessenger.of(context).showSnackBar(
                                                            SnackBar(
                                                              action: SnackBarAction(
                                                                label: "Desfazer",
                                                                onPressed: (){
                                                                  listUsers();
                                                                },
                                                              ),
                                                              backgroundColor: Colors.green,
                                                              content: Text("Usuário ${usuarios[index].nome} alterado com sucesso!",
                                                                style: const TextStyle(
                                                                    color: Colors.white,
                                                                    fontWeight: FontWeight.bold
                                                                ),
                                                              ),
                                                            )
                                                        );
                                                      }
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
                                          Users temp = usuarios[index]; //Armazena usuário em variável temporaria
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
                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                          SnackBar(
                                                            action: SnackBarAction(
                                                              label: "Desfazer",
                                                              onPressed: (){
                                                                db.addUser(temp);
                                                                listUsers();
                                                              },
                                                            ),
                                                            backgroundColor: Colors.red,
                                                            content: Text("Usuário ${usuarios[index].nome} excluído com sucesso!",
                                                              style: const TextStyle(
                                                                  color: Colors.white,
                                                                  fontWeight: FontWeight.bold
                                                              ),
                                                            ),
                                                          )
                                                      );
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
                          leading: usuarios[index].avatar! == "" ? Icon(Icons.person, color: Colors.blue) :
                          CircleAvatar(
                              backgroundImage:(
                                  NetworkImage(usuarios[index].avatar!
                                  )),
                              onBackgroundImageError: (exception, stacktrace){
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      action: SnackBarAction(
                                        label: "Fechar",
                                        onPressed: (){},
                                      ), content: Text("Aviso: avatar do usuário ${usuarios[index].nome} não encontrado!",
                                        style: const TextStyle(
                                            color: Colors.black
                                        )),
                                    )
                                );
                              }
                          ),

                          title: Text(usuarios[index].nome!),
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
                    content: Form(
                      key:_formKeyAddusuario,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children:  [
                            TextFormField(
                                controller: controllerAddAvatar,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                  labelText: "Avatar:",
                                  hintText: "Digite seu Avatar",
                                )
                            ),
                            TextFormField(
                                controller: controllerAddUserCPF,
                                validator: (campoCpf){
                                  if(campoCpf == null || campoCpf.isEmpty){
                                    return "Digite um CPF!";
                                  }
                                  if(CPFValidator.isValid(campoCpf) == false){
                                    return "CPF digitado incorretamente!";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: "CPF:",
                                  hintText: "Digite seu CPF",
                                )
                            ),
                            TextFormField(
                                controller: controllerAddUsername,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                  labelText: "Nome:",
                                  hintText: "Digite seu Nome",
                                )
                            ),
                            TextFormField(
                                controller: controllerAddEmail,
                                validator: (campoEmail){
                                  if(campoEmail == null || campoEmail.isEmpty){
                                    return "Digite o email";
                                  }
                                  if(EmailValidator.validate(campoEmail) == false){
                                    return "Difite um email válido";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelText: "E-mail:",
                                  hintText: "Digite seu e-mail",
                                )
                            ),
                            TextFormField(
                                controller: controllerAddLogin,
                                validator: (campoLogin){
                                  if(campoLogin == null || campoLogin.isEmpty){
                                    return "Digite o Login";
                                  }
                                  if(campoLogin.length <= 5){
                                    return "O Login deve ter pelo menos 5 caracteres";
                                  }
                                },
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  labelText: "Login:",
                                  hintText: "Digite seu Login",
                                )
                            ),
                            TextFormField(
                              controller: controllerAddSenha,
                              validator:(campoSenha){
                                if(campoSenha == null || campoSenha.isEmpty){
                                  return "Digite uma senha";
                                }
                                if(campoSenha.length <= 5){
                                  return "A senha deve ter pelo menos 5 caracteres";
                                }
                              },
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                labelText: "Senha:",
                                hintText: "Digite sua Senha",
                              ), obscureText: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                          onPressed: (){
                            if(_formKeyAddusuario.currentState!.validate()) {
                              db.addUser(Users(
                                cpf: controllerAddUserCPF.text,
                                nome: controllerAddUsername.text,
                                email: controllerAddEmail.text,
                                avatar: controllerAddAvatar.text,
                                login: controllerAddLogin.text,
                                senha: controllerAddSenha.text,
                              )
                              );
                              controllerAddUsername.clear();
                              controllerAddUserCPF.clear();
                              controllerAddEmail.clear();
                              controllerAddAvatar.clear();
                              controllerAddLogin.clear();
                              controllerAddSenha.clear();

                              listUsers();
                              Navigator.pop(context);
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  action: SnackBarAction(
                                    label: "Desfazer",
                                    onPressed: (){
                                      listUsers();
                                    },
                                  ),
                                  backgroundColor: Colors.green,
                                  content: Text("Usuário salvo com sucesso!",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                )
                            );

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


