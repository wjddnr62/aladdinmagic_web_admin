import 'package:aladdinmagic_web/Provider/userprovider.dart';
import 'package:aladdinmagic_web/Util/hand_cursor.dart';
import 'package:aladdinmagic_web/Util/numberFormat.dart';
import 'package:aladdinmagic_web/Util/whiteSpace.dart';
import 'package:aladdinmagic_web/public/colors.dart';
import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Withdraw extends StatefulWidget {
  @override
  _Withdraw createState() => _Withdraw();
}

class _Withdraw extends State<Withdraw> {
  UserProvider userProvider = UserProvider();

  insertDialog(
      {msg,
        code,
      id,
      name,
      phone,
      bankName,
      account,
      accountNumber,
      deductionReserve,
      depositAmount}) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            content: Insert(
              msg: msg,
              id: id,
              code: code,
              name: name,
              phone: phone,
              bankName: bankName,
              account: account,
              accountNumber: accountNumber,
              deductionReserve: deductionReserve,
              depositAmount: depositAmount,
            ),
          );
        });
  }

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
                      ? firestore()
                          .collection("withdraw")
                          .where("type", "==", 0)
                          .onSnapshot
                      : firestore()
                          .collection("withdraw")
                          .where("phone", "==", _findPhoneController.text)
                          .where("type", "==", 0)
                          .onSnapshot,
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        width: MediaQuery.of(context).size.width - 228,
                        height: MediaQuery.of(context).size.height - 57,
                        child: ListView(
                          children: snapshot.data.docs
                              .map((DocumentSnapshot document) {
                            return Column(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    insertDialog(
                                        msg: "출금신청 확인",
                                        id: document.data()['id'],
                                        phone: document.data()['phone'],
                                        code: document.data()['code'],
                                        accountNumber:
                                            document.data()['accountNumber'],
                                        name: document.data()['name'],
                                        account: document.data()['account'],
                                        bankName: document.data()['bankName'],
                                        deductionReserve:
                                            document.data()['deductionReserve'],
                                        depositAmount:
                                            document.data()['depositAmount']);
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
  String id;
  String code;
  String phone;
  String account;
  String name;
  String accountNumber;
  String bankName;
  int deductionReserve = 0;
  int depositAmount;

  Insert(
      {Key key,
      this.msg,
      this.name,
        this.code,
      this.id,
      this.phone,
      this.accountNumber,
      this.account,
      this.deductionReserve,
      this.bankName,
      this.depositAmount})
      : super(key: key);

  @override
  _Insert createState() => _Insert();
}

class _Insert extends State<Insert> {
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
                  whiteSpaceH(10),
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
      height: MediaQuery.of(context).size.height / 2,
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
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border.all(color: black),
              ),
              padding:
                  EdgeInsets.only(top: 20, bottom: 20, left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "입 금 금 액",
                          style: TextStyle(color: black, fontSize: 16),
                        ),
                      ),
                      Text(
                        numberFormat.format(widget.deductionReserve - 1000) +
                            "원",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: mainColor,
                            fontSize: 16),
                      )
                    ],
                  ),
                  whiteSpaceH(10),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "출금신청금액",
                          style: TextStyle(color: black, fontSize: 16),
                        ),
                      ),
                      Text(
                        numberFormat.format(widget.deductionReserve) + "원",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: black,
                            fontSize: 16),
                      )
                    ],
                  ),
                  whiteSpaceH(10),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "입금수수료",
                          style: TextStyle(color: black, fontSize: 16),
                        ),
                      ),
                      Text(
                        "1,000원",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: black,
                            fontSize: 16),
                      )
                    ],
                  ),
                  whiteSpaceH(10),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "입금될 은행",
                          style: TextStyle(color: black, fontSize: 16),
                        ),
                      ),
                      Text(
                        widget.bankName,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: black,
                            fontSize: 16),
                      )
                    ],
                  ),
                  whiteSpaceH(10),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "입금될 계좌",
                          style: TextStyle(color: black, fontSize: 16),
                        ),
                      ),
                      Text(
                        widget.accountNumber,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: black,
                            fontSize: 16),
                      )
                    ],
                  ),
                  whiteSpaceH(10),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "예 금 주",
                          style: TextStyle(color: black, fontSize: 16),
                        ),
                      ),
                      Text(
                        widget.account,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: black,
                            fontSize: 16),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          whiteSpaceH(10),
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
                            "닫기",
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
                      userProvider.withdrawUpdate(code: widget.code, id: widget.id, type: 1, deductionReserve: widget.deductionReserve);
                      Navigator.of(context).pop();
                      customDialog("출금완료 처리되었습니다.");
                    },
                    child: HandCursor(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 167, 167, 167)),
                        child: Center(
                          child: Text(
                            "출금완료",
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

                      userProvider.withdrawUpdate(code: widget.code, id: widget.id, type: 2, deductionReserve: widget.deductionReserve, saveLog: {
                        'id': widget.id,
                        'name': widget.name,
                        'phone': widget.phone,
                        'type': 0,
                        'date': formatDate,
                        'savePlace': 0,
                        'saveType': 13, // 출금취소 반환 금액
                        'point': widget.deductionReserve,
                        'getPointType': 0 // 0 = 본인, 1 = 추천
                      });
                      Navigator.of(context).pop();
                      customDialog("출금취소 되었습니다.");
                    },
                    child: HandCursor(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 167, 167, 167)),
                        child: Center(
                          child: Text(
                            "출금취소",
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
