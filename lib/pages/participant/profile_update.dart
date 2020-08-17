import 'package:event_management_app/models/participant.dart';
import 'package:event_management_app/services/participant_service.dart';
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

  @override
  void initState() {
    _firstNameController = new TextEditingController(text: widget.firstName);
    _lastNameController = new TextEditingController(text: widget.lastName);
    _usernameController = new TextEditingController(text: widget.username);
    _emailController = new TextEditingController(text: widget.email);
    _ageController = new TextEditingController(text: widget.age.toString());
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Text("Update Profile"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
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
          labelText: "First Name",
          prefixIcon: Icon(Icons.person),
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
          prefixIcon: Icon(Icons.person),
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
            prefixIcon: Icon(Icons.perm_identity)),
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
          prefixIcon: Icon(Icons.email),
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
            prefixIcon: Icon(Icons.date_range)),
      ),
    );
  }

  Widget updateButtonWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: MaterialButton(
        elevation: 8,
        height: 48,
        padding: const EdgeInsets.fromLTRB(48, 0, 48, 0),
        color: Colors.green,
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(20)),
        child: Text(
          "Update Profile",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        onPressed: () {
          // If all fields are filled
          if (_formKey.currentState.validate()) {
            // Update the profile
            ParticipantService participantService = new ParticipantService();
            Participant updatedProfile = new Participant(
              firstName: _firstNameController.text,
              lastName: _lastNameController.text,
              email: _emailController.text,
              userName: _usernameController.text,
              age: int.parse(_ageController.text),
              identityNumber: widget.identityNumber,
            );
            participantService.updateProfile(updatedProfile).then((response) {
              if (response.statusCode < 400) {
                Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(
                  'Profile is updated!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                )));
              } else {
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text(response.body)));
              }
            }).catchError((onError) {
              Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text('Something went wrong')));
            });
          } else {
            // If fields are empty
            Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(
              'Error!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            )));
          }
        },
      ),
    );
  }
}
