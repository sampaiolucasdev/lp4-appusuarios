//@dart=2.9
import 'package:flutter/material.dart';
import 'package:projetolp4/view/inicio.dart';
import 'package:projetolp4/view/telausuario.dart';
import 'package:projetolp4/view/telaDetalheUsuario.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: "/telainicio",
    routes: {
      "/telausuario": (context) => const telausuario(),
      "/telainicio": (context) => const Inicio(),
      "/teladetalheusuario": (context) => const telaDetalheUsuario(),
    }
  ));
}