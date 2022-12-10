
import 'package:animation/pages/contact_details_page.dart';
import 'package:animation/pages/contact_list_page.dart';
import 'package:animation/pages/launcher_page.dart';
import 'package:animation/pages/login_page.dart';
import 'package:animation/pages/new_contact_page.dart';
import 'package:animation/provider/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers:[
      ChangeNotifierProvider(create: (context)=>ContactProvider()..getAllContacts()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  static const String routeName='/';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
        //home: NewContactPage(),
        initialRoute: LauncherPage.routeName,
        routes:{
          LoginPage.routeName:(context)=>LoginPage(),
          LauncherPage.routeName:(context)=>LauncherPage(),
          ContactListPage.routeName:(context)=>ContactListPage(),
          NewContactPage.routeName:(context)=>NewContactPage(),
          ContactDetailsPage.routeName:(context)=>ContactDetailsPage(),
        },


    );
  }
}

