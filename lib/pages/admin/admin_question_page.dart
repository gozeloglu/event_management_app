import 'package:event_management_app/services/question_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuestionListPage extends StatefulWidget {
  QuestionListPage({Key key, this.meetupID}) : super(key: key);

  final String meetupID;

  QuestionListPageState createState() => QuestionListPageState();
}

class QuestionListPageState extends State<QuestionListPage> {
  QuestionService questionService = new QuestionService();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          elevation: 10,
          title: Text("Questions"),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          )),
      body: Center(
        child: FutureBuilder<List<dynamic>>(
          future: questionService.getQuestions(widget.meetupID),
          builder: (context, snapshot) {
            print(snapshot.data == null);
            if (snapshot.hasData) {
              if (snapshot.data.length == 0) {
                return Center(
                  child: Text(
                    "There is no question!",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                );
              }
              List<String> questionList = List();
              List<int> questionIDList = List();

              for (int i = 0; i < snapshot.data.length; i++) {
                questionList.add(snapshot.data[i]["askedQuestion"]);
                questionIDList.add(snapshot.data[i]["id"]);
              }

              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15)),
                      elevation: 5,
                      margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: ListTile(
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _displayQuestionDialog(
                                context, questionIDList[index]);
                          },
                        ),
                        leading: Icon(Icons.comment),
                        subtitle: Text(
                          questionList[index],
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  });
            } else if (snapshot.data == null) {
              return Center(
                child: Text(
                  "There is no question!",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              );
            }
            return Container(
              alignment: Alignment.center,
              height: 160.0,
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Widget noDataMessage() {
    return Center(
      child: Text(
        "There is no question!",
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }

  _displayQuestionDialog(BuildContext context, int questionID) async {
    print(questionID);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Are you sure?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Text("Do you want to delete the question?"),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: new Text(
                    "Cancel",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              new FlatButton(
                  onPressed: () {
                    questionService.deleteQuestion(questionID).then((response) {
                      if (response.statusCode < 400) {
                        final snackBar = SnackBar(
                          content: Text("Question is deleted",
                              style: TextStyle(fontSize: 20)),
                        );
                        _scaffoldKey.currentState.showSnackBar(snackBar);
                        Navigator.pop(context);
                      } else {
                        final snackBar = SnackBar(
                          content: Text("Question could not deleted!",
                              style: TextStyle(fontSize: 20)),
                        );
                        _scaffoldKey.currentState.showSnackBar(snackBar);
                      }
                    }).catchError((onError) {
                      final snackBar = SnackBar(
                        content: Text("Something went wrong!",
                            style: TextStyle(fontSize: 20)),
                      );
                      _scaffoldKey.currentState.showSnackBar(snackBar);
                    });
                  },
                  child: new Text(
                    "Delete",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ))
            ],
          );
        }).then((_) => setState(() {}));
  }
}
