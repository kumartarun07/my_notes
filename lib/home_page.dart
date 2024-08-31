import 'dart:math';
import 'package:flutter/material.dart';
import 'package:my_notes/add_notes.dart';
import 'package:my_notes/data/local/note_model.dart';
import 'package:provider/provider.dart';

import 'data/local/db_provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
{
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  @override
  void initState() {
    super.initState();
    context.read<DbProvider>().getintialiazeNote();
  }
  @override
  Widget build(BuildContext context)
  {

      return Scaffold(backgroundColor: Color(0xff252525),
         appBar: AppBar(backgroundColor: Color(0xff252525),
           leadingWidth: 150,toolbarHeight: 60,
           leading: Padding(
             padding: const EdgeInsets.only(left: 5.0,top: 10),
             child: Text("Notes",style: TextStyle(fontSize: 35,color: Colors.white),),
           ),
          actions: [
            Container(height: 50,width: 50,margin: EdgeInsets.all(5),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0xff3B3B3B)),
              child: Icon(Icons.search,size: 25,color: Colors.white,),
            )
          ],
         ),
        body: Consumer<DbProvider>(builder: (_,provider,___){
          List<NoteModel>allNotes = context.read<DbProvider>().getNotes();
          return allNotes.isNotEmpty ? GridView.builder(
            itemCount: allNotes.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,mainAxisSpacing:10,mainAxisExtent: 200
            ),
            itemBuilder: (_,index){
              //  List<NoteModel>allNotes=[];
              return  Container(width: 200,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                      color: Colors.primaries[Random().nextInt(Colors.primaries.length)]
                  ),
                  child: InkWell(onTap: ()
                  {
                   /* titleController.text = allNotes[index].title;
                    descController.text  = allNotes[index].desc;*/
                    Navigator.push(context, MaterialPageRoute(builder:
                        (context)=>AddNotes(isUpdate: true,sno: allNotes[index].sno,
                        title: allNotes[index].title,desc: allNotes[index].desc,
                        )));
                  },
                    child: Stack(alignment: Alignment.topRight,
                      children: [
                        Container(width: 150,margin: EdgeInsets.all(50),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(allNotes[index].title,
                                style: TextStyle(fontSize: 25,color: Colors.black),),
                              Text(allNotes[index].desc,maxLines: 2,
                                style: TextStyle(fontSize: 15,color: Colors.black),),
                            ],
                          ),
                        ),
                        IconButton(onPressed: (){
                          context.read<DbProvider>().delete(allNotes[index].sno!);
                        },
                            icon: Icon(Icons.dangerous,size: 30,color: Colors.white,))
                      ],),
                  )
              );
            },
          ):
          Center(child: Text("No Notes Found Yet",style: TextStyle(fontSize: 20,color: Colors.white70),));
        },),
        floatingActionButton: FloatingActionButton(onPressed: (){
          titleController.clear();
          descController.clear();
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNotes()));
        },
          child:Icon(Icons.notes,size: 40,color: Colors.white,),backgroundColor: Colors.black,),

      );
  }
}
