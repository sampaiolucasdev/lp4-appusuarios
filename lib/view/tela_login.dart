import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projetolp4/data/usersDB.dart';
import 'package:projetolp4/model/Users.dart';
import 'package:projetolp4/provider/provider_usuario.dart';
import 'package:provider/provider.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({Key? key}) : super(key: key);

  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  TextEditingController controllerUsuario = TextEditingController();
  TextEditingController controllerSenha = TextEditingController();
  var banco = UsersDB();
  Users? usuarioAutenticado;

  _autenticacao() async{
    if(controllerUsuario.text == "" || controllerSenha.text == ""){
      return showDialog(
          context: context,
          builder: (context){
        return AlertDialog(
          content: const Text("Login e senha obrigatórios!"),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: const Text("OK")
            )
          ],
        );
      });
    } else{
      var usuarioLogado = await banco.consultarLoginUsuario(
        controllerUsuario.text, controllerSenha.text
      );
      if(usuarioLogado != null){
        Provider.of<UsuarioModel>(context, listen: false).user = usuarioLogado;
        return Navigator.pushReplacementNamed(
            context,
            "/inicio"
        );
      } else{
        return showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                content: const Text("Usuário ou senha incorreta!"),
                actions: [
                  TextButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: const Text("OK"))
                ],
              );
            });
      }
    }
  }
  @override
  void initState(){
    super.initState();
    banco.criarUsuarioAdmin();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller:controllerUsuario,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.person,
                  color:Colors.blue,
                ),
                hintText: "Login",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: controllerSenha,
              keyboardType: TextInputType.visiblePassword,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.password_outlined,
                  color: Colors.blue,
                ),
                hintText: "Senha",
                border: OutlineInputBorder()
              ),
              obscureText: true,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: (){
                  _autenticacao();
                },
                child: const Text(
                  "ENTRAR",
                  style: TextStyle(
                    fontSize: 17,
                    decoration: TextDecoration.none,
                  ),
                ))
          ],
        )
      )
    );
  }
}
