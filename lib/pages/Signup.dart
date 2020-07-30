import 'package:event_management_app/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _lastnameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _ageController = new TextEditingController();
  TextEditingController _identityNumberController = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _passwordVisible = false;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastnameController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _ageController.dispose();
    _identityNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: 20),
          margin: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                title(),
                name(),
                lastName(),
                email(),
                username(),
                password(),
                age(),
                signUpButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget title() {
    return Container(
        padding: EdgeInsets.all(20),
        child: Text(
          "Sign Up",
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ));
  }

  Widget name() {
    return Container(
      padding: EdgeInsets.all(20),
      child: TextFormField(
        controller: _nameController,
        maxLines: 1,
        validator: (value) {
          if (value.isEmpty) {
            return "Please enter  your first name";
          }
          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "First Name",
        ),
      ),
    );
  }

  Widget lastName() {
    return Container(
      padding: EdgeInsets.all(20),
      child: TextFormField(
        controller: _lastnameController,
        maxLines: 1,
        validator: (value) {
          if (value.isEmpty) {
            return "Please enter  your last name";
          }
          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Last Name",
        ),
      ),
    );
  }

  Widget email() {
    return Container(
      padding: EdgeInsets.all(20),
      child: TextFormField(
        controller: _emailController,
        maxLines: 1,
        validator: (value) {
          if (value.isEmpty) {
            return "Please enter  your email";
          }
          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "E-Mail",
        ),
      ),
    );
  }

  Widget username() {
    return Container(
      padding: EdgeInsets.all(20),
      child: TextFormField(
        controller: _usernameController,
        maxLines: 1,
        validator: (value) {
          if (value.isEmpty) {
            return "Please enter  your username";
          }
          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Username",
        ),
      ),
    );
  }

  Widget password() {
    return Container(
      padding: EdgeInsets.all(20),
      child: TextFormField(
        controller: _passwordController,
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
      ),
    );
  }

  Widget age() {
    return Container(
      padding: EdgeInsets.all(20),
      child: TextFormField(
        controller: _ageController,
        maxLines: 1,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value.isEmpty) {
            return "Please enter  your age";
          }
          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Age",
        ),
      ),
    );
  }

  Widget signUpButton() {
    return Container(
      padding: EdgeInsets.all(10),
      child: RaisedButton(
        elevation: 8,
        color: Colors.green,
        child: Text(
          "Sign Up",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        onPressed: () {
          // If all fields are filled
          if (_formKey.currentState.validate()) {
            // TODO Register the user
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text('Successful Sign Up')));
            //Navigator.pushNamedAndRemoveUntil(
            //  context, Routes.home, ModalRoute.withName('/'));
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                HomePage()), (Route<dynamic> route) => false);
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
