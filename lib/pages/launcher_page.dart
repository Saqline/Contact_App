import 'package:animation/pages/contact_list_page.dart';
import 'package:animation/pages/login_page.dart';
import 'package:flutter/material.dart';

import '../auth_prefes.dart';

class LauncherPage extends StatefulWidget {
  static const String routeName='/launcher_page';

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  @override
  void initState() {
    getLoginStatus().then((value) {
     if(value){
       Navigator.pushReplacementNamed(context, ContactListPage.routeName);
     }
     else{
       Navigator.pushReplacementNamed(context, LoginPage.routeName);
     }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
