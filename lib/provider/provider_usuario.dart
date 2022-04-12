import 'package:flutter/cupertino.dart';
import '../model/Users.dart';

class UsuarioModel extends ChangeNotifier{
  Users? _user;
  Users get user => _user!;
  set user (Users u){
    _user = u;
    notifyListeners();
  }
}