import 'package:animation/pages/contact_details_page.dart';
import 'package:animation/pages/login_page.dart';
import 'package:animation/pages/new_contact_page.dart';
import 'package:animation/provider/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth_prefes.dart';

class ContactListPage extends StatefulWidget {
  static const String routeName = '/contact_list';

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  int selectedIndex=0;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Contact List"),
        actions: [
          PopupMenuButton(
              itemBuilder: (context)=> [
                PopupMenuItem(
                  onTap: (){
                    setLoginStatus(false).then((value) =>
                        Navigator.pushReplacementNamed(context, LoginPage.routeName));
                  },
                  child: const Text('Log Out'),
                )
              ],
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 10,
        shape: CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,
        child: Consumer<ContactProvider>(
          builder:(context,provider,_)=> BottomNavigationBar(
            currentIndex: selectedIndex,
            selectedItemColor: Colors.white,
            backgroundColor: Theme.of(context).primaryColor,
            onTap: (value){
              setState((){
                selectedIndex=value;
              });
              if(selectedIndex==0){
                provider.getAllContacts();
              }else if(selectedIndex==1){
                provider.getAllFavoriteContacts();
              }
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                label: 'All Contacts'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favorite'
              ),
            ],
          ),
        ),
      ),
      body: Consumer<ContactProvider>(
          builder: (context, provider, _) =>
              ListView.builder(
                  itemCount: provider.contactList.length,
                  itemBuilder: (context, index) {
                    final contact = provider.contactList[index];
                    return Dismissible(
                      key: ValueKey(contact.id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 20),
                        color: Colors.red,
                        child: const Icon(Icons.delete),
                      ),
                      confirmDismiss: _showConfirmDismiss,
                      onDismissed: (directon){
                        provider.deleteConact(contact.id!);
                      },
                      child: ListTile(
                        onTap: () =>
                            Navigator
                                .pushNamed(
                                context, ContactDetailsPage.routeName,
                                arguments: contact.id),
                        title: Text(contact.name),
                        subtitle: Text(contact.number),
                        trailing: IconButton(
                            onPressed: () {
                              provider.upDateFavorite(
                                  contact.id!, contact.favourite, index);
                            },
                            icon: Icon(contact.favourite ? Icons.favorite :
                            Icons.favorite_border)
                        ),
                      ),
                    );
                  }
              )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, NewContactPage.routeName);
        },
        child: Icon(Icons.add),

      ),
    );
  }

  Future<bool?> _showConfirmDismiss(DismissDirection direction) {
    return showDialog(
        context: context,
        builder: (context) =>AlertDialog(
          title: const Text('Delete Contact'),
          content: const Text('Are You Sure Delete This Contact'),
          actions: [
            TextButton(
                onPressed: ()=>Navigator.pop(context,false),
                child: const Text('No')) ,
            TextButton(
                onPressed: ()=>Navigator.pop(context,true),
                child: const Text('Yes'))
          ],
        ));
  }
}
