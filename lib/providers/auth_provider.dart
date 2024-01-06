import 'package:blood_link/hive/bankAdapter.dart';
import 'package:blood_link/hive/donorAdapter.dart';
import 'package:blood_link/models/bank.dart';
import 'package:blood_link/models/donor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AuthenticationProvider extends ChangeNotifier {
  Donor? donor;
  BloodBank? bank;
  String email = '';
  String pass = '';

  fillProfile({required String e, required String p}) {
    email = e;
    pass = p;
    notifyListeners();
  }

  saveDonor(Donor d) async {
    donor = d;
    var donorBox = Hive.box('donorBox');
    var bankBox = Hive.box('bankBox');
    // var box = await Hive.openBox<Donor>('donorBox');
    await donorBox.put('donorKey', d);

    // var box2 = await Hive.openBox<BloodBank>('bankBox');
    await bankBox.delete('bankKey');

    notifyListeners();
  }

  saveBank(BloodBank b) async {
    bank = b;
    var donorBox = Hive.box('donorBox');
    var bankBox = Hive.box('bankBox');
    // var box = await Hive.openBox<BloodBank>('bankBox');
    await bankBox.put('bankKey', b);

    // var box2 = await Hive.openBox<Donor>('donorBox');
    await donorBox.delete('donorKey');

    notifyListeners();
  }

  clearData() async {
    var donorBox = Hive.box('donorBox');
    var bankBox = Hive.box('bankBox');
    await bankBox.delete('bankKey');

    await donorBox.delete('donorKey');
    bank = null;
    donor = null;
    email = '';
    pass = '';
    notifyListeners();
  }
}
