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

class Point extends StatefulWidget {
  @override
  _Point createState() => _Point();
}

class _Point extends State<Point> {
  TextEditingController _pointController = TextEditingController();

  String selectBoxValue = "포인트 지급사유 선택";
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
          Column(
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
                      height: MediaQuery.of(context).size.height - 50,
                      child: ListView(
                        children:
                            snapshot.data.docs.map((DocumentSnapshot document) {
//                            print("test ${document.data()['name']}");
                          return Column(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  insertDialog(
                                      "지급할 포인트 양과\n사유를 설정해주세요.",
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
                                          document.data()['id'],
                                          style: TextStyle(color: black),
                                        ),
                                        whiteSpaceW(10),
                                        Text(document.data()['name']),
                                        whiteSpaceW(10),
                                        Expanded(
                                          child: Text(document.data()['phone']),
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
                      ),
                    );
                  }
                  return Container();
                },
              )
            ],
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
  TextEditingController _pointController = TextEditingController();

  String selectBoxValue = "포인트 지급사유 선택";
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
          Text(
            "알림",
            style: TextStyle(
                fontWeight: FontWeight.w600, color: black, fontSize: 16),
          ),
          whiteSpaceH(20),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: Color.fromARGB(255, 167, 167, 167),
          ),
          whiteSpaceH(20),
          Text(
            widget.msg,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w600, color: black, fontSize: 16),
          ),
          whiteSpaceH(10),
          TextFormField(
            controller: _pointController,
            inputFormatters: <TextInputFormatter>[
              WhitelistingTextInputFormatter.digitsOnly
            ],
            decoration: InputDecoration(
                hintStyle: TextStyle(
                    fontSize: 14, color: Color.fromARGB(255, 167, 167, 167)),
                hintText: "지급할 포인트를 적어주세요.",
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: mainColor)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: mainColor)),
                contentPadding: EdgeInsets.only(top: 5, bottom: 10, left: 10)),
          ),
          whiteSpaceH(10),
          Container(
            width: MediaQuery.of(context).size.width,
            child: DropdownButton<String>(
              isExpanded: true,
              elevation: 2,
              style: TextStyle(color: black),
              items: <String>[
                '포인트 지급사유 선택',
                '운영팀 적립',
                '관리자 세탁 적립',
                '관리자 택배 적립',
                '관리자 꽃배달 적립',
                '관리자 대리운전 적립',
                '관리자 퀵서비스 적립',
                '관리자 렌트카 적립',
                '관리자 영화예매 적립',
                '관리자 추천인 적립'
              ].map((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(color: black),
                  ),
                );
              }).toList(),
              value: selectBoxValue,
              onChanged: (value) {
                setState(() {
                  selectBoxValue = value;
                });
              },
            ),
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

                    if (_pointController.text == null ||
                        _pointController.text == "" ||
                        _pointController.text.isEmpty) {
                      customDialog("지급할 포인트를 적어주세요.");
                    } else if (selectBoxValue == "포인트 지급사유 선택") {
                      customDialog("포인트 지급사유를\n선택해주세요.");
                    } else {
                      userProvider
                          .insertPoint(widget.id, _pointController.text, {
                        'id': widget.id,
                        'name': widget.name,
                        'phone': widget.phone,
                        'type': 0,
                        'date': formatDate,
                        'savePlace': 0,
                        'saveType': _pointController.text == "운영팀 적립"
                            ? 3
                            : _pointController.text == "관리자 세탁 적립"
                                ? 4
                                : _pointController.text == "관리자 택배 적립"
                                    ? 5
                                    : _pointController.text == "관리자 꽃배달 적립"
                                        ? 6
                                        : _pointController.text == "관리자 대리운전 적립"
                                            ? 7
                                            : _pointController.text ==
                                                    "관리자 퀵서비스 적립"
                                                ? 8
                                                : _pointController.text ==
                                                        "관리자 렌트카 적립"
                                                    ? 9
                                                    : _pointController.text ==
                                                            "관리자 영화예매 적립"
                                                        ? 10
                                                        : _pointController
                                                                    .text ==
                                                                "관리자 추천인 적립"
                                                            ? 10
                                                            : 3,
                        'point': int.parse(_pointController.text)
                      });
                      Navigator.of(context).pop();
                      customDialog("정상적으로\n적립되었습니다.");
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
        ],
      ),
    );
  }
}
