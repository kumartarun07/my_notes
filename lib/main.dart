import 'package:flutter/material.dart';
import 'package:my_notes/data/local/db_helper.dart';
import 'package:my_notes/data/local/db_provider.dart';
import 'package:my_notes/home_page.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

void main()
{
  runApp(ChangeNotifierProvider(create: (context) =>
  DbProvider(dbHelper: DbHelper.getInstance()),child: MyApp(),));
}

class MyApp extends StatelessWidget
{  @override
  Widget build(BuildContext context)
{
   return MaterialApp(
     debugShowCheckedModeBanner: false,
     home: HomePage(),
   );
  }
}
