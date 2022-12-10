import 'package:animation/db/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/contact_model.dart';

class ContactProvider extends ChangeNotifier{
  List<ContactModel> contactList=[];

  getAllContacts() async{
    contactList= await DBHelper.getAllContacts();
    notifyListeners();
  }

  getAllFavoriteContacts() async{
    contactList= await DBHelper.getAllFavoriteContacts();
    notifyListeners();
  }

  Future<ContactModel> getContactById(int id)=>DBHelper.getContactById(id);

  Future<bool> inserContact(ContactModel contactModel) async{
    final rowId= await DBHelper.insertContact(contactModel);

    if(rowId > 0){
      contactModel.id=rowId;
      contactList.add(contactModel);
      contactList.sort((c1,c2)=>c1.name.compareTo(c2.name));
      notifyListeners();
      return true;
    }
    return false;
  }

  upDateFavorite(int id,bool favorite,int index) async{
    final value = favorite ? 0: 1;
    final rowId= await DBHelper.updateFavorite(id, value);
    if(rowId>0){
      contactList[index].favourite=!contactList[index].favourite;
      notifyListeners();
    }
  }

  deleteConact(int id) async{
    final deletedRowId= await DBHelper.deleteContact(id);
    if(deletedRowId>0){
      contactList.removeWhere((element) => element.id==id);
      notifyListeners();
    }
  }
}