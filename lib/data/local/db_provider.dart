import 'package:flutter/foundation.dart';
import 'db_helper.dart';
import 'note_model.dart';

class DbProvider extends ChangeNotifier
{
  DbHelper dbHelper;
  DbProvider({required this.dbHelper});
  List<NoteModel>_mnotes=[];

  /// add event
   void addnotes(NoteModel newnote)
   async{
     bool check = await dbHelper.addnote(newnote: newnote);
      if(check)
        {
           _mnotes = await dbHelper.fetchNotes();
           notifyListeners();
        }
   }

   void update(NoteModel updatednote,int sno)
   async{
     bool check = await dbHelper.update(update: updatednote, sno:sno);
     if(check)
       {
         _mnotes = await dbHelper.fetchNotes();
         notifyListeners();
       }
   }


   void delete(int sno)
   async{
     bool check = await dbHelper.delete(sno: sno);
     if(check)
       {
         _mnotes = await dbHelper.fetchNotes();
         notifyListeners();
       }
   }

   void getintialiazeNote()
   async{
     _mnotes = await dbHelper.fetchNotes();
     notifyListeners();
   }

   List<NoteModel>getNotes() => _mnotes;


}