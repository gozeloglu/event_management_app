import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminAddMeetup extends StatefulWidget {
  AdminAddMeetup({Key key}) : super(key: key);

  @override
  AdminAddMeetupState createState() => AdminAddMeetupState();
}

class AdminAddMeetupState extends State<AdminAddMeetup> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _meetupIdController = new TextEditingController();
  TextEditingController _meetupNameController = new TextEditingController();
  TextEditingController _detailsController = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();
  TextEditingController _placeNameController = new TextEditingController();
  TextEditingController _startDateController = new TextEditingController();
  TextEditingController _endDateController = new TextEditingController();
  TextEditingController _quotaController = new TextEditingController();
  TextEditingController _registeredUserCountController =
      new TextEditingController();

  @override
  void dispose() {
    _meetupIdController.dispose();
    _meetupNameController.dispose();
    _detailsController.dispose();
    _addressController.dispose();
    _placeNameController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _quotaController.dispose();
    _registeredUserCountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Text("Add New Meetup"),
        centerTitle: true,
      ),
      body: Builder(
        builder: (context) => Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
            margin: const EdgeInsets.all(10),
            child: SingleChildScrollView(
                child: Column(
              children: <Widget>[
                meetupIdWiget(),
                meetupNameWidget(),
                detailsWidget(),
                addressWidget(),
                placeNameWidget(),
                startDateWidget(),
                endDateWidget(),
                quotaWidget(),
                registeredUserCountWidget(),
                addButtonWidget(context),
              ],
            )),
          ),
        ),
      ),
    );
  }

  Widget meetupIdWiget() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: TextFormField(
        controller: _meetupIdController,
        maxLines: 1,
        validator: (value) {
          if (value.isEmpty) {
            return "Meetup ID should be filled";
          } else if (value.length != 5) {
            return "Meetup ID field should have 5 chars";
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Meetup ID",
        ),
      ),
    );
  }

  Widget meetupNameWidget() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: TextFormField(
        controller: _meetupNameController,
        maxLines: 1,
        validator: (value) {
          if (value.isEmpty) {
            return "Meetup name field should be filled";
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Meetup Name",
        ),
      ),
    );
  }

  Widget detailsWidget() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: TextFormField(
        controller: _detailsController,
        maxLines: 2,
        validator: (value) {
          if (value.isEmpty) {
            return "Details field should be filled";
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Details",
        ),
      ),
    );
  }

  Widget addressWidget() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: TextFormField(
        controller: _addressController,
        maxLines: 1,
        validator: (value) {
          if (value.isEmpty) {
            return "Address field should be filled";
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Address",
        ),
      ),
    );
  }

  Widget placeNameWidget() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: TextFormField(
        controller: _placeNameController,
        maxLines: 1,
        validator: (value) {
          if (value.isEmpty) {
            return "Place name field should be filled";
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Place Name",
        ),
      ),
    );
  }

  Widget startDateWidget() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: TextFormField(
        controller: _startDateController,
        maxLines: 1,
        keyboardType: TextInputType.datetime,
        validator: (value) {
          if (value.isEmpty) {
            return "Start Date field should be filled";
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Start Date",
        ),
      ),
    );
  }

  Widget endDateWidget() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: TextFormField(
        controller: _endDateController,
        maxLines: 1,
        keyboardType: TextInputType.datetime,
        validator: (value) {
          if (value.isEmpty) {
            return "End Date field should be filled";
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "End Date",
        ),
      ),
    );
  }

  Widget quotaWidget() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: TextFormField(
        controller: _quotaController,
        maxLines: 1,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value.isEmpty) {
            return "Quota field should be filled";
          }
          int quota = int.parse(value);
          if (quota < 1) {
            return "Quota must be bigger than 0";
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Quota",
        ),
      ),
    );
  }

  Widget registeredUserCountWidget() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: TextFormField(
        controller: _registeredUserCountController,
        maxLines: 1,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value.isEmpty) {
            return "Registered user count should be filled";
          } else {
            int count = int.parse(value);
            int quota = int.parse(_quotaController.text);
            if (count > quota) {
              return "Registered user count cannot be bigger than quota";
            } else {
              return null;
            }
          }
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Quota",
        ),
      ),
    );
  }

  Widget addButtonWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: RaisedButton(
        elevation: 8,
        color: Colors.green,
        child: Text(
          "Add New Meetup",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        onPressed: () {
          // If all fields are filled
          if (_formKey.currentState.validate()) {
            // Save the meetup

            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text('Successful New Meetup')));
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
