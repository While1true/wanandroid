import 'package:flutter/material.dart';
import 'package:flyandroid/Pages/LoginAndRegisterPage.dart';

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (c) {
                return LoginAndRegisterPage(LoginAndRegister.LOGIN);
              }));
            },
            child: Text("MinePage")));
  }
}
