//@dart=2.9
import 'package:flutter/material.dart';
import 'package:projetolp4/provider/provider_usuario.dart';
import 'package:projetolp4/view/inicio.dart';
import 'package:projetolp4/view/tela_login.dart';
import 'package:projetolp4/view/telausuario.dart';
import 'package:projetolp4/view/telaDetalheUsuario.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(MultiProvider(
    providers:[
      //ChangeNotifierProvider(create: (context) => AuthService()),
      ChangeNotifierProvider(create: (context) => UsuarioModel()),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => const TelaLogin(),
        "/telausuario": (context) => const telausuario(),
        "/inicio": (context) => const Inicio(),
        "/teladetalheusuario": (context) => const telaDetalheUsuario(),
      }
    ),
  ));
}