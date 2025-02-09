import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCode extends StatefulWidget {
  QRCode(
      {Key key,
      this.meetupName,
      this.registeredUserCount,
      this.quota,
      this.participantName,
      this.participantLastName})
      : super(key: key);

  final String meetupName;
  final int registeredUserCount;
  final int quota;
  final String participantName;
  final String participantLastName;

  @override
  QRCodeState createState() => QRCodeState();
}

class QRCodeState extends State<QRCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Text("QR Code"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop([false]);
          },
        ),
      ),
      body: Center(
        child: Container(
          child: QrImage(
            data: "Meetup Name: " +
                widget.meetupName +
                "\n" +
                "First Name: " +
                widget.participantName +
                "\n" +
                "Last Name: " +
                widget.participantLastName +
                "\n",
            version: QrVersions.auto,
            size: 320,
            gapless: false,
          ),
        ),
      ),
    );
  }
}
