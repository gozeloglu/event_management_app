import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginStateless extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Login(),
    );
  }
}

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  TextEditingController usernameEditingController;
  TextEditingController passwordEditingController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: EdgeInsets.only(left: 15, right: 15, top: 100),
          margin: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              logo(),
              title(),
              usernameField(),
              passwordField(),
              loginButton(),
            ],
          )
        )
    );
  }

  Widget logo() {
    return Image.asset("assets/logo.png");
  }
  Widget title() {
    return Container(
        padding: EdgeInsets.all(20),
        child:
        Text(
          "Login",
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
            fontSize: 30,
      ),
    ));
  }
  Widget usernameField() {
    return Container(
      padding: EdgeInsets.all(15),
      child:TextField(
      controller: usernameEditingController,
      maxLines: 1,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Username",
      ),
    ));
  }

  Widget passwordField() {
    return Container(
      padding: EdgeInsets.all(15),
      child:TextField(
      controller: passwordEditingController,
      maxLines: 1,
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Password",
      ),
    ));
  }

  Widget loginButton() {
    return Container(
      padding: EdgeInsets.all(15),
      child: RaisedButton(
        elevation: 8,
        color: Colors.green,
        child: Text("Login", style: TextStyle(
          fontSize: 20,
          color: Colors.white
        ),),
        onPressed: () {},
      ),
    );
  }
}
