import 'package:aladdinmagic_web/Model/savedata.dart';
import 'package:aladdinmagic_web/PassInit/passinit.dart';
import 'package:aladdinmagic_web/Point/point.dart';
import 'package:aladdinmagic_web/Util/hand_cursor.dart';
import 'package:aladdinmagic_web/Util/whiteSpace.dart';
import 'package:aladdinmagic_web/public/colors.dart';
import 'package:aladdinmagic_web/withdraw/withdraw.dart';
import 'package:flutter/material.dart';

import '../main.dart';

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  SaveData saveData = SaveData();

  List<String> menuList = List();

  customDialog(msg) {
    return showDialog(
        context: context,
        barrierDismissible: false,
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
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                "/Login", (Route<dynamic> route) => false);
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

  backHome(context) {
    saveData.id = "";
    saveData.manager = "";
    html.window.localStorage['id'] = "";
    html.window.localStorage['manager'] = "";
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Login()),
        (Route<dynamic> route) => false);
//    Navigator.of(context).pushNamedAndRemoveUntil("/Login",
//            ;
  }

  @override
  void initState() {
    super.initState();

    menuList..add("포인트 지급")
    ..add("비밀번호 초기화")
    ..add("출금관리");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("htmlData : ${html.window.localStorage['id']}");
//      if (saveData.id == null || saveData.id == "" || saveData.id.isEmpty) {
//      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Login()), (Route<dynamic> route) => false);
      if (html.window.localStorage['id'] == null ||
          html.window.localStorage['id'] == "" ||
          html.window.localStorage['id'].isEmpty) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil("/Login", (Route<dynamic> route) => false);
      }
    });
  }

  String selectMenu = "포인트 지급";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: white,
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: white,
        automaticallyImplyLeading: false,
        title: Row(
          children: <Widget>[
            Text(
              "알라딘매직",
              style: TextStyle(
                  fontSize: 20, color: black, fontWeight: FontWeight.w600),
            ),
            whiteSpaceW(10),
            Text(
              "관리자",
              style: TextStyle(fontSize: 14, color: black),
            )
          ],
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () => backHome(context),
            child: HandCursor(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(right: 15),
                child: Text(
                  "로그아웃",
                  style: TextStyle(
                      color: Colors.redAccent, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Row(
          children: <Widget>[
            Container(
              width: 200,
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemBuilder: (context, idx) {
                  return Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectMenu = "${menuList[idx]}";
                          });
                        },
                        child: HandCursor(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            color: white,
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text(
                                    menuList[idx] == "포인트 지급"
                                        ? "${menuList[idx]}"
                                        : "${menuList[idx]}",
                                    style: TextStyle(
                                        color: menuList[idx] == selectMenu ? mainColor : black,
                                        fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.start,
                                  ),
                                )),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 1,
                        color: black,
                      )
                    ],
                  );
                },
                itemCount: menuList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
              ),
            ),
            Container(
              width: 1,
              height: MediaQuery.of(context).size.height,
              color: black,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: selectMenu == "포인트 지급"
                  ? Container(
                      width: MediaQuery.of(context).size.width - 228,
                      height: MediaQuery.of(context).size.height - 16 ,
                      color: white,
                      child: Point(),
                    )
                  : selectMenu == "비밀번호 초기화" ? Container(
                width: MediaQuery.of(context).size.width - 228,
                height: MediaQuery.of(context).size.height - 16 ,
                color: white,
                child: PassInit(),
              ) : selectMenu == "출금관리" ? Container(
                width: MediaQuery.of(context).size.width - 228,
                height: MediaQuery.of(context).size.height - 16 ,
                color: white,
                child: Withdraw(),
              ) : Container(),
            )
          ],
        ),
      ),
    );
  }
}
