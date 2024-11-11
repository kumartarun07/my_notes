import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'note_model.dart';

class DbHelper
{
  DbHelper ._();
  static DbHelper getInstance() => DbHelper._();

  Database? nDB;
  static final String TABLE_NOTE ="note";
  static final String COLUMN_NOTE_SNO="s_no";
  static final String COLUMN_NOTE_TITLE="title";
  static final String COLUMN_NOTE_DESC = "desc";

  Future<Database> getDB()
  async{
   if(nDB!=null)
     {
       return nDB!;
     }
   else{
     nDB = await openDB();
    return nDB!;
   }
   ///  nDB ??= await openDB();
    ///     return nDB!;
  }

  Future<Database> openDB()
  async{
    Directory appDir =  await getApplicationDocumentsDirectory();
    String dbpath =  join(appDir.path,"notes.db");
    /// create table in database
    return await openDatabase(dbpath,onCreate: (db,version){
      db.execute("create table $TABLE_NOTE ( $COLUMN_NOTE_SNO integer primary key autoincrement, "
                                            "$COLUMN_NOTE_TITLE text ,"
                                            "$COLUMN_NOTE_DESC text)");

    },version: 1,);
  }

  Future<bool> addnote({required NoteModel newnote})
  async {
           var nDB = await getDB();
           int rowsEffected = await nDB.insert(TABLE_NOTE,newnote.toMap());
           return rowsEffected>0;
  }

  Future<bool> update({required NoteModel update,required int sno})
  async{
      var nDB = await getDB();
      int rowEffected = await nDB.update(TABLE_NOTE, update.toMap(),
          where: "$COLUMN_NOTE_SNO = ?",whereArgs: ['$sno']);
      return rowEffected>0;
  }

  Future<List<NoteModel>> fetchNotes()
  async{
      var nDB = await getDB();
      var data = await nDB.query(TABLE_NOTE);
      List<NoteModel> mNotes = [];
      for(Map<String,dynamic> eachData in data)
        {
           mNotes.add(NoteModel.fromMap(eachData));
        }
      return mNotes;

  }

  Future<bool>delete({required int sno})
  async{
    var nDB = await getDB();
    int rowsEffected = await nDB.delete(TABLE_NOTE,where: "$COLUMN_NOTE_SNO=?",
        whereArgs: ["$sno"]);
    return rowsEffected>0;
  }
}