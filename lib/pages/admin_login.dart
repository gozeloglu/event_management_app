import 'package:event_management_app/models/admin.dart';
import 'package:event_management_app/services/admin_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:event_management_app/pages/home_page.dart';
import 'package:event_management_app/routes.dart';

class AdminLoginStateless extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AdminLogin(),
    );
  }
}

class AdminLogin extends StatefulWidget {
  AdminLogin({Key key}) : super(key: key);

  @override
  AdminLoginState createState() => AdminLoginState();
}

class AdminLoginState extends State<AdminLogin> {
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
          ),
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
          ),
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
            AdminService adminService = new AdminService();
            Admin admin = new Admin(
              userName: usernameEditingController.text,
              password: passwordEditingController.text,
            );
            adminService.loginAdmin(admin).then((response) {
              if (response.statusCode < 400) {
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text('Successful Login')));
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => HomePage()),
                    (Route<dynamic> route) => false);
              } else {
                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text('Login is not successful!')));
              }
            }).catchError((error) {
              Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text('Something went wrong!')));
            });
            //Navigator.pushNamedAndRemoveUntil(
            //  context, Routes.home, ModalRoute.withName('/'));
          } else {
            // If fields are empty
            // TODO Show up appropriate error message if not valid user
            Scaffold.of(context).showSnackBar(SnackBar(content: Text('Error')));
          }
        },
      ),
    );
  }
}
