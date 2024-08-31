import 'db_helper.dart';

class NoteModel
{
  int? sno;
  String title , desc;


  NoteModel({this.sno,required this.title,required this.desc});

  /// from map to model
  factory NoteModel.fromMap(Map<String,dynamic>map)
  {
    return NoteModel(
      sno: map[DbHelper.COLUMN_NOTE_SNO],
        title: map[DbHelper.COLUMN_NOTE_TITLE],
        desc: map[DbHelper.COLUMN_NOTE_DESC]
    );
  }

  /// from model to map
   Map<String,dynamic>toMap() =>{
        DbHelper.COLUMN_NOTE_TITLE:title,
        DbHelper.COLUMN_NOTE_DESC:desc
       };

}