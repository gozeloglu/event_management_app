import 'dart:convert';

import 'package:event_management_app/pages/participant/home_page.dart';
import 'package:event_management_app/services/participant_service.dart';
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
  TextEditingController usernameEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _passwordVisible = false;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  void dispose() {
    usernameEditingController.dispose();
    passwordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.only(left: 15, right: 15, top: 50),
          margin: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                logo(),
                title(),
                usernameField(),
                passwordField(),
                loginButton(),
              ],
            ),
          ),
        ));
  }

  Widget logo() {
    return Image.asset("assets/logo.png");
  }

  Widget title() {
    return Container(
        padding: EdgeInsets.all(20),
        child: Text(
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
        child: TextFormField(
          controller: usernameEditingController,
          maxLines: 1,
          validator: (value) {
            if (value.isEmpty) {
              return "Please enter user name";
            }
            return null;
          },
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Username",
              prefixIcon: Icon(Icons.person)),
        ));
  }

  Widget passwordField() {
    return Container(
        padding: EdgeInsets.all(15),
        child: TextFormField(
          controller: passwordEditingController,
          maxLines: 1,
          obscureText: !_passwordVisible,
          validator: (value) {
            if (value.isEmpty) {
              return "Please enter  your password";
            }
            return null;
          },
          decoration: InputDecoration(
              suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  }),
              border: OutlineInputBorder(),
              labelText: "Password",
              prefixIcon: Icon(Icons.lock)),
        ));
  }

  Widget loginButton() {
    return Container(
      padding: EdgeInsets.all(10),
      child: RaisedButton(
        elevation: 8,
        color: Colors.green,
        child: Text(
          "Login",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        onPressed: () {
          // If both field is filled
          if (_formKey.currentState.validate()) {
            String username = usernameEditingController.text;
            String password = passwordEditingController.text;
            ParticipantService participantService = new ParticipantService();
            participantService
                .loginParticipant(username, password)
                .then((response) {
              if (response.statusCode < 400) {
                String firstName = "";
                String lastName = "";
                String email = "";
                participantService.getParticipantDetails(username).then((res) {
                  firstName = res.firstName;
                  lastName = res.lastName;
                  email = res.email;
                  Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(
                    'Successful Login',
                    style: TextStyle(fontSize: 20),
                  )));
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => HomePage(
                                username: username,
                                firstName:
                                    Utf8Decoder().convert(firstName.codeUnits),
                                lastName:
                                    Utf8Decoder().convert(lastName.codeUnits),
                                email: Utf8Decoder().convert(email.codeUnits),
                              )),
                      (Route<dynamic> route) => false);
                });
              } else {
                Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(
                  'Login is not successful!',
                  style: TextStyle(fontSize: 20),
                )));
              }
            }).catchError((onError) {
              Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(
                'Something went wrong!',
                style: TextStyle(fontSize: 20),
              )));
            });
          } else {
            // If fields are empty
            Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(
              'Error',
              style: TextStyle(fontSize: 20),
            )));
          }
        },
      ),
    );
  }
}
