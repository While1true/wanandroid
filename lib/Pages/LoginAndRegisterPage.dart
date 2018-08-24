import 'dart:async';
import 'dart:convert';
import 'package:flyandroid/Api/Api.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flyandroid/Model/UserModel.dart';

class LoginAndRegisterPage extends StatefulWidget {
  final LoginAndRegister type;

  LoginAndRegisterPage(this.type);

  @override
  State<StatefulWidget> createState()=>_state();

}
class _state extends State<LoginAndRegisterPage>{
  TextEditingController _account;
  TextEditingController _pass;
  TextEditingController _confirmPass;
  @override
  void initState() {
    super.initState();
    _account=new TextEditingController();
    _pass=new TextEditingController();
    _confirmPass=new TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.type == LoginAndRegister.LOGIN ? "登录" : "注册"),
        ),
        body: SingleChildScrollView(
            reverse: true,
            padding: EdgeInsets.only(left: 32.0, right: 32.0),
            child: widget.type == LoginAndRegister.LOGIN
                ? buildLogin()
                : buildRegister()));
  }

  Widget buildLogin() {
    return Column(children: <Widget>[
      Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Image.asset("assets/pic/logo.png")),
      TextField(
        controller: _account,
        decoration: InputDecoration(
            hintText: "请输入账号", labelText: "账号：", icon: Icon(Icons.account_box)),
        keyboardType: TextInputType.emailAddress,
      ),
      TextField(
          controller: _pass,
          decoration: InputDecoration(
              hintText: "请输入密码",
              labelText: "密码：",
              icon: Icon(Icons.enhanced_encryption)),
          keyboardType: TextInputType.emailAddress),
      Padding(
        padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
        child: MaterialButton(
          onPressed: _login,
          child: Text("登录", style: TextStyle(color: Colors.white)),
          color: Colors.blue,
          padding: EdgeInsets.all(8.0),
        ),
      ),
      Container(
        alignment: AlignmentDirectional.bottomEnd,
        child: InkWell(
          onTap: () async {
            bool isok =
            await Navigator.push(context, MaterialPageRoute(builder: (c) {
              return LoginAndRegisterPage(LoginAndRegister.REGISTER);
            }));
            if (isok) {
              Navigator.pop(context,true);
            }
          },
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("没有账号？点击注册"),
          ),
        ),
      )
    ]);
  }

  Widget buildRegister() {
    return Column(children: <Widget>[
      Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Image.asset("assets/pic/logo.png")),
      TextField(
        controller: _account,
        decoration: InputDecoration(
            hintText: "请输入账号", labelText: "账号：", icon: Icon(Icons.account_box)),
        keyboardType: TextInputType.emailAddress,
      ),
      TextField(
        decoration: InputDecoration(
            hintText: "请输入密码",
            labelText: "密码：",
            icon: Icon(Icons.enhanced_encryption)),
        controller: _pass,
        keyboardType: TextInputType.emailAddress,
      ),
      TextField(
          decoration: InputDecoration(
              hintText: "请再次输入密码",
              labelText: "确认密码：",
              icon: Icon(Icons.enhanced_encryption)),
          controller: _confirmPass,
          keyboardType: TextInputType.emailAddress),
      Padding(
          padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
          child: MaterialButton(
              onPressed:_register,
              child: Text(
                "注册",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
              padding: EdgeInsets.all(8.0))),
    ]);
  }

  Future<Null> _showMessage(String name) async {
    return showDialog<Null>(
        context: context,
        builder: (c) {
          return new AlertDialog(content: new Text(name), actions: <Widget>[
            new FlatButton(
                onPressed: () {
                  Navigator.pop(c);
                },
                child: new Text('确定'))
          ]);
        });
  }

  void _login() async {
    if (_account.text.isNotEmpty && _pass.text.isNotEmpty) {
      http.Response response = await http
          .post(Api.LOGIN, body: {"username": _account.text, "password": _pass.text});
      UserModel model = UserModel.fromJson(json.decode(response.body));
      if (model.errorCode < 0) {
        await  _showMessage(model.errorMsg);
      } else {
        SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
        sharedPreferences.setString("cookie", response.headers['set-cookie']);
        sharedPreferences.setString("user", response.body);
        await  _showMessage("登录成功");
        Navigator.pop(context,true);
      }
    } else {
      await _showMessage("账号或密码不能为空");
    }
  }

  void _register() async {
    if (_account.text.isNotEmpty && _pass.text.isNotEmpty && _confirmPass.text.isNotEmpty) {
      if (_pass.text != _confirmPass.text) {
        _showMessage("两次密码不一致");
      } else {
        http.Response response = await http.post(Api.REGIDTER, body: {
          "username": _account.text,
          "password": _pass.text,
          "repassword": _confirmPass.text
        });
        UserModel model = UserModel.fromJson(json.decode(response.body));
        if (model.errorCode < 0) {
          await _showMessage(model.errorMsg);
        } else {
          SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
          sharedPreferences.setString("user", response.body);
          sharedPreferences.setString("cookie", response.headers['set-cookie']);
          await _showMessage("注册成功");
          Navigator.pop(context, true);
        }
      }
    } else {
      await _showMessage("账号或密码不能为空");
    }
  }
}

enum LoginAndRegister { LOGIN, REGISTER }
