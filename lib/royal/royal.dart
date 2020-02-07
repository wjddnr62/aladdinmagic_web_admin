import 'package:aladdinmagic_web/Provider/userprovider.dart';
import 'package:aladdinmagic_web/Util/hand_cursor.dart';
import 'package:aladdinmagic_web/Util/whiteSpace.dart';
import 'package:aladdinmagic_web/public/colors.dart';
import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class Royal extends StatefulWidget {
  @override
  _Royal createState() => _Royal();
}

class _Royal extends State<Royal> {
  TextEditingController _royalController = TextEditingController();

  UserProvider userProvider = UserProvider();

  insertDialog(msg, id, name, phone) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            content: Insert(
              msg: msg,
              id: id,
              name: name,
              phone: phone,
            ),
          );
        });
  }

  TextEditingController _findIdController = TextEditingController();
  TextEditingController _findNameController = TextEditingController();
  TextEditingController _findPhoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text("■ UserList"),
//              whiteSpaceW(20),
//              Text("아이디 검색 : "),
//              whiteSpaceW(10),
//              Container(
//                width: 200,
//                height: 30,
//                child: TextFormField(
//                  controller: _findIdController,
//                  onChanged: (value) {
//                    setState(() {
//                    });
//                  },
//                  decoration: InputDecoration(
//                      hintStyle: TextStyle(
//                          fontSize: 14,
//                          color: Color.fromARGB(255, 167, 167, 167)),
//                      hintText: "아이디를 입력해 주세요.",
//                      focusedBorder: UnderlineInputBorder(
//                          borderSide: BorderSide(color: mainColor)),
//                      contentPadding: EdgeInsets.only(
//                          top: 10, bottom: 10, left: 5, right: 10)),
//                ),
//              ),
//              whiteSpaceW(20),
//              Text("닉네임 검색 : "),
//              whiteSpaceW(10),
//              Container(
//                width: 200,
//                height: 30,
//                child: TextFormField(
//                  controller: _findNameController,
//                  onChanged: (value) {
//                    setState(() {
//                    });
//                  },
//                  decoration: InputDecoration(
//                      hintStyle: TextStyle(
//                          fontSize: 14,
//                          color: Color.fromARGB(255, 167, 167, 167)),
//                      hintText: "닉네임을 입력해 주세요.",
//                      focusedBorder: UnderlineInputBorder(
//                          borderSide: BorderSide(color: mainColor)),
//                      contentPadding: EdgeInsets.only(
//                          top: 10, bottom: 10, left: 5, right: 10)),
//                ),
//              ),
              whiteSpaceW(20),
              Text("휴대폰 번호 검색 : "),
              whiteSpaceW(10),
              Container(
                width: 200,
                height: 30,
                child: TextFormField(
                  controller: _findPhoneController,
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                      hintStyle: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 167, 167, 167)),
                      hintText: "휴대폰 번호를 입력해 주세요.",
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: mainColor)),
                      contentPadding: EdgeInsets.only(
                          top: 10, bottom: 10, left: 5, right: 10)),
                ),
              ),
            ],
          ),
          whiteSpaceH(10),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: black,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                StreamBuilder(
                  stream: _findPhoneController.text == ""
                      ? firestore().collection("users").onSnapshot
                      : firestore()
                      .collection("users")
                      .where("phone", "==", _findPhoneController.text)
                      .onSnapshot,
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        width: MediaQuery.of(context).size.width - 228,
                        height: MediaQuery.of(context).size.height - 57,
                        child: ListView(
                          children:
                          snapshot.data.docs.map((DocumentSnapshot document) {
//                            print("test ${document.data()['name']}");
                            return Column(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    insertDialog(
                                        "설정할 로얄 번호를\n입력해 주세요.",
                                        document.data()['id'],
                                        document.data()['name'],
                                        document.data()['phone']);
                                  },
                                  child: HandCursor(
                                    child: Container(
                                      height: 50,
                                      color: white,
                                      child: Row(
                                        children: <Widget>[
                                          whiteSpaceW(20),
                                          Text(
                                            document.data()['id'] == null ? "" : document.data()['id'],
                                            style: TextStyle(color: black),
                                          ),
                                          whiteSpaceW(10),
                                          Text(document.data()['name'] == null ? "" : document.data()['name']),
                                          whiteSpaceW(10),
                                          Expanded(
                                            child: Text(document.data()['phone'] == null ? "" : document.data()['phone']),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            size: 14,
                                          ),
                                          whiteSpaceW(20),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 1,
                                  color: black,
                                )
                              ],
                            );
                          }).toList(),
                          shrinkWrap: true,
                        ),
                      );
                    }
                    return Container();
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Insert extends StatefulWidget {
  String msg;
  String name;
  String id;
  String phone;

  Insert({Key key, this.msg, this.name, this.id, this.phone}) : super(key: key);

  @override
  _Insert createState() => _Insert();
}

class _Insert extends State<Insert> {
  TextEditingController _royalController = TextEditingController();

  UserProvider userProvider = UserProvider();

  customDialog(msg) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            content: Container(
              width: MediaQuery.of(context).size.width / 2.5,
              height: MediaQuery.of(context).size.height / 2.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "알림",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: black,
                        fontSize: 16),
                  ),
                  whiteSpaceH(20),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 1,
                    color: Color.fromARGB(255, 167, 167, 167),
                  ),
                  whiteSpaceH(20),
                  Text(
                    msg,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: black,
                        fontSize: 16),
                  ),
                  whiteSpaceH(30),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: HandCursor(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 167, 167, 167)),
                              child: Center(
                                child: Text(
                                  "확인",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: MediaQuery.of(context).size.width / 2.5,
      height: MediaQuery.of(context).size.height / 2.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Text(
              "알림",
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: black, fontSize: 16),
            ),
          ),
          whiteSpaceH(20),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: Color.fromARGB(255, 167, 167, 167),
          ),
          whiteSpaceH(20),
          Expanded(
            child: Text(
              widget.msg,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: black, fontSize: 16),
            ),
          ),
          whiteSpaceH(10),
          Expanded(
            child: TextFormField(
              controller: _royalController,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],
              maxLength: 4,
              decoration: InputDecoration(
                  hintStyle: TextStyle(
                      fontSize: 14, color: Color.fromARGB(255, 167, 167, 167)),
                  hintText: "설정할 로얄번호를 입력해주세요.",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: mainColor)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: mainColor)),
                  contentPadding: EdgeInsets.only(top: 5, bottom: 10, left: 10)),
            ),
          ),
          whiteSpaceH(30),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: HandCursor(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 167, 167, 167)),
                        child: Center(
                          child: Text(
                            "취소",
                            style: TextStyle(
                                fontSize: 14,
                                color: white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                whiteSpaceW(5),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      DateTime now = DateTime.now();
                      String formatDate = DateFormat('yyyy.MM.dd').format(now);

                      if (_royalController.text == null ||
                          _royalController.text == "" ||
                          _royalController.text.isEmpty) {
                        customDialog("설정할 로얄번호를 입력해주세요..");
                      } else {
                        userProvider
                            .insertRoyal(widget.id, _royalController.text);
                        Navigator.of(context).pop();
                        customDialog("정상적으로\n설정되었습니다.");
                      }
                    },
                    child: HandCursor(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 167, 167, 167)),
                        child: Center(
                          child: Text(
                            "확인",
                            style: TextStyle(
                                fontSize: 14,
                                color: white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
