import 'package:aladdinmagic_web/Util/hand_cursor.dart';
import 'package:aladdinmagic_web/Util/numberFormat.dart';
import 'package:aladdinmagic_web/Util/whiteSpace.dart';
import 'package:aladdinmagic_web/public/colors.dart';
import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class MemberManager extends StatefulWidget {
  @override
  _MemberManager createState() => _MemberManager();
}

class _MemberManager extends State<MemberManager> {
  bool normal = true;
  bool abo = true;
  bool abm = true;

  TextEditingController _dateStart = TextEditingController();
  TextEditingController _dateEnd = TextEditingController();
  TextEditingController _searchContorller = TextEditingController();

  String _searchItem = "ID";

  int searchCount = 0;

  bool search = false;

  List<int> page = [];
  int pageLength = 10;
  int selectPageNumber = 1;
  int searchPageLength = 20;

  setCount() async {
    if (_searchContorller.text.isEmpty &&
        (_dateStart.text.isEmpty || _dateEnd.text.isEmpty)) {
      print("re1");
      final QuerySnapshot result = await firestore().collection("users").get();
      final List<DocumentSnapshot> docs = result.docs;
      setState(() {
        searchCount = docs.length;
        for (int i = 0; i < (searchCount / 20 + 1).toInt(); i++) {
          page.add(i);
        }
        print('pageLength : ${page.length}');
      });
    } else if (_searchContorller.text.isEmpty &&
        (_dateStart.text.isNotEmpty && _dateEnd.text.isNotEmpty)) {
      print("re2");
      final QuerySnapshot result = await firestore()
          .collection("users")
          .where("signDate", ">=", _dateStart.text)
          .where("signDate", "<=", _dateEnd.text)
          .get();
      final List<DocumentSnapshot> docs = result.docs;
      setState(() {
        searchCount = docs.length;
      });
    } else if (_searchContorller.text.isNotEmpty &&
        (_dateStart.text.isEmpty || _dateEnd.text.isEmpty)) {
      if (_searchItem == "ID") {
        print("re3");
        final QuerySnapshot result = await firestore()
            .collection("users")
            .where("id", "==", _searchContorller.text)
            .get();
        final List<DocumentSnapshot> docs = result.docs;
        setState(() {
          searchCount = docs.length;
        });
      } else if (_searchItem == "성명") {
        print("re4");
        final QuerySnapshot result = await firestore()
            .collection("users")
            .where("name", "==", _searchContorller.text)
            .get();
        final List<DocumentSnapshot> docs = result.docs;
        setState(() {
          searchCount = docs.length;
        });
      } else if (_searchItem == "휴대폰번호") {
        print("re5");
        final QuerySnapshot result = await firestore()
            .collection("users")
            .where("phone", "==", _searchContorller.text)
            .get();
        final List<DocumentSnapshot> docs = result.docs;
        setState(() {
          searchCount = docs.length;
        });
      }
    } else if (_searchContorller.text.isNotEmpty &&
        (_dateStart.text.isNotEmpty && _dateEnd.text.isNotEmpty)) {
      if (_searchItem == "ID") {
        print("re6");
        final QuerySnapshot result = await firestore()
            .collection("users")
            .where("signDate", ">=", _dateStart.text)
            .where("signDate", "<=", _dateEnd.text)
            .where("id", "==", _searchContorller.text)
            .get();
        final List<DocumentSnapshot> docs = result.docs;
        setState(() {
          searchCount = docs.length;
        });
      } else if (_searchItem == "성명") {
        print("re7");
        final QuerySnapshot result = await firestore()
            .collection("users")
            .where("signDate", ">=", _dateStart.text)
            .where("signDate", "<=", _dateEnd.text)
            .where("name", "==", _searchContorller.text)
            .get();
        final List<DocumentSnapshot> docs = result.docs;
        setState(() {
          searchCount = docs.length;
        });
      } else if (_searchItem == "휴대폰번호") {
        print("re8");
        final QuerySnapshot result = await firestore()
            .collection("users")
            .where("signDate", ">=", _dateStart.text)
            .where("signDate", "<=", _dateEnd.text)
            .where("phone", "==", _searchContorller.text)
            .get();
        final List<DocumentSnapshot> docs = result.docs;
        setState(() {
          searchCount = docs.length;
        });
      }
    } else {
      print("re9");
      final QuerySnapshot result = await firestore().collection("users").get();
      final List<DocumentSnapshot> docs = result.docs;
      setState(() {
        searchCount = docs.length;
      });
    }
  }

  setStream() {
    if (_searchContorller.text.isEmpty &&
        (_dateStart.text.isEmpty || _dateEnd.text.isEmpty)) {
      print("return1");

      return firestore().collection("users").onSnapshot;
    } else if (_searchContorller.text.isEmpty &&
        (_dateStart.text.isNotEmpty && _dateEnd.text.isNotEmpty)) {
      print("return2");
      return firestore()
          .collection("users")
          .where("signDate", ">=", _dateStart.text)
          .where("signDate", "<=", _dateEnd.text)
          .onSnapshot;
    } else if (_searchContorller.text.isNotEmpty &&
        (_dateStart.text.isEmpty || _dateEnd.text.isEmpty)) {
      if (_searchItem == "ID") {
        print("return3");
        return firestore()
            .collection("users")
            .where("id", "==", _searchContorller.text)
            .onSnapshot;
      } else if (_searchItem == "성명") {
        print("return4");
        return firestore()
            .collection("users")
            .where("name", "==", _searchContorller.text)
            .onSnapshot;
      } else if (_searchItem == "휴대폰번호") {
        print("return5");
        return firestore()
            .collection("users")
            .where("phone", "==", _searchContorller.text)
            .onSnapshot;
      }
    } else if (_searchContorller.text.isNotEmpty &&
        (_dateStart.text.isNotEmpty && _dateEnd.text.isNotEmpty)) {
      if (_searchItem == "ID") {
        print("return6");
        return firestore()
            .collection("users")
            .where("signDate", ">=", _dateStart.text)
            .where("signDate", "<=", _dateEnd.text)
            .where("id", "==", _searchContorller.text)
            .onSnapshot;
      } else if (_searchItem == "성명") {
        print("return7");
        return firestore()
            .collection("users")
            .where("signDate", ">=", _dateStart.text)
            .where("signDate", "<=", _dateEnd.text)
            .where("name", "==", _searchContorller.text)
            .onSnapshot;
      } else if (_searchItem == "휴대폰번호") {
        print("return8");
        return firestore()
            .collection("users")
            .where("signDate", ">=", _dateStart.text)
            .where("signDate", "<=", _dateEnd.text)
            .where("phone", "==", _searchContorller.text)
            .onSnapshot;
      }
    } else {
      print("return9");
      return firestore().collection("users").onSnapshot;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 0, left: 0),
            child: Text(
              "회원관리",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: black,
                fontSize: 14,
              ),
            ),
          ),
          whiteSpaceH(10),
          Row(
            children: <Widget>[
              Container(
                width: 150,
                height: 30,
                color: Color.fromARGB(255, 205, 205, 205),
                child: Center(
                  child: Text(
                    "회원유형",
                    style: TextStyle(color: black, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
//              whiteSpaceW(15),
              Expanded(
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: Color.fromARGB(255, 219, 219, 219)),
                    color: white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Checkbox(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: normal,
                        activeColor: mainColor,
                        onChanged: (value) {
                          setState(() {
                            normal = value;
                          });
                        },
                      ),
                      Text("일반"),
                      Checkbox(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: abo,
                        activeColor: mainColor,
                        onChanged: (value) {
                          setState(() {
                            abo = value;
                          });
                        },
                      ),
                      Text("ABO"),
                      Checkbox(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: abm,
                        activeColor: mainColor,
                        onChanged: (value) {
                          setState(() {
                            abm = value;
                          });
                        },
                      ),
                      Text("ABM")
                    ],
                  ),
                ),
              )
            ],
          ),
          whiteSpaceH(1),
          Row(
            children: <Widget>[
              Container(
                width: 150,
                height: 30,
                color: Color.fromARGB(255, 205, 205, 205),
                child: Center(
                  child: Text(
                    "기간검색",
                    style: TextStyle(color: black, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: Color.fromARGB(255, 219, 219, 219)),
                    color: white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      whiteSpaceW(5),
                      Container(
                        width: 140,
                        height: 25,
                        child: TextFormField(
                          onTap: () {
                            DatePicker.showDatePicker(context,
                                minTime: DateTime(1930, 1, 1),
                                showTitleActions: true, onChanged: (date) {
                              print(
                                  "change ${date.year}.${date.month}.${date.day}");
                              if (date.month < 10) {
                                _dateStart.text =
                                    "${date.year}.0${date.month}.${date.day}";
                              } else if (date.day < 10) {
                                _dateStart.text =
                                    "${date.year}.${date.month}.0${date.day}";
                              } else if (date.month < 10 && date.day < 10) {
                                _dateStart.text =
                                    "${date.year}.0${date.month}.0${date.day}";
                              } else {
                                _dateStart.text =
                                    "${date.year}.${date.month}.${date.day}";
                              }
                            }, onConfirm: (date) {
                              print(
                                  "confirm ${date.year}.${date.month}.${date.day}");
                              if (date.month < 10) {
                                _dateStart.text =
                                    "${date.year}.0${date.month}.${date.day}";
                              } else if (date.day < 10) {
                                _dateStart.text =
                                    "${date.year}.${date.month}.0${date.day}";
                              } else if (date.month < 10 && date.day < 10) {
                                _dateStart.text =
                                    "${date.year}.0${date.month}.0${date.day}";
                              } else {
                                _dateStart.text =
                                    "${date.year}.${date.month}.${date.day}";
                              }
                            }, locale: LocaleType.ko);
                          },
                          style: TextStyle(fontSize: 14),
                          controller: _dateStart,
                          textAlign: TextAlign.center,
                          textInputAction: TextInputAction.next,
                          readOnly: true,
                          decoration: InputDecoration(
                              counterText: "",
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: mainColor)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(255, 219, 219, 219))),
                              contentPadding:
                                  EdgeInsets.only(top: 0, bottom: 10)),
                        ),
                      ),
                      whiteSpaceW(2),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _dateStart.text = "";
                          });
                        },
                        child: Center(
                          child: Icon(Icons.clear),
                        ),
                      ),
                      Icon(Icons.calendar_today),
                      Padding(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: Text(
                          "~",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                        width: 140,
                        height: 25,
                        child: TextFormField(
                          onTap: () {
                            DatePicker.showDatePicker(context,
                                minTime: DateTime(1930, 1, 1),
                                showTitleActions: true, onChanged: (date) {
                              print(
                                  "change ${date.year}.${date.month}.${date.day}");
                              if (date.month < 10) {
                                _dateEnd.text =
                                    "${date.year}.0${date.month}.${date.day}";
                              } else if (date.day < 10) {
                                _dateEnd.text =
                                    "${date.year}.${date.month}.0${date.day}";
                              } else if (date.month < 10 && date.day < 10) {
                                _dateEnd.text =
                                    "${date.year}.0${date.month}.0${date.day}";
                              } else {
                                _dateEnd.text =
                                    "${date.year}.${date.month}.${date.day}";
                              }
                            }, onConfirm: (date) {
                              print(
                                  "confirm ${date.year}.${date.month}.${date.day}");
                              if (date.month < 10) {
                                _dateEnd.text =
                                    "${date.year}.0${date.month}.${date.day}";
                              } else if (date.day < 10) {
                                _dateEnd.text =
                                    "${date.year}.${date.month}.0${date.day}";
                              } else if (date.month < 10 && date.day < 10) {
                                _dateEnd.text =
                                    "${date.year}.0${date.month}.0${date.day}";
                              } else {
                                _dateEnd.text =
                                    "${date.year}.${date.month}.${date.day}";
                              }
                            }, locale: LocaleType.ko);
                          },
                          style: TextStyle(fontSize: 14),
                          controller: _dateEnd,
                          textAlign: TextAlign.center,
                          textInputAction: TextInputAction.next,
                          readOnly: true,
                          decoration: InputDecoration(
                              counterText: "",
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: mainColor)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(255, 219, 219, 219))),
                              contentPadding:
                                  EdgeInsets.only(top: 0, bottom: 10)),
                        ),
                      ),
                      whiteSpaceW(2),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _dateEnd.text = "";
                          });
                        },
                        child: Center(
                          child: Icon(Icons.clear),
                        ),
                      ),
                      Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              )
            ],
          ),
          whiteSpaceH(1),
          Row(
            children: <Widget>[
              Container(
                width: 150,
                height: 30,
                color: Color.fromARGB(255, 205, 205, 205),
                child: Center(
                  child: Text(
                    "검색어",
                    style: TextStyle(color: black, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: Color.fromARGB(255, 219, 219, 219)),
                    color: white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      whiteSpaceW(5),
                      Container(
                        width: 150,
                        height: 25,
                        padding: EdgeInsets.only(left: 5),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromARGB(255, 167, 167, 167)),
                            borderRadius: BorderRadius.circular(3)),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          underline: Container(),
                          elevation: 0,
                          style: TextStyle(color: black),
                          items: <String>['ID', '성명', '휴대폰번호'].map((value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(color: black),
                              ),
                            );
                          }).toList(),
                          value: _searchItem,
                          onChanged: (value) {
                            setState(() {
                              _searchItem = value;
                            });
                          },
                        ),
                      ),
                      whiteSpaceW(5),
                      Container(
                        width: 300,
                        height: 25,
                        child: TextFormField(
                          style: TextStyle(fontSize: 14),
                          controller: _searchContorller,
                          textAlign: TextAlign.start,
                          decoration: InputDecoration(
                              counterText: "",
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: mainColor)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(255, 219, 219, 219))),
                              contentPadding: EdgeInsets.only(
                                  top: 0, bottom: 10, left: 5, right: 5)),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          whiteSpaceH(5),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 120,
              height: 30,
              decoration: BoxDecoration(
                  border:
                      Border.all(color: Color.fromARGB(255, 167, 167, 167))),
              child: RaisedButton(
                onPressed: () {
                  setState(() {
                    setCount();
                    search = true;
                  });
                },
                elevation: 0,
                color: Colors.transparent,
                child: Center(
                  child: Text("검색"),
                ),
              ),
            ),
          ),
          whiteSpaceH(30),
          Text(
            '검색개수 : ${numberFormat.format(searchCount)}건',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          whiteSpaceH(5),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                border: Border.all(
                    width: 1, color: Color.fromARGB(255, 167, 167, 167))),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 219, 219, 219),
                            border: Border.all(
                                color: Color.fromARGB(255, 167, 167, 167),
                                width: 0.5)),
                        child: Center(
                          child: Text(
                            "No",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 219, 219, 219),
                            border: Border.all(
                                color: Color.fromARGB(255, 167, 167, 167),
                                width: 0.5)),
                        child: Center(
                          child: Text(
                            "ID",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 219, 219, 219),
                            border: Border.all(
                                color: Color.fromARGB(255, 167, 167, 167),
                                width: 0.5)),
                        child: Center(
                          child: Text(
                            "성명",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 219, 219, 219),
                            border: Border.all(
                                color: Color.fromARGB(255, 167, 167, 167),
                                width: 0.5)),
                        child: Center(
                          child: Text(
                            "휴대폰번호",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 219, 219, 219),
                            border: Border.all(
                                color: Color.fromARGB(255, 167, 167, 167),
                                width: 0.5)),
                        child: Center(
                          child: Text(
                            "회원유형",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 219, 219, 219),
                            border: Border.all(
                                color: Color.fromARGB(255, 167, 167, 167),
                                width: 0.5)),
                        child: Center(
                          child: Text(
                            "가입유형",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 219, 219, 219),
                            border: Border.all(
                                color: Color.fromARGB(255, 167, 167, 167),
                                width: 0.5)),
                        child: Center(
                          child: Text(
                            "가입일",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                search
                    ? Container(
                        width: MediaQuery.of(context).size.width - 228,
                        child: StreamBuilder(
                          stream: setStream(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              print("error : " + snapshot.error.toString());
                            }

                            if (snapshot.hasData) {
                              print("length : ${snapshot.data.docs.length}");
                              print(
                                  "math : ${(snapshot.data.docs.length / 10 + 1).toInt()}");
                              return HandCursor(
                                child: Container(
                                    width:
                                        MediaQuery.of(context).size.width - 228,
                                    height: MediaQuery.of(context).size.height -
                                        350,
                                    child: ListView.builder(
                                        itemBuilder: (context, idx) {
                                          if (selectPageNumber > 1) {
                                            int plusIdx = searchPageLength *
                                                (selectPageNumber - 1);
                                            if (plusIdx + idx > searchCount) {
                                              return Container();
                                            } else {
                                              return Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Container(
                                                      padding: EdgeInsets.only(
                                                          top: 5, bottom: 5),
                                                      decoration: BoxDecoration(
                                                          color: white,
                                                          border: Border.all(
                                                              color:
                                                              Color.fromARGB(
                                                                  255,
                                                                  167,
                                                                  167,
                                                                  167),
                                                              width: 0.5)),
                                                      child: Center(
                                                        child: Text(
                                                          (idx + plusIdx + 1)
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight
                                                                  .w600),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Container(
                                                      padding: EdgeInsets.only(
                                                          top: 5, bottom: 5),
                                                      decoration: BoxDecoration(
                                                          color: white,
                                                          border: Border.all(
                                                              color:
                                                              Color.fromARGB(
                                                                  255,
                                                                  167,
                                                                  167,
                                                                  167),
                                                              width: 0.5)),
                                                      child: Center(
                                                        child: Text(
                                                          snapshot.data
                                                              .docs[idx + plusIdx]
                                                              .data()['id'],
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight
                                                                  .w600),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                      padding: EdgeInsets.only(
                                                          top: 5, bottom: 5),
                                                      decoration: BoxDecoration(
                                                          color: white,
                                                          border: Border.all(
                                                              color:
                                                              Color.fromARGB(
                                                                  255,
                                                                  167,
                                                                  167,
                                                                  167),
                                                              width: 0.5)),
                                                      child: Center(
                                                        child: Text(
                                                          snapshot.data
                                                              .docs[idx + plusIdx]
                                                              .data()['name'],
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight
                                                                  .w600),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                      padding: EdgeInsets.only(
                                                          top: 5, bottom: 5),
                                                      decoration: BoxDecoration(
                                                          color: white,
                                                          border: Border.all(
                                                              color:
                                                              Color.fromARGB(
                                                                  255,
                                                                  167,
                                                                  167,
                                                                  167),
                                                              width: 0.5)),
                                                      child: Center(
                                                        child: Text(
                                                          snapshot.data
                                                              .docs[idx + plusIdx]
                                                              .data()['phone'],
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight
                                                                  .w600),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      padding: EdgeInsets.only(
                                                          top: 5, bottom: 5),
                                                      decoration: BoxDecoration(
                                                          color: white,
                                                          border: Border.all(
                                                              color:
                                                              Color.fromARGB(
                                                                  255,
                                                                  167,
                                                                  167,
                                                                  167),
                                                              width: 0.5)),
                                                      child: Center(
                                                        child: Text(
                                                          snapshot
                                                              .data
                                                              .docs[idx +
                                                              plusIdx]
                                                              .data()[
                                                          'type'] ==
                                                              0
                                                              ? "일반가입"
                                                              : snapshot.data.docs[idx + plusIdx]
                                                              .data()[
                                                          'type'] ==
                                                              1
                                                              ? "카카오톡"
                                                              : snapshot.data.docs[idx + plusIdx].data()[
                                                          'type'] ==
                                                              2
                                                              ? "페이스북"
                                                              : snapshot.data.docs[idx + plusIdx].data()['type'] ==
                                                              3
                                                              ? "구글"
                                                              : "",
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight
                                                                  .w600),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      padding: EdgeInsets.only(
                                                          top: 5, bottom: 5),
                                                      decoration: BoxDecoration(
                                                          color: white,
                                                          border: Border.all(
                                                              color:
                                                              Color.fromARGB(
                                                                  255,
                                                                  167,
                                                                  167,
                                                                  167),
                                                              width: 0.5)),
                                                      child: Center(
                                                        child: Text(
                                                          "일반",
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight
                                                                  .w600),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                      padding: EdgeInsets.only(
                                                          top: 5, bottom: 5),
                                                      decoration: BoxDecoration(
                                                          color: white,
                                                          border: Border.all(
                                                              color:
                                                              Color.fromARGB(
                                                                  255,
                                                                  167,
                                                                  167,
                                                                  167),
                                                              width: 0.5)),
                                                      child: Center(
                                                        child: Text(
                                                          snapshot.data
                                                              .docs[idx + plusIdx]
                                                              .data()['signDate'],
                                                          style: TextStyle(
                                                              fontWeight:
                                                              FontWeight
                                                                  .w600),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }
                                          } else {
                                            return Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        top: 5, bottom: 5),
                                                    decoration: BoxDecoration(
                                                        color: white,
                                                        border: Border.all(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    167,
                                                                    167,
                                                                    167),
                                                            width: 0.5)),
                                                    child: Center(
                                                      child: Text(
                                                        (idx + 1).toString(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        top: 5, bottom: 5),
                                                    decoration: BoxDecoration(
                                                        color: white,
                                                        border: Border.all(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    167,
                                                                    167,
                                                                    167),
                                                            width: 0.5)),
                                                    child: Center(
                                                      child: Text(
                                                        snapshot.data.docs[idx]
                                                            .data()['id'],
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        top: 5, bottom: 5),
                                                    decoration: BoxDecoration(
                                                        color: white,
                                                        border: Border.all(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    167,
                                                                    167,
                                                                    167),
                                                            width: 0.5)),
                                                    child: Center(
                                                      child: Text(
                                                        snapshot.data.docs[idx]
                                                            .data()['name'],
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        top: 5, bottom: 5),
                                                    decoration: BoxDecoration(
                                                        color: white,
                                                        border: Border.all(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    167,
                                                                    167,
                                                                    167),
                                                            width: 0.5)),
                                                    child: Center(
                                                      child: Text(
                                                        snapshot.data.docs[idx]
                                                            .data()['phone'],
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        top: 5, bottom: 5),
                                                    decoration: BoxDecoration(
                                                        color: white,
                                                        border: Border.all(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    167,
                                                                    167,
                                                                    167),
                                                            width: 0.5)),
                                                    child: Center(
                                                      child: Text(
                                                        snapshot.data.docs[idx]
                                                                        .data()[
                                                                    'type'] ==
                                                                0
                                                            ? "일반가입"
                                                            : snapshot.data.docs[idx]
                                                                            .data()[
                                                                        'type'] ==
                                                                    1
                                                                ? "카카오톡"
                                                                : snapshot.data.docs[idx].data()[
                                                                            'type'] ==
                                                                        2
                                                                    ? "페이스북"
                                                                    : snapshot.data.docs[idx].data()['type'] ==
                                                                            3
                                                                        ? "구글"
                                                                        : "",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        top: 5, bottom: 5),
                                                    decoration: BoxDecoration(
                                                        color: white,
                                                        border: Border.all(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    167,
                                                                    167,
                                                                    167),
                                                            width: 0.5)),
                                                    child: Center(
                                                      child: Text(
                                                        "일반",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        top: 5, bottom: 5),
                                                    decoration: BoxDecoration(
                                                        color: white,
                                                        border: Border.all(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    167,
                                                                    167,
                                                                    167),
                                                            width: 0.5)),
                                                    child: Center(
                                                      child: Text(
                                                        snapshot.data.docs[idx]
                                                            .data()['signDate'],
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }
                                        },
                                        shrinkWrap: true,
                                        itemCount:
                                            searchCount >= 20 ? selectPageNumber == page.length ? searchPageLength - int.parse(page.length.toString().substring(page.length.toString().length - 1, page.length.toString().length)) : searchPageLength : searchCount - 1,
                                      ),),
                              );
                            }
                            return Container();
                          },
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          searchCount >= 20 ?
          search
              ? Container(
                  width: MediaQuery.of(context).size.width - 228,
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (selectPageNumber != 1) {
                              if (int.parse(selectPageNumber.toString().substring(selectPageNumber.toString().length - 1, selectPageNumber.toString().length)) == 1) {
                                if (page.length < 10) {
                                  if (pageLength == page.length) {
                                    pageLength = pageLength - int.parse(page.length.toString().substring(page.length.toString().length - 1, page.length.toString().length));
                                  }
                                } else {
                                  if (int.parse(pageLength.toString().substring(pageLength.toString().length - 1, pageLength.toString().length)) == 0) {
                                    pageLength = pageLength - 10;
                                  } else {
                                    pageLength = pageLength - int.parse(pageLength.toString().substring(pageLength.toString().length - 1, pageLength.toString().length));
                                  }
                                }

                              }
                              selectPageNumber = selectPageNumber - 1;
                              print("subString: " + selectPageNumber.toString().substring(selectPageNumber.toString().length - 1, selectPageNumber.toString().length));
                            }
                          });
                        },
                        icon: Icon(Icons.arrow_back_ios),
                      ),
                      ListView.builder(
                        itemBuilder: (context, idx) {
                          if (pageLength <= 10) {
                            return Padding(
                              padding:
                                  EdgeInsets.only(top: 10, left: 2, right: 2),
                              child: HandCursor(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectPageNumber = idx + 1;
                                      print(
                                          "check : ${searchPageLength * selectPageNumber}");
                                    });
                                  },
                                  child: Text(
                                    "${idx + 1}",
                                    style: TextStyle(
                                        color: idx + 1 == selectPageNumber
                                            ? mainColor
                                            : black,
                                        fontSize: 16),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            );
                          } else if (pageLength > 10) {
                            return Padding(
                              padding:
                                  EdgeInsets.only(top: 10, left: 2, right: 2),
                              child: HandCursor(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectPageNumber = idx + 1;
                                      print(
                                          "check : ${searchPageLength * selectPageNumber}");
                                    });
                                  },
                                  child: Text(
                                    "${idx + 1}",
                                    style: TextStyle(
                                        color: idx + 1 == selectPageNumber
                                            ? mainColor
                                            : black,
                                        fontSize: 16),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            );
                          }
//                          else if (pageLength >= 20) {
//                            return Padding(
//                              padding:
//                                  EdgeInsets.only(top: 10, left: 2, right: 2),
//                              child: HandCursor(
//                                child: GestureDetector(
//                                  onTap: () {
//                                    setState(() {
//                                      selectPageNumber = idx + 1;
//                                      print(
//                                          "check : ${searchPageLength * selectPageNumber}");
//                                    });
//                                  },
//                                  child: Text(
//                                    "${idx + 1 + int.parse(pageLength.toString().substring(1, 2)) + 10}",
//                                    style: TextStyle(
//                                        color: idx + 1 == selectPageNumber
//                                            ? mainColor
//                                            : black,
//                                        fontSize: 16),
//                                    textAlign: TextAlign.center,
//                                  ),
//                                ),
//                              ),
//                            );
//                          }
                          else {
                            return Container();
                          }
                        },
                        shrinkWrap: true,
                        itemCount: pageLength,
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              if (selectPageNumber != page.length) {
                                print("subString: " + selectPageNumber.toString().substring(selectPageNumber.toString().length - 1, selectPageNumber.toString().length));
                                if (int.parse(selectPageNumber.toString().substring(selectPageNumber.toString().length - 1, selectPageNumber.toString().length)) == 0) {
                                  print("page2 : ${pageLength}, ${page.length}");
                                  if (pageLength + 10 > page.length) {
                                    pageLength = page.length;
                                  } else {
                                    pageLength = pageLength + 10;
                                    print(pageLength);
                                  }
                                }
                                print("selectPageNumber : ${selectPageNumber}");
                                selectPageNumber = selectPageNumber + 1;
                                print("selectPageNumber2 : ${selectPageNumber}");
                              }
                            });

                          }, icon: Icon(Icons.arrow_forward_ios))
                    ],
                  ),
                )
              : Container() : Container(),
        ],
      ),
    );
  }
}
