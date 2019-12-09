// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:aladdinmagic_web/Model/savedata.dart';
import 'package:aladdinmagic_web/Provider/userprovider.dart';
import 'package:aladdinmagic_web/Util/hand_cursor.dart';
import 'package:aladdinmagic_web/Util/whiteSpace.dart';
import 'package:aladdinmagic_web/public/routes.dart';
import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';

import 'public/colors.dart';

void main() {
  runApp(MaterialApp(
    home: Login(),
    debugShowCheckedModeBanner: false,
    routes: routes,
    theme: ThemeData(cursorColor: mainColor),
  ));
//  initializeApp(
//      apiKey: "AIzaSyAOhl74yhPU9B5LOldGH5ze19GGf1w63dU",
//      authDomain: "aladdin-ea1fb.firebaseapp.com",
//      databaseURL: "https://aladdin-ea1fb.firebaseio.com",
//      projectId: "aladdin-ea1fb",
//      storageBucket: "aladdin-ea1fb.appspot.com");
}

class Login extends StatefulWidget {
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  TextEditingController _idController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  FocusNode _passFocus = FocusNode();
  FocusNode _idFocus = FocusNode();

  UserProvider userProvider = UserProvider();
  SaveData saveData = SaveData();

  @override
  void initState() {
    super.initState();

    saveData = SaveData();
    userProvider = UserProvider();

//    userProvider.getData();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("saveDataC : ${html.window.localStorage['id']}");
//      if (saveData.id != null && saveData.id != "" && saveData.id.isNotEmpty) {
      if (html.window.localStorage['id'] != null && html.window.localStorage['id'] != "" && html.window.localStorage['id'].isNotEmpty) {
        Navigator.of(context) .pushNamedAndRemoveUntil("/Home", (Route<dynamic> route) => false);
      }
    });
  }

  customDialog(msg) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            content: Container(
              width: MediaQuery.of(context).size.width / 2.5,
              height: MediaQuery.of(context).size.height / 2,
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

  login(id, pass) async {
    userProvider.login(id, pass).then((value) {
      if (value == 0) {
        customDialog("아이디 혹은 비밀번호를\n잘못 입력하셨거나\n등록되지 않은 회원 입니다.");
      } else {
        print("check : " + saveData.id + ", " + saveData.manager);
        print("ok");
        Navigator.of(context).pushReplacementNamed("/Home");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    document.addEventListener('keydown', (dynamic event) {
      if (_idFocus.hasFocus) {
        if (event.code == 'Tab') {
          event.preventDefault();
          FocusScope.of(context).requestFocus(_passFocus);
        }
      }
    });

    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              whiteSpaceH(MediaQuery.of(context).size.height / 5),
              Text(
                "알라딘매직 어드민",
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.w600, color: black),
              ),
              whiteSpaceH(25),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 5,
                    right: MediaQuery.of(context).size.width / 5),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  decoration:
                      BoxDecoration(border: Border.all(color: black, width: 1)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          whiteSpaceW(20),
                          Image.asset(
                            "assets/appIcon/app_icon.png",
                            width: 80,
                          ),
                          whiteSpaceW(30),
                          Flexible(
                            child: Container(
                              width: 400,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Icon(
                                        Icons.check,
                                        size: 14,
                                      ),
                                      whiteSpaceW(10),
                                      Text("아이디(ID)"),
                                      whiteSpaceW(30),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          width: 200,
                                          height: 30,
                                          child: TextFormField(
                                            controller: _idController,
                                            focusNode: _idFocus,
                                            onFieldSubmitted: (value) {
                                              FocusScope.of(context)
                                                  .requestFocus(_passFocus);
                                            },
                                            decoration: InputDecoration(
                                                hintStyle: TextStyle(
                                                    fontSize: 14,
                                                    color: Color.fromARGB(
                                                        255, 167, 167, 167)),
                                                hintText: "아이디를 입력해 주세요.",
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: mainColor)),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: mainColor)),
                                                contentPadding: EdgeInsets.only(
                                                    top: 5,
                                                    bottom: 10,
                                                    left: 10)),
                                          ),
                                        ),
                                      ),
                                      whiteSpaceW(10),
                                    ],
                                  ),
                                  whiteSpaceH(10),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Icon(
                                        Icons.check,
                                        size: 14,
                                      ),
                                      whiteSpaceW(10),
                                      Text("비밀번호"),
                                      whiteSpaceW(40),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          width: 200,
                                          height: 30,
                                          child: TextFormField(
                                            focusNode: _passFocus,
                                            controller: _passController,
                                            obscureText: true,
                                            onFieldSubmitted: (value) {
                                              login(_idController.text, value);
                                            },
                                            decoration: InputDecoration(
                                                hintStyle: TextStyle(
                                                    fontSize: 14,
                                                    color: Color.fromARGB(
                                                        255, 167, 167, 167)),
                                                hintText: "비밀번호를 입력해 주세요.",
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: mainColor)),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: mainColor)),
                                                contentPadding: EdgeInsets.only(
                                                    top: 5,
                                                    bottom: 10,
                                                    left: 10)),
                                          ),
                                        ),
                                      ),
                                      whiteSpaceW(10),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 70,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              onPressed: () {
                                login(_idController.text, _passController.text);
                              },
                              elevation: 0.0,
                              color: Color.fromARGB(255, 219, 219, 219),
                              child: Center(
                                child: Text(
                                  "확 인",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: black,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                          whiteSpaceW(30)
                        ],
                      ),
                      whiteSpaceH(50),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Text(
                            "아이디(ID) / 비밀번호를 분실하신 경우 총 책임자에게 문의해 주시기 바랍니다",
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
