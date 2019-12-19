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
                              setState(() {
                                print(
                                    "change ${date.year}.${date.month}.${date.day}");
                                _dateStart.text =
                                    "${date.year}년${date.month}월${date.day}일";
                              });
                            }, onConfirm: (date) {
                              setState(() {
                                print(
                                    "confirm ${date.year}.${date.month}.${date.day}");
                                _dateStart.text =
                                    "${date.year}년${date.month}월${date.day}일";
                              });
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
                              setState(() {
                                print(
                                    "change ${date.year}.${date.month}.${date.day}");
                                _dateEnd.text =
                                    "${date.year}년${date.month}월${date.day}일";
                              });
                            }, onConfirm: (date) {
                              setState(() {
                                print(
                                    "confirm ${date.year}.${date.month}.${date.day}");
                                _dateEnd.text =
                                    "${date.year}년${date.month}월${date.day}일";
                              });
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
                onPressed: () {},
                elevation: 0,
                color: Colors.transparent,
                child: Center(
                  child: Text("검색"),
                ),
              ),
            ),
          ),
          whiteSpaceH(50),
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
                          border: Border.all(color: Color.fromARGB(255, 167, 167, 167), width: 0.5)
                        ),
                        child: Center(
                          child: Text("No", style: TextStyle(fontWeight: FontWeight.w600),),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 219, 219, 219),
                            border: Border.all(color: Color.fromARGB(255, 167, 167, 167), width: 0.5)
                        ),
                        child: Center(
                          child: Text("ID", style: TextStyle(fontWeight: FontWeight.w600),),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 219, 219, 219),
                            border: Border.all(color: Color.fromARGB(255, 167, 167, 167), width: 0.5)
                        ),
                        child: Center(
                          child: Text("성명", style: TextStyle(fontWeight: FontWeight.w600),),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 219, 219, 219),
                            border: Border.all(color: Color.fromARGB(255, 167, 167, 167), width: 0.5)
                        ),
                        child: Center(
                          child: Text("휴대폰번호", style: TextStyle(fontWeight: FontWeight.w600),),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 219, 219, 219),
                            border: Border.all(color: Color.fromARGB(255, 167, 167, 167), width: 0.5)
                        ),
                        child: Center(
                          child: Text("회원유형", style: TextStyle(fontWeight: FontWeight.w600),),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 219, 219, 219),
                            border: Border.all(color: Color.fromARGB(255, 167, 167, 167), width: 0.5)
                        ),
                        child: Center(
                          child: Text("가입유형", style: TextStyle(fontWeight: FontWeight.w600),),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 219, 219, 219),
                            border: Border.all(color: Color.fromARGB(255, 167, 167, 167), width: 0.5)
                        ),
                        child: Center(
                          child: Text("가입일", style: TextStyle(fontWeight: FontWeight.w600),),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 219, 219, 219),
                            border: Border.all(color: Color.fromARGB(255, 167, 167, 167), width: 0.5)
                        ),
                        child: Center(
                          child: Text("상태", style: TextStyle(fontWeight: FontWeight.w600),),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 228,
                child: StreamBuilder(
                  stream: (_searchContorller.text != null && _dateStart.text != null && _dateEnd.text != null) ? firestore()
                      .collection("users")
                      .onSnapshot : firestore().collection("users").where("signDate", ">=", _dateStart.text).where("signDate", "<=", _dateEnd.text).onSnapshot,
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {

                      print("length : ${snapshot.data.docs.length}");
                      return Container(
                          width: MediaQuery.of(context).size.width - 228,
                          height: MediaQuery.of(context).size.height - 286,
                          child: ListView.builder(
                            itemBuilder: (context, idx) {
                              searchCount = snapshot.data.docs.length + 1;
                              return Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(top: 5, bottom: 5),
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(255, 219, 219, 219),
                                          border: Border.all(color: Color.fromARGB(255, 167, 167, 167), width: 0.5)
                                      ),
                                      child: Center(
                                        child: Text((idx + 1).toString(), style: TextStyle(fontWeight: FontWeight.w600),),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: EdgeInsets.only(top: 5, bottom: 5),
                                      decoration: BoxDecoration(
                                          color: white,
                                          border: Border.all(color: Color.fromARGB(255, 167, 167, 167), width: 0.5)
                                      ),
                                      child: Center(
                                        child: Text(snapshot.data.docs[idx].data()['id'], style: TextStyle(fontWeight: FontWeight.w600),),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(top: 5, bottom: 5),
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(255, 219, 219, 219),
                                          border: Border.all(color: Color.fromARGB(255, 167, 167, 167), width: 0.5)
                                      ),
                                      child: Center(
                                        child: Text(snapshot.data.docs[idx].data()['name'], style: TextStyle(fontWeight: FontWeight.w600),),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: EdgeInsets.only(top: 5, bottom: 5),
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(255, 219, 219, 219),
                                          border: Border.all(color: Color.fromARGB(255, 167, 167, 167), width: 0.5)
                                      ),
                                      child: Center(
                                        child: Text(snapshot.data.docs[idx].data()['phone'], style: TextStyle(fontWeight: FontWeight.w600),),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(top: 5, bottom: 5),
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(255, 219, 219, 219),
                                          border: Border.all(color: Color.fromARGB(255, 167, 167, 167), width: 0.5)
                                      ),
                                      child: Center(
                                        child: Text(snapshot.data.docs[idx].data()['type'] == 0 ? "일반가입" : snapshot.data.docs[idx].data()['type'] == 1 ? "카카오톡" : snapshot.data.docs[idx].data()['type'] == 2 ? "페이스북" : snapshot.data.docs[idx].data()['type'] == 3 ? "구글" : "", style: TextStyle(fontWeight: FontWeight.w600),),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(top: 5, bottom: 5),
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(255, 219, 219, 219),
                                          border: Border.all(color: Color.fromARGB(255, 167, 167, 167), width: 0.5)
                                      ),
                                      child: Center(
                                        child: Text("가입유형", style: TextStyle(fontWeight: FontWeight.w600),),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: EdgeInsets.only(top: 5, bottom: 5),
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(255, 219, 219, 219),
                                          border: Border.all(color: Color.fromARGB(255, 167, 167, 167), width: 0.5)
                                      ),
                                      child: Center(
                                        child: Text("가입일", style: TextStyle(fontWeight: FontWeight.w600),),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(top: 5, bottom: 5),
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(255, 219, 219, 219),
                                          border: Border.all(color: Color.fromARGB(255, 167, 167, 167), width: 0.5)
                                      ),
                                      child: Center(
                                        child: Text("상태", style: TextStyle(fontWeight: FontWeight.w600),),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                                return Container();
                            }, shrinkWrap: true, itemCount: snapshot.data.docs.length,));
                    }
                    return Container();
                  },
                ),)

              ],
            ),
          )
        ],
      ),
    );
  }
}
