import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileUpdate extends StatefulWidget {
  ProfileUpdate({
    Key key,
    this.firstName,
    this.lastName,
    this.username,
    this.email,
    this.age,
    this.identityNumber,
  }) : super(key: key);

  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final int age;
  final String identityNumber;

  @override
  ProfileUpdateState createState() => ProfileUpdateState();
}

class ProfileUpdateState extends State<ProfileUpdate> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _firstNameController;
  TextEditingController _lastNameController;
  TextEditingController _usernameController;
  TextEditingController _emailController;
  TextEditingController _ageController;
  TextEditingController _identityNumberController;

  @override
  void initState() {
    _firstNameController = new TextEditingController(text: widget.firstName);
    _lastNameController = new TextEditingController(text: widget.lastName);
    _usernameController = new TextEditingController(text: widget.username);
    _emailController = new TextEditingController(text: widget.email);
    _ageController = new TextEditingController(text: widget.age.toString());
    _identityNumberController =
        new TextEditingController(text: widget.identityNumber);
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    _identityNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Text("Update Profile"),
        centerTitle: true,
      ),
      body: Builder(
        builder: (context) => Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
            margin: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  firstNameWidget(),
                  lastNameWidget(),
                  usernameWidget(),
                  emailWidget(),
                  ageWidget(),
                  identityNumberWidget(),
                  updateButtonWidget(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget firstNameWidget() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: TextFormField(
        controller: _firstNameController,
        maxLines: 1,
        validator: (value) {
          if (value.isEmpty) {
            return "Please enter your first name";
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Firt Name",
        ),
      ),
    );
  }

  Widget lastNameWidget() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: TextFormField(
        controller: _lastNameController,
        maxLines: 1,
        validator: (value) {
          if (value.isEmpty) {
            return "Please enter your last name";
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Last Name",
        ),
      ),
    );
  }

  Widget usernameWidget() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: TextFormField(
        controller: _usernameController,
        maxLines: 1,
        validator: (value) {
          if (value.isEmpty) {
            return "Please enter your username";
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Username",
        ),
      ),
    );
  }

  Widget emailWidget() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: TextFormField(
        controller: _emailController,
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value.isEmpty) {
            return "Please enter your email";
          } else if (!value.contains("@")) {
            return "Please write a valid email";
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "E-Mail",
        ),
      ),
    );
  }

  Widget ageWidget() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: TextFormField(
        controller: _ageController,
        maxLines: 1,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value.isEmpty) {
            return "Please enter your age";
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Age",
        ),
      ),
    );
  }

  Widget identityNumberWidget() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: TextFormField(
        controller: _identityNumberController,
        maxLines: 1,
        validator: (value) {
          if (value.isEmpty) {
            return "Please enter your age";
          } else if (value.length != 11) {
            return "Identity number should contains 11 characters!";
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Identity Number",
        ),
      ),
    );
  }

  Widget updateButtonWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: RaisedButton(
        elevation: 8,
        color: Colors.green,
        child: Text(
          "Update Profile",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        onPressed: () {
          // If all fields are filled
          if (_formKey.currentState.validate()) {
            // Save the meetup
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text('Profile is updated!')));
          } else {
            // If fields are empty
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text('Error!')));
          }
        },
      ),
    );
  }
}
