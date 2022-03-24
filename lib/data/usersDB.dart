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
      return db.execute("CREATE TABLE $table(id INTEGER PRIMARY KEY AUTOINCREMENT,cpf TEXT, nome TEXT, email TEXT, avatar TEXT)"
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
      "avatar":u.avatar,
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
      },
        where: "id = ?",
        whereArgs: [u.id]
      );
    }
}