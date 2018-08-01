import 'dart:async';

import 'package:flutter/material.dart';

class LoginAndRegisterPage extends StatelessWidget {
  final LoginAndRegister type;

  LoginAndRegisterPage(this.type);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(type == LoginAndRegister.LOGIN ? "登录" : "注册"),),
      body: SingleChildScrollView(reverse: true,
          padding: EdgeInsets.only(left: 32.0, right: 32.0),
          child: type == LoginAndRegister.LOGIN
                  ? buildLogin(context)
                  : buildRegister(context)));
  }

  Widget buildLogin(BuildContext context) {
    return Column(children: <Widget>[
      Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Image.asset("assets/pic/logo.png")),
      TextField(
        decoration: InputDecoration(
            hintText: "请输入账号",
            labelText: "账号：",
            icon: Icon(Icons.account_box)),
        onChanged: (account) {}, keyboardType: TextInputType.emailAddress,),
      TextField(
          decoration: InputDecoration(
              hintText: "请输入密码",
              labelText: "密码：",
              icon: Icon(Icons.enhanced_encryption)),
          onChanged: (password) {}, keyboardType: TextInputType.emailAddress
      ),
      Padding(
        padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
        child: MaterialButton(
          onPressed: () {},
          child: Text("登录", style: TextStyle(color: Colors.white)),
          color: Colors.blue,
          padding: EdgeInsets.all(8.0),
        ),
      ),
      Container(
        alignment: AlignmentDirectional.bottomEnd,
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (c) {
              return LoginAndRegisterPage(LoginAndRegister.REGISTER);
            }));
          },
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("没有账号？点击注册"),
          ),
        ),
      )
    ]);
  }

  Widget buildRegister(BuildContext context) {
    return Column(children: <Widget>[
      Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Image.asset("assets/pic/logo.png")),
      TextField(
        decoration: InputDecoration(
            hintText: "请输入账号",
            labelText: "账号：",
            icon: Icon(Icons.account_box)),
        onChanged: (account) {}, keyboardType: TextInputType.emailAddress,),
      TextField(
        decoration: InputDecoration(
            hintText: "请输入密码",
            labelText: "密码：",
            icon: Icon(Icons.enhanced_encryption)),
        onChanged: (password) {}
        , keyboardType: TextInputType.emailAddress,
      ),
      TextField(
          decoration: InputDecoration(
              hintText: "请再次输入密码",
              labelText: "确认密码：",
              icon: Icon(Icons.enhanced_encryption)),
          onChanged: (password) {}, keyboardType: TextInputType.emailAddress
      ),
      Padding(
          padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
          child: MaterialButton(
              onPressed: () {},
              child: Text(
                "注册",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
              padding: EdgeInsets.all(8.0))),

    ]);
  }

  void _showMessage(BuildContext context, String name) {
    showDialog<Null>(
        context: context,
        builder: (c) {
          return new AlertDialog(
              content: new Text(name),
              actions: <Widget>[
                new FlatButton(
                    onPressed: () {
                      Navigator.pop(c);
                    },
                    child: new Text('确定')
                )
              ]
          );
        }
    );
  }

}


enum LoginAndRegister { LOGIN, REGISTER }
