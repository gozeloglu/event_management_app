import 'package:event_management_app/pages/sign_up.dart';
import 'package:event_management_app/pages/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabBarStateless extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            labelPadding: EdgeInsets.all(10),
            isScrollable: true,
            tabs: [
              Tab(child: Text("Login")),
              Tab(
                text: "Sign Up",
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Login(),
            SignUp(),
          ],
        ),
      ),
    );
  }
}
