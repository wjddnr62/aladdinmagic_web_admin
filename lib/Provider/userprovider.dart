import 'dart:async';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:aladdinmagic_web/Model/savedata.dart';
import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart';


class UserProvider {
  SaveData saveData = SaveData();

  Future<int> login(id, pass) async {

    print("id : ${id}, pass : ${pass}");

    final QuerySnapshot result = await firestore()
        .collection("admin")
        .where("id", "==", id)
        .where("pass", "==", pass)
        .get();

    final List<DocumentSnapshot> docs = result.docs;

    print("docs.length : ${docs.length}");

    if (docs.length == 0)
      return 0;
    else {
      html.window.localStorage['id'] = docs[0].data()['id'];
      html.window.localStorage['manager'] = docs[0].data()['manager'];
      saveData.id = docs[0].data()['id'];
      saveData.manager = docs[0].data()['manager'];
      return 1;
    }
  }

  updatePass(id) async {
      final QuerySnapshot result = await firestore()
          .collection("users")
          .where("id", "==", id)
          .get();

      final List<DocumentSnapshot> docs = result.docs;

      await firestore().collection("users").doc(docs[0].id).update(data: {'pass':"1111"});
  }

  insertPoint(id, point, saveLog) async {
    print("dataCheck : ${id}, ${point}");
    final QuerySnapshot result = await firestore()
        .collection("users")
        .where("id", "==", id)
        .get();

    final List<DocumentSnapshot> docs = result.docs;

    print("docsLength : ${docs.length}");

    int pointPlus = await docs[0].data()['point'] + int.parse(point);

    print("point : ${pointPlus}");

    print("documentId : ${await docs[0].id}");

    await firestore().collection("users").doc(docs[0].id).update(data: {'point':pointPlus});

    await firestore().collection("saveLog").add(saveLog).catchError((e) {
      print("addSaveLogError : ${e.toString()}");
    });
  }

  getData() async {
    final QuerySnapshot result = await firestore()
        .collection("users")
        .get();

    final List<DocumentSnapshot> docs = result.docs;

    for (int i = 0; i< docs.length; i++) {
      print("data : ${docs[i].data()}");
    }
  }

}
