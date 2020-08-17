import 'package:event_management_app/models/participant.dart';
import 'file:///C:/Users/gozel/OneDrive/Desktop/event_management_app/event_management_app/lib/pages/participant/home_page.dart';
import 'package:event_management_app/services/participant_service.dart';
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
    return Form(
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
              identityNumber(),
              signUpButton(),
            ],
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
            prefixIcon: Icon(Icons.person_outline)),
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
            prefixIcon: Icon(Icons.person_outline)),
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
            prefixIcon: Icon(Icons.email)),
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
            prefixIcon: Icon(Icons.person)),
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
            prefixIcon: Icon(Icons.lock)),
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
            prefixIcon: Icon(Icons.date_range)),
      ),
    );
  }

  Widget identityNumber() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: TextFormField(
        controller: _identityNumberController,
        maxLines: 1,
        validator: (value) {
          if (value.isEmpty) {
            return "Please enter your identity numbebr";
          }
          return null;
        },
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Identity Number",
            prefixIcon: Icon(Icons.perm_identity)),
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
            int _age = int.parse(_ageController.text);
            ParticipantService participantService = new ParticipantService();
            Participant newParticipant = new Participant(
                firstName: _nameController.text,
                lastName: _lastnameController.text,
                email: _emailController.text,
                userName: _usernameController.text,
                password: _passwordController.text,
                age: _age,
                identityNumber: _identityNumberController.text);
            participantService.saveUser(newParticipant).then((response) {
              if (response.statusCode < 300) {
                Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(
                  'Successful Sign Up',
                  style: TextStyle(fontSize: 20),
                )));
              } else {
                Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(
                  'Sign Up is not successful!',
                  style: TextStyle(fontSize: 20),
                )));
              }
            }).catchError((error) {
              print(error);
            });
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
