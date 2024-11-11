import 'package:flutter/material.dart';
import 'package:my_notes/data/local/note_model.dart';
import 'package:my_notes/utils/custom_widget.dart';
import 'package:provider/provider.dart';

import 'data/local/db_provider.dart';

class AddNotes extends StatelessWidget
{
  int? sno;
  String title ,desc;
  bool isUpdate;

  AddNotes({this.isUpdate=false,this.title="", this.desc="",this.sno});

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  @override
  Widget build(BuildContext context)
  {
         if(isUpdate)
           {
             titleController.text = title;
             descController.text = desc;
           }
         return Consumer<DbProvider>(builder: (_,provider,___){
           List<NoteModel>allNotes= context.read<DbProvider>().getNotes();
           return Scaffold(backgroundColor: Color(0xff252525),
               appBar: AppBar(backgroundColor: Color(0xff252525),
                 leadingWidth: 75,
                 leading: Padding(
                   padding: const EdgeInsets.only(left: 20.0,top: 5),
                   child: Container(
                     height: 50,
                     width: 50,
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(15),
                         color: Color(0xff3B3B3B)),
                     child: IconButton(
                       onPressed: () {
                         Navigator.pop(context);
                       },
                       icon: Icon(
                         Icons.arrow_back_ios_new,
                         size: 25,
                         color: Colors.white,
                       ),
                     ),
                   ),
                 ),
                 actions: [ Padding(
                   padding: const EdgeInsets.only(right: 20.0),

                   /// update container
                   child: isUpdate ? Container(
                     width: 50,
                     height: 50,
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(15),
                         color: Color(0xff3E3E3E)),
                     child: IconButton(
                         onPressed: () {
                           if(titleController.text.isNotEmpty && descController.text.isNotEmpty)
                           {
                             context.read<DbProvider>().update(NoteModel(title: titleController.text,
                                 desc: descController.text),sno!);
                             Navigator.pop(context);
                           }
                         },
                         icon: Icon(
                           Icons.edit,
                           color: Colors.white,
                           size: 25,
                         )),
                   ):
                   /// add container
                   Container(
                     height: 50,
                     width: 120,
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(15),
                         color: Color(0xff3B3B3B)),
                     child: TextButton(
                       onPressed: () async {
                         if(titleController.text.isNotEmpty && descController.text.isNotEmpty)
                         {
                           context.read<DbProvider>().addnotes(NoteModel(title: titleController.text,
                               desc: descController.text));
                           Navigator.pop(context);
                         }
                       },
                       child: Text(
                         "Save",
                         style: TextStyle(fontSize: 20, color: Colors.white),
                       ),
                     ),
                   ),
                 )],
               ),
               body: Container(
                 margin: EdgeInsets.all(20),
                 width: double.infinity,
                 child: Column(
                   children: [
                     TextField(
                       controller: titleController,
                       decoration: InputDecoration(
                         hintText: "Title",
                         hintStyle: myTextStyle30(mColor: Colors.grey.shade500),
                         enabledBorder: InputBorder.none,
                         focusedBorder: InputBorder.none,
                         contentPadding: EdgeInsets.all(10),
                       ),
                       style: myTextStyle30(mColor: Colors.white),
                       maxLines: null,
                     ),
                     TextField(
                       controller: descController,
                       decoration: InputDecoration(
                         hintText: "Type Something....",
                         hintStyle: myTextStyle30(mColor: Colors.grey.shade500),
                         enabledBorder: InputBorder.none,
                         focusedBorder: InputBorder.none,
                         contentPadding: EdgeInsets.all(10),
                       ),
                       style: myTextStyle30(mColor: Colors.white),
                       maxLines: null,
                     ),
                   ],
                 ),
               )
           );
         });
       }
  }
