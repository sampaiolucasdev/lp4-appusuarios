import 'package:projetolp4/model/Users.dart';
import'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';

class UsersDB {

  String table = "users";
  Database? _db;


  Future<Database> get db async{
    if(_db != null){
      return _db!;
    } else{
      _db = await _dbcreate();
    }
    return _db!;
  }

  Future<Database>_dbcreate() async{
    String directory = await getDatabasesPath();
    Database db = await openDatabase(join(directory, "lp.db"), version: 1,
    onCreate: (db, versao){
      return db.execute("CREATE TABLE $table(id INTEGER PRIMARY KEY AUTOINCREMENT,cpf TEXT, nome TEXT, email TEXT, avatar TEXT, login TEXT, senha TEXT)"
          );
    });
    return db;
  }

  addUser(Users u) async{
    Database db = await this.db;
    int resultado = await db.insert(table,
    {
      "cpf": u.cpf,
      "nome": u.nome,
      "email": u.email,
      "avatar": u.avatar,
      "login": u.login,
      "senha": u.senha,
    }
    );
    print("Usuário $resultado cadastrado com sucesso!");
  }
  Future <List<Users>> listUsers() async {
    Database db = await this.db;
    List list = await db.query(table);

    return List.generate(list.length, (index){
      return Users(
        id: list[index]["id"],
        cpf:list[index]["cpf"],
        nome: list[index]["nome"],
        email: list[index]["email"],
        avatar: list[index]["avatar"],
        login: list[index]["login"],
        senha: list[index]["senha"],
      );
    });
  }
  deleteUser(int id) async {
      Database db = await this.db;
      db.delete(table, where: "id = ?", whereArgs: [id]);
    }
  editUser(Users u) async {
      Database db = await this.db;
      db.update(table,
      {
       "cpf": u.cpf,
       "nome": u.nome,
       "email": u.email,
       "avatar": u.avatar,
        "login": u.login,
        "senha": u.senha,
      },
        where: "id = ?",
        whereArgs: [u.id]
      );
    }
  consultarLoginUsuario(String login, String senha) async {
      var bd = await db;

      List resultado = await bd.query(
          table,
          where: "login = ? and senha = ?",
          whereArgs: [login, senha]);

      if(resultado.isNotEmpty){
        return Users(
          id: resultado[0]["id"],
          cpf: resultado[0]["cpf"],
          nome: resultado[0]["nome"],
          email: resultado[0]["email"],
          login: resultado[0]["login"],
          senha: resultado[0]["senha"],
          avatar: resultado[0]["avatar"],
        );
      } else{
        return null;
      }
    }
  criarUsuarioAdmin() async {
      var bd = await db;

      List resultado =
          await bd.query(table, where: "Login = ?", whereArgs: ["admin"]);

      if(resultado.isEmpty){
        await bd.insert(table,{
          "cpf": "12345678910",
          "nome": "Admin",
          "email": "admin@gmail.com",
          "login": "admin",
          "senha": "123456",
          "avatar": "",
        });
      }


    }
}